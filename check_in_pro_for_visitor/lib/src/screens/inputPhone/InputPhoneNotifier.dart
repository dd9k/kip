import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputPhoneNotifier extends MainNotifier {
  bool isEventMode = false;
  bool isLoadCamera = false;
  bool isShowClear = false;
  bool isLoading = false;
  bool isShowLogo = true;
  String inviteCode;
  bool isDelivery = false;
  bool isReturn = false;
  CancelableOperation cancelSearch;
  CancelableOperation cancelSearchCode;
  CancelableOperation cancelGetFlow;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  String qrCodeStr;
  bool isShowPhone = true;
  String titleType = "";
  VisitorType visitorType;
  int isSelectedType = 0;
  List<VisitorType> listType = List();
  AsyncMemoizer<List<CheckInFlow>> memCache = AsyncMemoizer();
  List<CheckInFlow> flows = List();
  QRViewController controller;
  bool isScanned = false;
  var isScanIdCard = false;
  var haveType = false;
  String phone = "";
  VisitorCheckIn visitorBackup;

  void showClear(bool isShow) {
    isShowClear = isShow;
    notifyListeners();
  }

  Future<void> startStream(BuildContext context) async {
    controller.scannedDataStream.listen((scanData) async {
      if (this.controller != null && !isScanned) {
        this.isScanned = true;
        this.controller.pauseCamera();
        getDataFromQR(scanData.code);
        await Future.delayed(const Duration(milliseconds: 500));
        this.controller.resumeCamera();
      }
    });
  }

  void getDataFromQR(String scanData) {
    try {
      FormatQRCode formatQRCode = FormatQRCode.fromJson(jsonDecode(scanData));
      qrCodeStr = formatQRCode.data;
      notifyListeners();
      utilities.tryActionLoadingBtn(btnController, BtnLoadingAction.START);
    } catch (e) {
      isLoading = false;
      utilities.tryActionLoadingBtn(btnController, BtnLoadingAction.STOP);
      utilities.showErrorPopNo(context, appLocalizations.invalidQR, Constants.AUTO_HIDE_LESS, callbackDismiss: () {
        this.isScanned = false;
        this.qrCodeStr = '';
        utilities.moveToWaiting();
      });
    }
  }

  Future<void> updateType(BuildContext context, VisitorType visitorType) async {
    this.visitorType = visitorType;
    this.isSelectedType++;
    isScanIdCard = await Utilities().checkIsScanId(context, visitorType.settingKey);
    if (isScanIdCard) {
      this.isShowPhone = false;
      notifyListeners();
      var visitor = getVisitorType(visitorBackup);
      moveToNextScreen(context, visitor, HomeNextScreen.SCAN_ID, true, true);
    } else {
      Utilities().moveToWaiting();
      this.isShowPhone = true;
      notifyListeners();
    }
  }

  Future<List<CheckInFlow>> getInitValue(BuildContext context) async {
    return memCache.runOnce(() async {
      var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      listType = await db.visitorTypeDAO.getAlls();
      haveType = (arguments["haveType"] as bool) ?? false;
      visitorBackup = arguments["visitor"] as VisitorCheckIn;
      var templateCode;
      if (haveType) {
        templateCode = visitorBackup.visitorType;
      } else {
        listType.removeWhere((element) => element.settingKey == TypeVisitor.DELIVERY);
        if (!Constants.LIST_LANG.contains(langSaved)) {
          langSaved = Constants.EN_CODE;
        }
        listType.forEach((element) {
          element.description = element.settingValue.getValue(langSaved);
        });
        templateCode = (listType != null && listType.isNotEmpty) ? listType[0].settingKey : TemplateCode.VISITOR;
        var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
        if (isEventMode) {
          templateCode = TemplateCode.EVENT;
        }
      }
      flows = await db.checkInFlowDAO.getbyTemplateCode(templateCode);
      flows.forEach((element) {
        var mapLang = json.decode(element.stepName);
        element.stepName = mapLang[langSaved];
      });
      isScanIdCard = await Utilities().checkIsScanId(context, templateCode);
      isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
      if (isShowVisitorType()) {
        isShowPhone = false;
      }
      return flows;
    });
  }

  bool isShowVisitorType() {
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    bool isHaveVisitorType = false;
    flows.forEach((CheckInFlow element) {
      if (element.stepCode == StepCode.VISITOR_TYPE) {
        isHaveVisitorType = true;
        titleType = Utilities.titleCase(element.stepName);
      }
    });
    return (listType.length >= 2) && !isEventMode && isHaveVisitorType && !isDelivery && !haveType;
  }

  Future searchVisitor(BuildContext context, String phone) async {
    isLoading = true;
    notifyListeners();
    if (parent.isConnection && !isEventMode) {
      await searchVisitorOnline(context);
    } else {
      await searchVisitorOffline(context);
    }
  }

  Future searchVisitorOffline(BuildContext context) async {
    var userInfor = await Utilities().getUserInfor();
    var visitor = await db.visitorCheckInDAO.getByPhoneNumber(phone, userInfor.companyInfo.id);
//    var temp = await db.visitorCheckInDAO.getAlls();
    if (visitor == null) {
      isReturn = false;
      await getCheckInFlow(context, visitorBackup);
    } else {
      isReturn = true;
      initDataBackup(visitor);
      await getCheckInFlow(context, visitor);
    }
  }

  void initDataBackup(VisitorCheckIn visitor) {
    visitor.toCompany = visitorBackup.toCompany;
    visitor.toCompanyId = visitorBackup.toCompanyId;
    visitor.contactPersonId = visitorBackup.contactPersonId;
    visitor.floor = visitorBackup.floor;
    visitor.visitorType = visitorBackup.visitorType;
  }

  Future searchVisitorOnline(BuildContext context) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      if (baseResponse.data == null) {
        isReturn = false;
        await getCheckInFlow(context, visitorBackup);
      } else {
        isReturn = true;
        var visitorDetail = VisitorCheckIn.fromJson(baseResponse.data);
        initDataBackup(visitorDetail);
        await getCheckInFlow(context, visitorDetail);
      }
    }, (Errors message) async {
      isLoading = false;
      Utilities().tryActionLoadingBtn(btnController, BtnLoadingAction.STOP);
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, () {
          this.isScanned = false;
        });
      } else {
        this.isScanned = false;
      }
    });

    cancelSearch = await ApiRequest().requestSearchVisitor(context, phone, null, callBack);
    await cancelSearch.valueOrCancellation();
  }

//  void handlerNoVisitor() {
//    isScanned = false;
//    isLoading = false;
//    notifyListeners();
//    btnController.success();
//    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () {
//      moveToNextScreen(
//          VisitorCheckIn.initPhone(phone), HomeNextScreen.CHECK_IN, 1);
//    });
//  }

  Future<List<CheckInFlow>> getCheckInFlow(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    getVisitorType(visitorCheckIn);
    var templateCode = (visitorCheckIn.visitorType != null && visitorCheckIn.visitorType.isNotEmpty)
        ? visitorCheckIn.visitorType
        : listType[0].settingKey;
    if (isEventMode) {
      templateCode = TemplateCode.EVENT;
    }
    List<CheckInFlow> flows = await db.checkInFlowDAO.getbyTemplateCode(templateCode);
    doNextFlow(context, flows, visitorCheckIn);
  }

  VisitorCheckIn getVisitorType(VisitorCheckIn visitorCheckIn) {
    if (haveType) {
      visitorCheckIn.visitorType = visitorBackup.visitorType;
    } else {
      if (!isDelivery) {
        if (visitorType != null) {
          visitorCheckIn.visitorType = visitorType.settingKey;
        } else if (listType.isNotEmpty) {
          visitorCheckIn.visitorType = listType[0].settingKey;
        } else {
          visitorCheckIn.visitorType = TypeVisitor.VISITOR;
        }
      } else {
        visitorCheckIn.visitorType = TypeVisitor.DELIVERY;
      }
    }
    return visitorCheckIn;
  }

  Future<void> doNextFlow(BuildContext context, List<CheckInFlow> flows, VisitorCheckIn visitorCheckIn) async {
    var convertVisitor = isReturn ? VisitorCheckIn.createVisitorByFlow(flows, visitorCheckIn) : visitorCheckIn;
    convertVisitor.id = 0.0;
    convertVisitor.toCompany = visitorBackup.toCompany;
    convertVisitor.toCompanyId = visitorBackup.toCompanyId;
    convertVisitor.contactPersonId = visitorBackup.contactPersonId;
    convertVisitor.floor = visitorBackup.floor;
    getVisitorType(convertVisitor);

    var listHaveAlways = flows.where((element) =>
        element.getRequestType() == RequestType.ALWAYS || element.getRequestType() == RequestType.ALWAYS_NO);
    bool isHaveAlways = (listHaveAlways != null && listHaveAlways.isNotEmpty);

    isLoading = false;
    notifyListeners();
    if (isShowPhone) {
      Utilities().tryActionLoadingBtn(btnController, BtnLoadingAction.SUCCESS);
    }

    var isCapture = await Utilities().checkIsCapture(context, convertVisitor?.visitorType);
    bool isAllowContact = await Utilities().checkAllowContact(context, convertVisitor?.visitorType);
    bool isBuilding = (arguments["companyBuilding"] as CompanyBuilding) != null;
    bool haveType = (arguments["haveType"] as bool) ?? false;
    bool isSurvey = await Utilities().isSurveyCustom(context, visitorCheckIn.visitorType);
    Utilities().createStep(context, true, isBuilding, haveType, isAllowContact, isSurvey, isHaveAlways, isReturn, isCapture);
    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () async {
      if (isAllowContact) {
        moveToNextScreen(context, convertVisitor, HomeNextScreen.CONTACT_PERSON, isCapture, isHaveAlways);
      } else if (isHaveAlways || !isReturn) {
        moveToNextScreen(context, convertVisitor, HomeNextScreen.CHECK_IN, isCapture, isHaveAlways);
      } else {
        if (isSurvey) {
          moveToNextScreen(context, convertVisitor, HomeNextScreen.SURVEY, isCapture, isHaveAlways);
        } else if (isCapture) {
          moveToNextScreen(context, convertVisitor, HomeNextScreen.FACE_CAP, isCapture, isHaveAlways);
        } else {
          moveToNextScreen(context, convertVisitor, HomeNextScreen.REVIEW_INFOR, isCapture, isHaveAlways);
        }
      }
    });
  }

  Future<void> moveToNextScreen(BuildContext context,
      VisitorCheckIn visitorCheckIn, HomeNextScreen type, bool isCapture, bool isHaveAlways) async {
    parent.updateMode();
    var isQRScan = (arguments["isQRScan"] as bool) ?? false;
    CompanyBuilding companyBuilding =  (arguments["companyBuilding"] as CompanyBuilding);

    visitorCheckIn.phoneNumber = phone;
    switch (type) {
      case HomeNextScreen.CONTACT_PERSON:
        {
          locator<NavigationService>().navigateTo(ContactScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isShowBack': false,
            'isScanId': false,
            'isDelivery': isDelivery,
            'isReplace': false,
            'isReturn': isReturn,
            'isHaveAlways': isHaveAlways,
            'isCapture': isCapture,
            'companyBuilding': companyBuilding,
          }).then((value) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.SURVEY:
        {
          locator<NavigationService>().navigateTo(SurveyScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isScanId': false,
            'inviteCode': this.inviteCode,
            'isDelivery': isDelivery,
            'isQRScan': isQRScan,
            'isCapture': isCapture,
            'companyBuilding': companyBuilding,
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.FACE_CAP:
        {
          locator<NavigationService>().navigateTo(TakePhotoScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'inviteCode': this.inviteCode,
            'isDelivery': isDelivery,
            'isQRScan': isQRScan,
            'isScanId': false,
            'companyBuilding': companyBuilding,
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.CHECK_IN:
        {
          locator<NavigationService>().navigateTo(InputInformationScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isScanId': false,
            'isDelivery': isDelivery,
            'isReturn': isReturn,
            'isQRScan': isQRScan,
            'companyBuilding': companyBuilding,
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.SCAN_ID:
        {
          locator<NavigationService>().navigateTo(ScanVisionScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isScanId': false,
            'isDelivery': isDelivery,
            'isReturn': isReturn,
            'isCheckIn': true,
            'companyBuilding': companyBuilding
          }).then((_) {
            isSelectedType = 0;
            visitorType = null;
            notifyListeners();
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.REVIEW_INFOR:
        {
          locator<NavigationService>()
              .pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name, arguments: {
            'visitor': visitorCheckIn,
            'inviteCode': this.inviteCode,
            'isDelivery': isDelivery,
            'isQRScan': isQRScan,
            'isScanId': false,
            'companyBuilding': companyBuilding,
          }).then((_) {
            handlerBack();
          });
          break;
        }
      default:
        {
          break;
        }
    }
  }

  void handlerBack() {
    Utilities().clearStep();
    if (isShowPhone) {
      Utilities().tryActionLoadingBtn(btnController, BtnLoadingAction.STOP);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    cancelGetFlow?.cancel();
    cancelSearch?.cancel();
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    super.dispose();
  }
}
