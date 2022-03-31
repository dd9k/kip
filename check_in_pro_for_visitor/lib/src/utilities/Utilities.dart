import 'dart:async';
import 'dart:convert';
import 'dart:io' show Directory, File, FileMode, Platform;
import 'dart:math';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/model/Authenticate.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/ConfigKiosk.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfo.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/EventDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicketDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/SaverModel.dart';
import 'package:check_in_pro_for_visitor/src/model/SurveyForm.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/saverScreen/SaverScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/ConnectionStatusSingleton.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/QLPrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/XPrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/PermissionCallBack.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:image/image.dart' as imglib;
import '../../main.dart';
import 'AppLocalizations.dart';

class Utilities {
  static final Utilities _singleton = Utilities._internal();

  factory Utilities() {
    return _singleton;
  }

  Utilities._internal();

  Future<bool> isConnectInternet({@required bool isChangeState}) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      printLog("Connection: false");
      return false;
    }
    return await ConnectionStatusSingleton.getInstance().checkConnection(isChangeState: isChangeState);
  }

  bool isStringNullOrEmpty(String myString) {
    return myString == null || myString.isEmpty;
  }

  bool isArrayNullOrEmpty(List list) {
    return list == null || list.isEmpty;
  }

  Future<bool> checkSettingPrinter() async {
    var preferences = await SharedPreferences.getInstance();
    var data = preferences.getString(Constants.KEY_PRINTER);
    if (data == null || data == "") {
      return false;
    }
    return true;
  }

  String createDataQR(String source, String formatQRCode) {
    return jsonEncode(FormatQRCode(formatQRCode, source));
  }

  void printLog(String mess) {
    if (kDebugMode) {
      print(DateTime.now().toString() +": "+mess);
    }
  }

  void tryActionLoadingBtn(RoundedLoadingButtonController controller, BtnLoadingAction action) {
    try {
      switch (action) {
        case BtnLoadingAction.START:
          {
            controller?.start();
            break;
          }
        case BtnLoadingAction.STOP:
          {
            controller?.stop();
            break;
          }
        case BtnLoadingAction.SUCCESS:
          {
            controller?.success();
            break;
          }
      }
    } catch (e) {}
  }

  bool isShowForChatBox(BuildContext context, bool defaultValue) {
    var heightScreen = SizeConfig.safeBlockVertical * 100;
    if (heightScreen > Constants.MIN_HEIGHT) {
      return defaultValue;
    }
    return false;
  }

  Future<String> getToken() async {
    var preferences = await SharedPreferences.getInstance();
    var authentication = preferences.getString(Constants.KEY_AUTHENTICATE) ?? "";
    var token = Authenticate.fromJson(json.decode(authentication)).accessToken;
    return Constants.FIELD_BEARER + token;
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  Future<bool> isHaveSurvey(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    bool checkConfig = (await getConfigKios())?.isSurvey ?? false;
    bool checkType = (await db.visitorTypeDAO.getVisitorTypeBySettingKey(settingKey))?.isSurvey ?? true;
    SurveyForm surveyForm = await Utilities().getSurvey();
    return checkConfig && checkType && (surveyForm?.status ?? false);
//  return true;
  }

  Future<bool> isSurveyCustom(BuildContext context, String settingKey) async {
    SurveyForm surveyForm = await Utilities().getSurvey();
    return await isHaveSurvey(context, settingKey) && surveyForm?.type == SurveyForm.CUSTOM_FORM;
  }

  String convertDateToString(DateTime source, String format) {
    return DateFormat(format).format(source);
  }

  Future<bool> isSurveyCovid(BuildContext context, String settingKey) async {
    SurveyForm surveyForm = await Utilities().getSurvey();
    return await isHaveSurvey(context, settingKey) && surveyForm?.type == SurveyForm.EMBEDDED_LINK;
  }

  Future<String> getToken1() async {
    var preferences = await SharedPreferences.getInstance();
    var authentication = preferences.getString(Constants.KEY_AUTHENTICATE) ?? "";
    var token = Authenticate.fromJson(json.decode(authentication)).accessToken;
    return token;
  }

  Future<bool> checkIsBuilding() async {
    var userInfor = await Utilities().getUserInfor();
    return userInfor?.isBuilding == true && userInfor?.deviceInfo?.branchCode == Constants.HQ_CODE;
  }

  Future<bool> checkIsCapture(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    var preferences = await SharedPreferences.getInstance();
    bool checkPermission = await settingCameraPermission();
    bool checkCameraSetting = preferences.getBool(Constants.KEY_FACE_CAPTURE) ?? true;
    bool checkConfig = (await getConfigKios())?.isTakePicture ?? false;
    bool checkType = (await db.visitorTypeDAO.getVisitorTypeBySettingKey(settingKey))?.isTakePicture ?? true;
    return checkPermission && checkCameraSetting && checkConfig && checkType;
  }

  Future<bool> checkAllowContact(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    bool checkConfig = (await getConfigKios())?.allowToDisplayContactPerson ?? false;
    bool checkType =
        (await db.visitorTypeDAO.getVisitorTypeBySettingKey(settingKey))?.allowToDisplayContactPerson ?? false;
    var preferences = await SharedPreferences.getInstance();
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    bool isConnected = MyApp.of(context).isConnection;
    return checkConfig && checkType && !isEventMode && isConnected;
  }

  Future<bool> checkIsScanId(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    bool checkPermission = await settingCameraPermission();
    bool checkConfig = (await getConfigKios())?.isScanIdCard ?? false;
    bool checkType = (await db.visitorTypeDAO.getVisitorTypeBySettingKey(settingKey))?.isScanIdCard ?? false;
    bool isConnected = MyApp.of(context).isConnection;
    return checkPermission && checkConfig && checkType && isConnected;
  }

  Future<bool> checkIsPrint(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    var preferences = await SharedPreferences.getInstance();
    String printer = preferences.getString(Constants.KEY_PRINTER);
    bool checkPrintSetting = (printer != null && printer.isNotEmpty);
    bool checkConfig = (await getConfigKios())?.isPrintCard ?? false;
    bool checkType = (await db.visitorTypeDAO.getVisitorTypeBySettingKey(settingKey))?.isPrintCard ?? true;
    return checkPrintSetting && checkConfig && checkType;
  }

  List<CheckInFlow> getFlowIDScan(BuildContext context) {
    List<CheckInFlow> list = List();
    var stepNameName =
        Constants.hardCode.replaceAll(Constants.stringReplace, AppLocalizations.of(context).fullNameFlow);
    var stepNameIdCard =
        Constants.hardCode.replaceAll(Constants.stringReplace, AppLocalizations.of(context).idCardFlow);
    list.add(CheckInFlow.hardcode(stepNameName, StepCode.FULL_NAME, StepType.TEXT, 1, "1"));
    list.add(CheckInFlow.hardcode(stepNameIdCard, StepCode.ID_CARD, StepType.TEXT, 1, "2"));
    return list;
  }

  List<CheckInFlow> getFlowDelivery(BuildContext context) {
    List<CheckInFlow> list = List();
    var stepNameGood = Constants.hardCode.replaceAll(Constants.stringReplace, AppLocalizations.of(context).goodFlow);
    var stepNameReceiver =
        Constants.hardCode.replaceAll(Constants.stringReplace, AppLocalizations.of(context).receiverFlow);
    list.add(CheckInFlow.hardcode(stepNameGood, StepCode.GOODS, StepType.TEXT, 1, "1"));
    list.add(CheckInFlow.hardcode(stepNameReceiver, StepCode.RECEIVER, StepType.TEXT, 1, "2"));
    return list;
  }

  getAuthorization() async {
    var preferences = await SharedPreferences.getInstance();
    var authenticationString = preferences.getString(Constants.KEY_AUTHENTICATE) ?? "";
    var authentication = Authenticate.fromJson(json.decode(authenticationString));
    return authentication;
  }

  Future<ConfigKiosk> getConfigKios() async {
    var preferences = await SharedPreferences.getInstance();
    var configKiosString = preferences.getString(Constants.KEY_CONFIG_KIOS) ?? "";
    if (configKiosString.isEmpty) {
      return null;
    }
    var configKios = ConfigKiosk.fromJson(json.decode(configKiosString));
    return configKios;
  }

  Future<SurveyForm> getSurvey() async {
    var preferences = await SharedPreferences.getInstance();
    var surveyString = preferences.getString(Constants.KEY_SURVEY) ?? "";
    if (surveyString.isEmpty) {
      return null;
    }
    var mapSurvey = json.decode(surveyString);
    return SurveyForm.fromJson(mapSurvey);
  }

  Future<UserInfor> getUserInfor() async {
    var preferences = await SharedPreferences.getInstance();
    var userInforString = preferences.getString(Constants.KEY_USER_INFOR) ?? "";
    if (userInforString.isEmpty) {
      return null;
    }
    var userInfor = UserInfor.fromJson(json.decode(userInforString));
    var completer = new Completer<UserInfor>();
    completer.complete(userInfor);
    return completer.future;
  }

  UserInfor getUserInforNew(SharedPreferences preferences) {
    var userInforString = preferences.getString(Constants.KEY_USER_INFOR) ?? "";
    if (userInforString.isEmpty) {
      return null;
    }
    var userInfor = UserInfor.fromJson(json.decode(userInforString));
    return userInfor;
  }

  String getStringByLang(String source, String langSaved) {
    if (source == null || source.isEmpty) {
      return "";
    }
    String langBackUp;
    if (langSaved == Constants.VN_CODE) {
      langBackUp = Constants.EN_CODE;
    } else {
      langBackUp = Constants.VN_CODE;
    }
    try {
      var mapLang = json.decode(source);
      return (mapLang[langSaved] == null || mapLang[langSaved].isEmpty) ? mapLang[langBackUp] : mapLang[langSaved];
    } catch (e) {
      return "";
    }
  }

  String validateJson(String source) {
    try {
      var mapLang = json.decode(source);
      if ((mapLang[Constants.VN_CODE] == null || mapLang[Constants.VN_CODE].isEmpty)) {
        mapLang[Constants.VN_CODE] = mapLang[Constants.EN_CODE] ?? "";
      }
      if ((mapLang[Constants.EN_CODE] == null || mapLang[Constants.EN_CODE].isEmpty)) {
        mapLang[Constants.EN_CODE] = mapLang[Constants.VN_CODE] ?? "";
      }
      return json.encode(mapLang);
    } catch (e) {
      return source;
    }
  }

  void showErrorPop(BuildContext context, String message, int autoHide, Function callBack, {Function callbackDismiss}) {
    Utilities().showOneButtonDialog(
        context,
        DialogType.ERROR,
        autoHide,
        AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
        message,
        AppLocalizations.of(context).translate(AppString.BUTTON_CLOSE), () {
      if (callBack != null) {
        callBack();
      } else if (callbackDismiss != null) {
        callbackDismiss();
      }
    }, callbackDismiss: () {
      callbackDismiss();
    });
  }

  void showErrorPopNo(BuildContext context, String message, int autoHide, {Function callbackDismiss}) {
    Utilities().showNoButtonDialog(context, false, DialogType.ERROR, autoHide,
        AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION), message, () {
      callbackDismiss();
    });
  }

  void showTwoButtonDialog(BuildContext context, DialogType type, int autoHide, String title, String content,
      String textLeft, String textRight, Function leftCallback, Function rightCallBack) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: type,
        animType: AnimType.SCALE,
        title: title,
        desc: content,
        autoHide: autoHide,
        dismissOnTouchOutside: false,
        btnOkText: textRight,
        isDense: true,
        btnOkOnPress: rightCallBack,
        btnCancelText: textLeft,
        callBackWhenHide: leftCallback,
        btnCancelOnPress: leftCallback)
      ..show();
  }

  void popupAndSignOut(BuildContext context, CancelableOperation cancelableLogout, String message) {
    var timer = Timer(Duration(seconds: 10), () {
      locator<NavigationService>().navigatePop(context);
      doLogout(context, cancelableLogout);
    });
    Utilities().showOneButtonDialog(
      context,
      DialogType.INFO,
      null,
      AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
      message,
      AppLocalizations.of(context).btnOk,
      () async {
        timer.cancel();
        doLogout(context, cancelableLogout);
      },
    );
  }

  Future<List<PrinterModel>> findAllPrinter() async {
    List<PrinterModel> list = List();
    var listQL = await QLPrinterModel.init().findPrinter();
    if (Platform.isAndroid) {
      var xPrinter = XPrinterModel.init();
      xPrinter.setListAlready(listQL);
      var listXPrinter = await xPrinter.findPrinter();
      list.addAll(listXPrinter);
    }
    list.addAll(listQL);
    await Future.forEach(list, (element) async {
      if (await element.checkPrinterConnect()) {
        if (element.type == PrinterType.X_PRINTER) {
          await element.connectPrinter();
        }
        element.isConnect = true;
        return;
      }
    });
    return list;
  }

  Future<bool> getDefaultLang(BuildContext context) async {
    var userInfor = await Utilities().getUserInfor();
    var lang = userInfor?.companyLanguage?.elementAt(0)?.languageCode ?? Constants.EN_CODE;
    if (!Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.KEY_LANGUAGE, lang);
    return await AppLocalizations.of(context).load(Locale(lang));
  }

  Future<PrinterModel> getPrinter() async {
    PrinterModel printerModel;
    var preferences = await SharedPreferences.getInstance();
    var saveData = preferences.getString(Constants.KEY_PRINTER);
    if (saveData != null && saveData.isNotEmpty) {
      var map = jsonDecode(saveData);
      switch (map["type"]) {
        case PrinterType.BROTHER:
          {
            printerModel = QLPrinterModel.fromJson(map);
            break;
          }
        case PrinterType.X_PRINTER:
          {
            printerModel = XPrinterModel.fromJson(map);
            break;
          }
      }
    }
    var doublePrint = preferences.getBool(Constants.KEY_DOUBLE_PRINT) ?? false;
    printerModel?.numberOfCopy = doublePrint ? 2 : 1;
    return printerModel;
  }

  Future<int> getMemoryInformation() async {
    try {
      var result = await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.MEMORY_METHOD);
      return (result / Constants.B_TO_GB).round();
    } on PlatformException catch (e) {
      return 0;
    }
  }

  Future<bool> checkFaceDetect() async {
    var memory = await Utilities().getMemoryInformation();
    if ((Platform.isAndroid && memory >= Constants.MIN_RAM_ANDROID) ||
        (Platform.isIOS && memory >= Constants.MIN_RAM_IOS)) {
      return true;
    }
    return false;
  }

  Future<bool> setKioskMode(bool enable) async {
    if (Platform.isAndroid) {
      if (enable) {
        return await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.ENABLE_LOCK_METHOD);
      }
      return await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.DISABLE_LOCK_METHOD);
    }
    return false;
  }

  Future<bool> isLauncher() async {
    if (Platform.isAndroid) {
      return await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.ACTION_IS_LAUNCHER);
    }
    return false;
  }

  Future<bool> goHome() async {
    if (Platform.isAndroid) {
      return await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.ACTION_GO_HOME);
    }
    return false;
  }

  Future<bool> getKioskMode() async {
    if (Platform.isAndroid) {
      return await Constants.HARDWARE_CHANNEL.invokeMethod(Constants.ACTION_IS_LOCK);
    }
    return false;
  }

  Future<void> doLogout(BuildContext context, CancelableOperation cancelableOperation) async {
    var authorization = await Utilities().getAuthorization();
    var refreshToken = (authorization as Authenticate).refreshToken;
    var deviceInfor = await Utilities().getDeviceInfo();
    var prefer = await SharedPreferences.getInstance();
    var firebase = prefer.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    ApiRequest().requestUpdateStatus(context, Constants.STATUS_OFFLINE, null);

    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
//      await locator<SignalRService>().stopSignalR();
      await handlerLogout();
    }, (Errors message) async {
//      await locator<SignalRService>().stopSignalR();
      if (message.code != -2) {
        await handlerLogout();
      }
    });

    cancelableOperation =
        await ApiRequest().requestLogout(context, deviceInfor.identifier, refreshToken, firebase, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future handlerLogout() async {
    var preferences = await SharedPreferences.getInstance();
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    var savedIdentifier = preferences.getString(Constants.KEY_IDENTIFIER) ?? "";
    var savedCompanyId = preferences.getDouble(Constants.KEY_COMPANY_ID);
    var user = preferences.getString(Constants.KEY_USER) ?? "";
    var domain = preferences.getString(Constants.KEY_DOMAIN) ?? "";
    preferences.clear();
    preferences.setString(Constants.KEY_LANGUAGE, langSaved);
    preferences.setString(Constants.KEY_FIREBASE_TOKEN, firebase);
    preferences.setInt(Constants.KEY_DEV_MODE, index);
    preferences.setBool(Constants.KEY_IS_LAUNCH, false);
    preferences.setString(Constants.KEY_IDENTIFIER, savedIdentifier);
    preferences.setDouble(Constants.KEY_COMPANY_ID, savedCompanyId);
    preferences.setString(Constants.KEY_USER, user);
    preferences.setString(Constants.KEY_DOMAIN, domain);
    locator<NavigationService>().navigateTo(DomainScreen.route_name, 3);
    Utilities().cancelWaiting();
  }

  void showOneButtonDialog(BuildContext context, DialogType type, int autoHide, String title, String content,
      String textButton, Function callBack,
      {Function callbackDismiss}) {
    AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        dialogType: type,
        customHeader: null,
        animType: AnimType.SCALE,
        title: title,
        desc: content,
        autoHide: autoHide,
        dismissOnTouchOutside: false,
        btnOkText: textButton,
        btnOkOnPress: callBack,
        callBackWhenHide: callBack,
        onDissmissCallback: callbackDismiss)
      ..show();
  }

  AwesomeDialog showNoButtonDialog(BuildContext context, bool isShowImage, DialogType type, int autoHide, String title,
      String content, Function callBackWhenHide) {
    return AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      dialogType: type,
      animType: AnimType.SCALE,
      title: title,
      desc: content,
      autoHide: autoHide,
      isShowImage: isShowImage,
//      callBackWhenHide: callBackWhenHide,
      onDissmissCallback: callBackWhenHide,
      dismissOnTouchOutside: true,
    )..show();
  }

  String noPassError = "";
  String wrongError = "";
  String passwordSaved = "";

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return noPassError;
    }
    if (value != passwordSaved) {
      return wrongError;
    }
    return null;
  }

  void showConfirmPassWord(
      BuildContext context,
      String title,
      String content,
      String hint,
      String textButton,
      GlobalKey<FormState> passwordKey,
      TextEditingController controller,
      RoundedLoadingButtonController btnController,
      Function callBack,
      Function callBackClick) async {
    noPassError = AppLocalizations.of(context).noPassword;
    wrongError = AppLocalizations.of(context).wrongPassword;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Random random = new Random();
    int randomNumber = random.nextInt(Constants.MAX_INT);
    passwordSaved = prefs.get(Constants.KEY_PASSWORD) ?? randomNumber.toString();
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    SizeConfig().init(context);
    int sizeRenderWidth = isPortrait ? 40 : 30;
    int sizeRenderHeight = isPortrait ? 17 : 22;

    var alert = MyDialog(
      title: title,
      sizeRenderWidth: sizeRenderWidth,
      sizeRenderHeight: sizeRenderHeight,
      controller: controller,
      callBack: callBack,
      hint: hint,
      passwordKey: passwordKey,
      textButton: textButton,
      btnController: btnController,
    );

    // show the dialog
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) => callBackClick());
  }

  Future<String> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}_${packageInfo.buildNumber}";
  }

  void hideKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static Future<bool> requestPermission(BuildContext context, List<PermissionGroup> permissions,
      PermissionCallBack permissionCallBack, bool isJustCheck, bool iOSPermission) async {
    var isDenied = false;
    List<PermissionGroup> permissionDeny = List();
    for (final permission in permissions) {
      var status = await PermissionHandler().checkPermissionStatus(permission);
      if (status != PermissionStatus.granted) {
        if (status == PermissionStatus.disabled) {
          permissionCallBack.onDisable();
          return false;
        } else {
          if (!isJustCheck) {
            await PermissionHandler().requestPermissions([permission]);
            var status = await PermissionHandler().checkPermissionStatus(permission);
            if (status != PermissionStatus.granted) {
              permissionDeny.add(permission);
            }
          } else {
            if (!isDenied) {
              isDenied = true;
              permissionCallBack.onDeny();
              return false;
            }
          }
        }
      }
    }
    if (permissionDeny.isNotEmpty || !iOSPermission) {
      var isNoShowAgain = true;
      for (var element in permissionDeny) {
        isNoShowAgain = await PermissionHandler().shouldShowRequestPermissionRationale(element);
        if (!isNoShowAgain) break;
      }
      var mess = (Platform.isAndroid)
          ? AppLocalizations.of(context).noPermissionAndroid
          : AppLocalizations.of(context).noPermissionIOS;
//      Utilities().showTwoButtonDialog(
//          context,
//          DialogType.WARNING,
//          null,
//          AppLocalizations.of(context).noPermissionTitle,
//          mess,
//          AppLocalizations.of(context).btnSkip,
//          AppLocalizations.of(context).btnOpenSetting, () async {
//        permissionCallBack.onAllow();
//      }, () {
//        AppSettings.openAppSettings();
//      });
      permissionCallBack.onAllow();
      return false;
    } else {
      permissionCallBack.onAllow();
      return true;
    }
  }

  Future<bool> settingCameraPermission() async {
    List<PermissionGroup> permissions = List();
    permissions.add(PermissionGroup.camera);
    if (Platform.isAndroid) {
      permissions.add(PermissionGroup.storage);
    }
    var permissionCallBack = PermissionCallBack(() async {}, () {}, () {});
    bool isAllow = await Utilities.requestPermission(null, permissions, permissionCallBack, true, true);
    if (!isAllow) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(Constants.KEY_FACE_CAPTURE, false);
    }
    return isAllow;
  }

  Future<bool> checkCameraPermission() async {
    List<PermissionGroup> permissions = List();
    permissions.add(PermissionGroup.camera);
    var permissionCallBack = PermissionCallBack(() async {}, () {}, () {});
    bool isAllow = await Utilities.requestPermission(null, permissions, permissionCallBack, true, true);
    return isAllow;
  }

  static String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  static String titleCase(String str) =>
      str?.split(' ')?.map((word) => word[0].toUpperCase() + word.substring(1))?.join(' ') ?? "";

  Future<DeviceInfo> getDeviceInfo() async {
    var data = DeviceInfo();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var savedIdentifier = prefs.getString(Constants.KEY_IDENTIFIER) ?? "";
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      data.model = androidInfo.model;
      data.deviceName = androidInfo.model;
      if (savedIdentifier.isNotEmpty) {
        data.identifier = savedIdentifier;
      } else {
        data.identifier = androidInfo.androidId;
        prefs.setString(Constants.KEY_IDENTIFIER, androidInfo.androidId);
      }
      data.osVersion = androidInfo.version.release;
    }
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      data.model = iosInfo.utsname.machine;
      data.deviceName = iosInfo.name;
      if (savedIdentifier.isNotEmpty) {
        data.identifier = savedIdentifier;
      } else {
        data.identifier = await savedIOSIdentifier(Constants.KEY_IDENTIFIER ,iosInfo.identifierForVendor);
        prefs.setString(Constants.KEY_IDENTIFIER, data.identifier);
      }
      data.osVersion = iosInfo.systemVersion;
    }
    return data;
  }

  Future<String> savedIOSIdentifier(String key, String deviceId) async {
    // Create storage
    final storage = new FlutterSecureStorage();
    // Read value
    String value = await storage.read(key: key);
    if (value == null || value.isEmpty) {
      // Write value
      await storage.write(key: key, value: deviceId);
      return deviceId;
    } else {
      return value;
    }
  }

  Timer timeoutToWaiting;
  int timeExpired = 0;

  void cancelWaiting() {
    timeoutToWaiting?.cancel();
    timeOutController?.close();
    Utilities().printLog("cancelWaiting cancelWaiting");
  }

  bool checkExpiredEvent(bool isEventMode, EventDetail eventDetail) {
    if (isEventMode) {
      var now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
      var endDate = eventDetail?.endDate ?? now;
      return endDate - now <= 0;
    }
    return false;
  }

  bool checkExpiredEventTicket(bool isEventMode, EventTicket eventDetail) {
    try {
      if (isEventMode) {
        var now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
        var endDate = DateTime.parse(eventDetail?.endDate ?? DateTime.now().toString()).toUtc().millisecondsSinceEpoch / 1000;
        return endDate - now <= 0;
      }
    } catch(e) {
      return false;
    }
    return false;
  }

  Future<void> actionAfterExpired(BuildContext context, Function callBack) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.KEY_EVENT, false);
    prefs.setDouble(Constants.KEY_EVENT_ID, null);
    prefs.setDouble(Constants.KEY_EVENT_TICKET_ID, null);
    var db = Provider.of<Database>(context, listen: false);
    await db.eventDetailDAO.deleteAll();
    await db.eTOrderDetailInfoDAO.deleteAll();
    await db.eTOrderInfoDAO.deleteAll();
    await db.eventTicketDAO.deleteAll();
    prefs.setBool(Constants.KEY_SYNC_EVENT, false);
    Utilities().showErrorPop(context, AppLocalizations.of(context).eventExpired, null, callBack);
  }

  var isTimeOut = false;

  void moveToWaiting() async {
    if (!isTimeOut) {
      isTimeOut = true;
      Utilities().printLog("moveToWaiting");
      if (timeoutToWaiting != null) {
        timeoutToWaiting.cancel();
      }
      var userInfor = await getUserInfor();
      int timeOut = (userInfor == null || userInfor?.deviceInfo?.timeout == null)
          ? Constants.TIMEOUT_DEFAULT
          : userInfor.deviceInfo.timeout;
      if (timeOutController.isClosed) {
        timeOutController = BehaviorSubject<int>();
      }
      timeOutController.sink.add(timeOut);
      timeoutToWaiting = Timer.periodic(Duration(seconds: 1), (timer) {
        Utilities().printLog("timeOut $timeOut run ${timer.tick}");
        if (timer.tick == timeOut) {
          Utilities().printLog("moveToWaiting cancel");
          timer.cancel();
          locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
        }
      });
      isTimeOut = false;
    }
  }

  var isSaver = false;
  var isSaverCancel = false;
  Timer timeToSaver;

  void moveToSaver(BuildContext context, SaverModel saverModel, List<String> imageBackground, String lang, String companyNameColor, Database db, Function callBack) async {
    var route = ModalRoute.of(context);
    if (!isSaverCancel && !isSaver && route?.isCurrent == true) {
      isSaver = true;
      timeToSaver?.cancel();
      List<String> listImage = List();
      if (saverModel?.images?.isEmpty == true) {
        if (imageBackground?.isNotEmpty == true) {
          listImage.addAll(imageBackground);
        }
      } else {
        for( var index = 0; index < saverModel.images.length; index++) {
          String name = (await db.imageDownloadedDAO.getByLink(saverModel.images[index]))?.localPath;
          String localPath = await getLocalPathFile(Constants.FOLDER_TEMP, Constants.FILE_TYPE_IMAGE_SAVER, name, null);
          if (localPath != null) {
            listImage.add(localPath);
          }
        }
      }
      timeToSaver = Timer(Duration(seconds: saverModel.timeout), () async {
        if (route?.isCurrent == true) {
          locator<NavigationService>().navigateTo(SaverScreen.route_name, 1, arguments: {
            "listImage": listImage,
            "lang" : lang,
            "companyNameColor": companyNameColor
          }).then((value) async {
            callBack(saverMess: value);
          });
        }
      });
      isSaver = false;
    }
  }

  void cancelMoveToSaver() {
    timeToSaver?.cancel();
  }

  void stopSaver() {
    isSaverCancel = true;
    timeToSaver?.cancel();
  }

  void startSaver() {
    isSaverCancel = false;
  }

  int currentStep = 0;

  List<String> step = List();

  void nextStep() {
    if (step.isNotEmpty) {
      currentStep++;
    }
  }

  void previousStep() {
    if (step.isNotEmpty) {
      currentStep--;
    }
  }

  void clearStep() {
    step.clear();
    currentStep = 0;
  }

  void createStep(BuildContext context, bool isType, bool isBuilding, bool isScanId, bool isAllowContact, bool isSurvey,
      bool isHaveAlways, bool isReturn, bool isCapture) {
    clearStep();
    if (isBuilding) {
//      step.add(AppLocalizations.of(context).titleStepCompany);
      step.add("");
      currentStep++;
    }
    if (isType) {
      step.add("");
    }
//    step.add(AppLocalizations.of(context).titleStepDetect);
    if (isScanId) {
      step.add("");
      currentStep++;
//      step.add(AppLocalizations.of(context).titleStepScan);
    }
    if (isAllowContact) {
      step.add("");
//      step.add(AppLocalizations.of(context).titleStepContact);
    }
    if (isSurvey) {
      step.add("");
//      step.add(AppLocalizations.of(context).titleStepContact);
    }
    if (isHaveAlways || !isReturn) {
      step.add("");
//      step.add(AppLocalizations.of(context).titleStepInput);
    }
    if (isCapture) {
      step.add("");
//      step.add(AppLocalizations.of(context).titleStepPhoto);
    }
    step.add("");
//    step.add(AppLocalizations.of(context).titleStepDone);
  }

  StreamController<int> timeOutController = BehaviorSubject<int>();

  Stream<int> getTimeExpired() {
    return timeOutController.stream;
  }

  Timer timeoutToResetApp;

  void countDownToResetApp(int timeBackground, BuildContext context) async {
    timeoutToResetApp?.cancel();
    var timeReset = Constants.TIMEOUT_RESET - timeBackground;
    timeoutToResetApp = Timer(Duration(hours: timeReset), () {
      refreshToken(context);
//      locator<NavigationService>()
//          .navigateTo(SplashScreen.route_name, 3, false);
    });
  }

  Future<CancelableOperation<dynamic>> refreshToken(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();
    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      var authenticationString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_AUTHENTICATE, authenticationString);
    }, (Errors message) {
      if (message.code != -2 && message.code == -401) {
        CancelableOperation cancelableLogout;
        Utilities().popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).expiredToken);
      }
    });
    var authorization = await Utilities().getAuthorization();
    var token = (authorization as Authenticate).refreshToken;
    await ApiRequest().requestRefreshTokenApi(context, firebaseId, token, listCallBack);
    countDownToResetApp(0, context);
  }

  var isSync = true;

  void checkAndSync(BuildContext context) async {
//    var dateTime = DateTime.now();
//    var prefer = await SharedPreferences.getInstance();
//    var lastTime = prefer.getInt(Constants.KEY_LAST_SYNC) ??
//        dateTime.millisecondsSinceEpoch;
//    var isAfter =
//        dayAfterDay(dateTime, DateTime.fromMillisecondsSinceEpoch(lastTime));
//    print(
//        "checkAndSync......isAfter $isAfter lastTime ${DateTime.fromMillisecondsSinceEpoch(lastTime).toString()} dateTime ${dateTime.toString()}");
//    if (isAfter) {
//      print("syncAllLog isAfter");
//      isSync = true;
//      locator<SyncService>().syncAllLog(context);
//    } else if (dateTime.hour >= Constants.TIME_TO_SYNC && isSync) {
//      print("syncAllLog dateTime.hour");
//      isSync = false;
//      locator<SyncService>().syncAllLog(context);
//    }
  }

  Future printJob(PrinterModel printer, RenderRepaintBoundary boundary) async {
    var status;
    int countFail = 0;
    while (status != Constants.STATUS_SUCCESS && countFail <= 3) {
      status = await printer.printTemplate(boundary);
      countFail++;
    }
  }

  bool dayAfterDay(DateTime now, DateTime dateAfter) {
    var convertNow = DateTime(now.year, now.month, now.day);
    var convertAfter = DateTime(dateAfter.year, dateAfter.month, dateAfter.day);
    if (convertNow.compareTo(convertAfter) > 0) {
      return true;
    }
    return false;
  }

  Future<String> getTypeInDb(BuildContext context, String settingKey) async {
    var db = Provider.of<Database>(context, listen: false);
    var list = await db.visitorTypeDAO.getAlls();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var langSaved = prefs.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    var type = Constants.VT_VISITORS;
    await Future.forEach(list, (VisitorType element) {
      if (element?.settingKey != null &&
          settingKey != null &&
          element.settingKey.toLowerCase() == settingKey.toLowerCase()) {
        type = element.settingValue.getValue(langSaved);
      }
    });
    return type;
  }

  Future<String> localPath(String folderName) async {
    Directory root;
    if (Platform.isAndroid) {
      root = await getApplicationSupportDirectory();
    } else {
      root = await getApplicationDocumentsDirectory();
    }
    if (folderName == null || folderName.isEmpty) {
      return root.path;
    }
    Directory directory = Directory("${root.path}/$folderName");
    if (!(await directory.exists())) {
      await directory.create();
    }
    return directory.path;
  }

  Future<String> localPathDB(String folderName) async {
    Directory root;
    root = await getApplicationDocumentsDirectory();
    if (folderName == null || folderName.isEmpty) {
      return root.path;
    }
    Directory directory = Directory("${root.path}/$folderName");
    if (!(await directory.exists())) {
      await directory.create();
    }
    return directory.path;
  }

  Future<File> getLocalFile(String folderName, String type, String name, String extension) async {
    try {
      final path = await localPath(folderName);
      var namePrefix = name;
      if (type == Constants.FILE_TYPE_LOGO_COMPANY) {
        var preferences = await SharedPreferences.getInstance();
        var prefix = preferences.getString(Constants.KEY_IMAGE_PREFIX) ?? "";
        if (name == "1") {
          prefix = preferences.getString(Constants.KEY_IMAGE_PREFIX_1) ?? "";
        }
        namePrefix = name + prefix;
      }
      return (extension == null) ? File('$path/$type$namePrefix') : File('$path/$type$namePrefix.$extension');
    } catch (e) {
      Utilities().printLog(e);
      return null;
    }
  }

  Future<String> getLocalPathFile(String folderName, String type, String name, String extension) async {
    final path = await localPath(folderName);
    var namePrefix = name;
    if (type == Constants.FILE_TYPE_LOGO_COMPANY) {
      var preferences = await SharedPreferences.getInstance();
      var prefix = preferences.getString(Constants.KEY_IMAGE_PREFIX) ?? "";
      if (name == "1") {
        prefix = preferences.getString(Constants.KEY_IMAGE_PREFIX_1) ?? "";
      }
      namePrefix = name + prefix;
    }
    return (extension == null) ? '$path/$type$namePrefix' : '$path/$type$namePrefix.$extension';
  }

  Future<List<int>> rotateAndResize(String path) async {
    var file = File(path);
    List<int> imageBytes = file.readAsBytesSync();
    if (imageBytes.length > Constants.LIMIT_IMAGE_SIZE) {
      int percent = ((Constants.LIMIT_IMAGE_SIZE / imageBytes.length) * 100).toInt();
      imageBytes = await FlutterImageCompress.compressWithList(imageBytes, quality: percent, keepExif: true);
      await Utilities().saveLocalFileWithPath(path, imageBytes);
    }
    var image = await FlutterExifRotation.rotateImage(path: path);
    List<int> newBytes = image.readAsBytesSync();
    return newBytes;
  }

  Future<File> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    return await File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<File> saveLocalFile(String folderName, String type, String name, String extension, List<int> file) async {
    try {
      final path = await localPath(folderName);
      var namePrefix = name;
      if (type == Constants.FILE_TYPE_LOGO_COMPANY) {
        var preferences = await SharedPreferences.getInstance();
        var saved = preferences.getString(Constants.KEY_IMAGE_PREFIX) ?? "";
        if (name == "1") {
          saved = preferences.getString(Constants.KEY_IMAGE_PREFIX_1) ?? "";
        }
        namePrefix = name + saved;
        var pathFile = (extension == null) ? ('$path/$type$namePrefix') : ('$path/$type$namePrefix.$extension');
        var fileSave = new File(pathFile);
        await deleteFile(fileSave);
        final date = DateTime.now().millisecondsSinceEpoch.toString();
        if (name == "1") {
          preferences.setString(Constants.KEY_IMAGE_PREFIX_1, date);
        } else {
          preferences.setString(Constants.KEY_IMAGE_PREFIX, date);
        }
        namePrefix = name + date;
      }
      var pathFile = (extension == null) ? ('$path/$type$namePrefix') : ('$path/$type$namePrefix.$extension');
      var fileSave = new File(pathFile);
      // Write the file
      return await fileSave.writeAsBytes(file);
    } catch (e) {
      Utilities().printLog(e.toString());
      return null;
    }
  }

  Future<File> saveLocalFileWithPath(String path, List<int> file) async {
    try {
      var fileSave = new File(path);
      // Write the file
      return await fileSave.writeAsBytes(file);
    } catch (e) {
      Utilities().printLog(e);
      return null;
    }
  }

  void writeLog(String text) async {
//    compute(writeLogInBack, text);
//   writeLogInBack(text);
  }

  Future<Map<String, dynamic>> jsonDecodeInBack(String text) {
    compute(jsonDecode, text);
  }

  void jsonEncodeInBack(Map<String, dynamic> map) async {
    compute(jsonEncode, map);
  }

  List<String> getTimeFormat(BuildContext context, String lang) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    var date = DateTime.now();
    if (!is24HoursFormat) {
      return DateFormat(Constants.TIME_FORMAT_12_EN, lang).format(date).split(" ");
    }
    return DateFormat(Constants.TIME_FORMAT_24).format(date).split(" ");
  }

  void writeLogInBack(String text) async {
    var path;
    path = await localPath("");
    final File file = File('$path/my_log.txt');
//    var logOld = await readLog();
    var logNew = "\n" + "${DateTime.now().toString()} $text";
    await file.writeAsString(logNew, mode: FileMode.append);
  }

  Future<String> readLog() async {
    String text = "";
    try {
      var path;
      path = await localPath("");
      final File file = File('$path/my_log.txt');
      if (await file.exists()) {
        text = await file.readAsString();
      } else {
        text = "empeydadadd";
      }
    } catch (e) {
      return "cachachahc";
    }
    return text;
  }

  Future<void> deleteFile(File fileSave) async {
    if (fileSave != null && fileSave.existsSync()) {
      await fileSave?.delete(recursive: true);
      fileSave.existsSync();
    }
  }

  Future<File> fixExifRotation(String imagePath) async {
    final originalFile = File(imagePath);
    List<int> imageBytes = await originalFile.readAsBytes();
    final originalImage = imglib.decodeImage(imageBytes);
    imglib.Image fixedImage;
    fixedImage = imglib.copyRotate(originalImage, 270);
    final fixedFile = await originalFile.writeAsBytes(imglib.encodeJpg(fixedImage));
    return fixedFile;
  }
}

class MyDialog extends StatefulWidget {
  final String title;
  final int sizeRenderWidth;
  final int sizeRenderHeight;
  final GlobalKey<FormState> passwordKey;
  final TextEditingController controller;
  final Function callBack;
  final String hint;
  final String textButton;
  final RoundedLoadingButtonController btnController;

  const MyDialog(
      {Key key,
      this.title,
      this.sizeRenderWidth,
      this.sizeRenderHeight,
      this.callBack,
      this.hint,
      this.textButton,
      this.passwordKey,
      this.controller,
      this.btnController})
      : super(key: key);

  @override
  _MyDialogState createState() => new _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool isShowPass = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppDestination.RADIUS_TEXT_INPUT))),
      title: Align(
        alignment: Alignment.topCenter,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: AppDestination.TEXT_BIG, decoration: TextDecoration.none),
        ),
      ),
      content: SingleChildScrollView(child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            width: SizeConfig.blockSizeHorizontal * widget.sizeRenderWidth,
            height: SizeConfig.safeBlockVertical * widget.sizeRenderHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: widget.passwordKey,
                  child: Container(
                    height: SizeConfig.safeBlockVertical * (widget.sizeRenderHeight / 2),
                    child: TextFormField(
                        validator: Utilities().validateConfirmPassword,
                        obscureText: !isShowPass,
                        controller: widget.controller,
                        onEditingComplete: widget.callBack,
                        textInputAction: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(100),
                        ],
                        decoration: new InputDecoration(
                          hintText: widget.hint,
                          labelText: widget.hint,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isShowPass ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                              });
                            },
                          ),
                          hintStyle: TextStyle(fontSize: 15, color: AppColor.HINT_TEXT_COLOR),
                          labelStyle: TextStyle(fontSize: 15, color: AppColor.MAIN_TEXT_COLOR),
                        ),
                        onChanged: null,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
                RaisedGradientButton(
                    disable: false,
                    isLoading: true,
                    btnController: widget.btnController,
                    btnText: widget.textButton,
                    onPressed: widget.callBack,
                    height: SizeConfig.safeBlockVertical * (widget.sizeRenderHeight / 3)),
              ],
            ),
          );
        },
      )),
    );
  }
}

class AutoCapWordsInputFormatter extends TextInputFormatter {
  final RegExp capWordsPattern = new RegExp(r'(\S)(\S*\s*)');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText =
        capWordsPattern.allMatches(newValue.text).map((match) => match.group(1).toUpperCase() + match.group(2)).join();
    return new TextEditingValue(
      text: newText,
      selection: newValue.selection ?? const TextSelection.collapsed(offset: -1),
      composing: newText == newValue.text ? newValue.composing : TextRange.empty,
    );
  }
}

class UpperCaseFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: toBeginningOfSentenceCase(newValue.text),
      selection: newValue.selection,
    );
  }
}
