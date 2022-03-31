import 'dart:async';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/main.dart';
import 'dart:convert';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/Authenticate.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/givePermission/GivePermissionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/location/LocationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip/get_ip.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/UserInfor.dart';
import '../MainNotifier.dart';

class SplashNotifier extends MainNotifier {
  var isRequestDone = false;
  var isCountDownDone = false;
  CancelableOperation cancelableOperation;
  DeviceInfor deviceInfor;

  Future<void> initURL() async {
    var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
    Constants().indexURL = index;
  }

  Future<void> countDownToNext(BuildContext context) async {
    await initURL();
    Timer(Duration(seconds: 2), () {
      isCountDownDone = true;
      if (isRequestDone) {
        moveToNext(context);
      }
    });
  }

  void refreshToken(BuildContext context) async {
    var isLogin = preferences.getBool(Constants.KEY_IS_LOGGED) ?? false;
    preferences.setBool(Constants.KEY_FIRST_START, true);
    preferences.setBool(Constants.KEY_LOAD_WELCOME, true);
    var onLock = preferences.getBool(Constants.KEY_ON_LOCK) ?? false;
    if (await utilities.isLauncher() && onLock) {
      preferences.setBool(Constants.KEY_ON_LOCK, false);
      utilities.setKioskMode(true);
    }
    if (isLogin) {
      var isConnectInternet = MyApp.of(context).isConnection;
      var isSetupDevice = preferences.getString(Constants.KEY_DEVICE_NAME) ?? "";
      if (isConnectInternet || isSetupDevice.isEmpty) {
        var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
        await useAppOnline(context, firebaseId);
      } else {
        isRequestDone = true;
        if (isCountDownDone) {
          moveToNext(context);
        }
      }
    } else {
      isRequestDone = true;
    }
  }

  Future useAppOnline(BuildContext context, String firebaseId) async {
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      var authenticationString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_AUTHENTICATE, authenticationString);
      requestApiUpdate(context);
    }, (Errors message) {
      if (message.code != -2 && message.code == -401) {
        CancelableOperation cancelableLogout;
        var content = message.description;
        if (content == appLocalizations.translate(AppString.MESSAGE_COMMON_ERROR)) {
          content = appLocalizations.changedConfigurationContent;
        }
        Utilities().popupAndSignOut(context, cancelableLogout, content);
      } else {
        Utilities().showOneButtonDialog(
            context,
            DialogType.ERROR,
            null,
            appLocalizations.translate(AppString.TITLE_NOTIFICATION),
            appLocalizations.translate(AppString.NO_INTERNET),
            appLocalizations.translate(AppString.BUTTON_TRY_AGAIN), () {
          useAppOnline(context, firebaseId);
        });
      }
    });
    var authorization = await Utilities().getAuthorization();
    var token = (authorization as Authenticate).refreshToken;
    await ApiRequest().requestRefreshTokenApi(context, firebaseId, token, listCallBack);
    Utilities().writeLog("requestRefreshTokenApi");
  }

  Future<void> doLogout(BuildContext context) async {
    var authorization = await Utilities().getAuthorization();
    var refreshToken = (authorization as Authenticate).refreshToken;
    var deviceInfor = await Utilities().getDeviceInfo();
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";

    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      await handlerLogout();
    }, (Errors message) async {
      if (message.code != -2) {
        await handlerLogout();
      }
    });

    cancelableOperation =
        await ApiRequest().requestLogout(context, deviceInfor.identifier, refreshToken, firebase, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future handlerLogout() async {
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

  Future getUserInfor(BuildContext context, String type) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      if (baseResponse.data == null) {
        doLogout(context);
        return;
      }
      var userInfor = UserInfor.fromJson(baseResponse.data);
      if (userInfor?.deviceInfo == null || userInfor?.companyInfo == null || userInfor?.locationInfo == null) {
        doLogout(context);
      } else {
        var userInforString = JsonEncoder().convert(baseResponse.data);
        preferences.setString(Constants.KEY_USER_INFOR, userInforString);
        var lang = userInfor?.companyLanguage?.elementAt(0)?.languageCode ?? Constants.EN_CODE;
        if (!Constants.LIST_LANG.contains(lang)) {
          lang = Constants.EN_CODE;
        }
        preferences.setString(Constants.KEY_LANGUAGE, lang);
        await appLocalizations.load(Locale(lang));
        this.deviceInfor = userInfor.deviceInfo;
        isRequestDone = true;
        if (isCountDownDone) {
          moveToNext(context);
        }
      }
    }, (Errors message) async {
      if (message.code != -2) {
        Utilities().showNoButtonDialog(
            context,
            false,
            DialogType.INFO,
            Constants.AUTO_HIDE_LESS,
            appLocalizations.changedConfiguration,
            appLocalizations.changedConfigurationContent,
            null);
        await doLogout(context);
      }
    });
    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }

  Future requestApiUpdate(BuildContext context) async {
    var deviceInforBranch = DeviceInfor.init();
    var device = await Utilities().getDeviceInfo();
    String ipAddress = await GetIp.ipAddress;
    String appVersion = await Utilities().getVersion();
    deviceInforBranch.osVersion = device.osVersion;
    deviceInforBranch.ipAddress = ipAddress;
    deviceInforBranch.appVersion = appVersion;
    deviceInforBranch.id = (await Utilities().getUserInfor())?.deviceInfo?.id??0;
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      getUserInfor(context, Constants.IPAD_CODE);
    }, (Errors message) async {
      if (message.code != -2) {
        Utilities().showNoButtonDialog(
            context,
            false,
            DialogType.INFO,
            Constants.AUTO_HIDE_LESS,
            appLocalizations.changedConfiguration,
            appLocalizations.changedConfigurationContent,
            null);
        doLogout(context);
      }
    });
    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    await ApiRequest().requestUpdateDevice(context, deviceInforBranch, firebaseId, callBack);
  }

  void moveToNext(BuildContext context) async {
    var isLogin = preferences.getBool(Constants.KEY_IS_LOGGED) ?? false;
    var isSetupDevice = preferences.getString(Constants.KEY_DEVICE_NAME) ?? "";
    var isFirstLaunch = preferences.getBool(Constants.KEY_IS_LAUNCH) ?? true;
    var route = GivePermissionScreen.route_name;
    if (!isFirstLaunch) {
      if (isLogin) {
        if (isSetupDevice.isEmpty) {
          Utilities().countDownToResetApp(0, context);
          route = LocationScreen.route_name;
        } else {
          Utilities().countDownToResetApp(0, context);
          route = WaitingScreen.route_name;
        }
      } else {
        route = DomainScreen.route_name;
      }
      await Utilities().settingCameraPermission();
    }
    locator<NavigationService>().navigateTo(route, 3, arguments: {"deviceInfor": deviceInfor});
  }

  @override
  void dispose() {
    cancelableOperation?.cancel();
    super.dispose();
  }
}
