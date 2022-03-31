import 'dart:convert';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/location/LocationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/UtilityNotifier.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'dart:io' show Platform;

import '../../utilities/Utilities.dart';

class LoginNotifier extends UtilityNotifier {
  bool isShowClear = false;
  bool isLoading = false;
  bool isDevMode = false;
  bool updateToggle = false;
  bool isUpdateLang = false;
  List<String> errorText;
  bool isShowKeyBoard = false;
  int clickNumber = 0;
  bool isShowPass = false;
  AsyncMemoizer<String> memCache = AsyncMemoizer();

  void showClear(bool isShow) {
    isShowClear = isShow;
    notifyListeners();
  }

  Future<String> initURL() async {
    return memCache.runOnce(() async {
      var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      currentLang = langSaved;
      var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
      Constants().indexURL = index;
      var userSaved = preferences.getString(Constants.KEY_USER) ?? "";
      return userSaved;
    });
  }

  Future<void> onTapLogo() async {
    clickNumber++;
    // Meet maximum value
    if (Constants.MAX_CLICK_NUMBER == clickNumber) {
      // Reset clickNumber value
      clickNumber = 0;
      // Show hidden
      updateToggle = !updateToggle;
      isDevMode = !isDevMode;
      var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
      selections[index] = true;
      notifyListeners();
    }
  }

  Future<void> onToggleSelected(int index) async {
    Constants().indexURL = index;
    selections.asMap().forEach((index, element) {
      selections[index] = false;
    });
    selections[index] = true;
    preferences.setInt(Constants.KEY_DEV_MODE, index);
    updateToggle = !updateToggle;
    notifyListeners();
  }

  List<bool> selections = List.generate(Constants.URL_LIST.length, (index) => false);

  Future<void> showPass() async {
    isShowPass = !isShowPass;
    isUpdateLang = !isUpdateLang;
    notifyListeners();
  }

  Future doLogin(BuildContext context, String username, String password) async {
    errorText = List();
    isLoading = true;
    notifyListeners();
    String os = Constants.IOS_CODE;
    if (Platform.isAndroid) {
      os = Constants.ANDROID_CODE;
    } else if (Platform.isIOS) {
      os = Constants.IOS_CODE;
    }
    String version = await Utilities().getVersion();

    var firebaseToken = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    var domain = (arguments["domain"] as String) ?? "";
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var authenticationString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_AUTHENTICATE, authenticationString);
      preferences.setString(Constants.KEY_USER, username);
      checkDevice(context, username, password, Constants.IPAD_CODE);
    }, (Errors message) {
      handlerError(context, username, password, message);
    });

    var infor = await Utilities().getDeviceInfo();
    await ApiRequest().requestLoginApi(
        context, username, password, infor.model, firebaseToken, Constants.VN_CODE, os, version, domain, callBack);
  }

  Future getUserInfor(BuildContext context, String username, String password, String type) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var userInfor = UserInfor.fromJson(baseResponse.data);
      var savedCompanyId = preferences.getDouble(Constants.KEY_COMPANY_ID);
      if (savedCompanyId != userInfor.companyInfo.id) {
        db.deleteAllDataInDB();
      }
      var lang = userInfor?.companyLanguage?.elementAt(0)?.languageCode ?? Constants.EN_CODE;
      if (!Constants.LIST_LANG.contains(lang)) {
        lang = Constants.EN_CODE;
      }
      preferences.setString(Constants.KEY_LANGUAGE, lang);
      var userInforString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_USER_INFOR, userInforString);
      preferences.setDouble(Constants.KEY_COMPANY_ID, userInfor.companyInfo.id);
      preferences.setBool(Constants.KEY_IS_LOGGED, true);
      preferences.setString(Constants.KEY_PASSWORD, password);
      isLoading = false;
      notifyListeners();
      await appLocalizations.load(Locale(lang));
      moveToWaiting(context);
    }, (Errors message) {
      handlerError(context, username, password, message);
    });

    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }

  Future checkDevice(BuildContext context, String username, String password, String type) async {
    var deviceInfor = await Utilities().getDeviceInfo();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      if (baseResponse.data != null) {
        var deviceInfor = DeviceInfor.fromJson(baseResponse.data);
        var hardInfor = await Utilities().getDeviceInfo();
        String appVersion = await Utilities().getVersion();
        String ipAddress = await GetIp.ipAddress;
        deviceInfor.deviceId = hardInfor.identifier;
        deviceInfor.osVersion = hardInfor.osVersion;
        deviceInfor.appVersion = appVersion;
        deviceInfor.ipAddress = ipAddress;
        Utilities().showTwoButtonDialog(
            context,
            DialogType.INFO,
            null,
            AppLocalizations.of(context).titleNotification,
            AppLocalizations.of(context).deviceExist,
            AppLocalizations.of(context).btnNo,
            AppLocalizations.of(context).btnYes, () async {
          doBeforeLocation(password);
          moveToGetLocation(deviceInfor, context);
        }, () {
          updateDevice(context, deviceInfor, username, password, type);
        });
      } else {
        doBeforeLocation(password);
        moveToGetLocation(null, context);
      }
    }, (Errors message) {
      handlerError(context, username, password, message);
    });

    await ApiRequest().requestCheckDevice(context, deviceInfor.identifier, callBack);
  }

  void doBeforeLocation(String password) {
    preferences.setBool(Constants.KEY_IS_LOGGED, true);
    preferences.setString(Constants.KEY_PASSWORD, password);
    isLoading = false;
    notifyListeners();
  }

  Future updateDevice(
      BuildContext context, DeviceInfor deviceInfor, String username, String password, String type) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      preferences.setString(Constants.KEY_DEVICE_NAME, deviceInfor.name);
      getUserInfor(context, username, password, Constants.IPAD_CODE);
    }, (Errors message) {
      handlerError(context, username, password, message);
    });

    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    await ApiRequest().requestUpdateDevice(context, deviceInfor, firebaseId, callBack);
  }

  void handlerError(BuildContext context, String username, String password, Errors message) {
    isLoading = false;
    if (message.code == -1) {
      Utilities().showErrorPop(context, message.description, null, null);
    } else if (message.code >= 0) {
      for (var i = 0; i < message.code; i++) {
        errorText.add(null);
      }
      errorText.add(message.description);
    }
    notifyListeners();
  }

  void moveToGetLocation(DeviceInfor deviceInfor, BuildContext context) {
    Utilities().countDownToResetApp(0, context);
    locator<NavigationService>().navigateTo(LocationScreen.route_name, 2, arguments: {'deviceInfor': deviceInfor});
  }

  void moveToWaiting(BuildContext context) {
    Utilities().countDownToResetApp(0, context);
    locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
  }

  Future<void> setFaceDetect() async {
    var canDetect = await Utilities().checkFaceDetect();
    preferences.setBool(Constants.KEY_FACE_DETECT, canDetect);
  }

  Future<void> updateLang(String lang) async {
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    if (langSaved == lang) {
      return;
    }
    if (!Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    preferences.setString(Constants.KEY_LANGUAGE, lang);
    await appLocalizations.load(Locale(lang));
    currentLang = lang;
    isUpdateLang = !isUpdateLang;
    notifyListeners();
  }
}
