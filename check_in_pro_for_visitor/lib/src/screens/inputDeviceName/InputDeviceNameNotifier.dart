import 'dart:convert';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfo.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip/get_ip.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputDeviceNameNotifier extends MainNotifier {
  bool isLoading = false;
  bool isOpeningKeyboard = false;
  CancelableOperation cancelableOperation;
  CancelableOperation cancelableUpdate;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;

  Future<DeviceInfo> getDeviceInfor() async {
    return await Utilities().getDeviceInfo();
  }

  void moveToWaiting() {
    locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
  }

  void doSetupDevice(BuildContext context, String name) async {
    isLoading = true;
    notifyListeners();
    String appVersion = await Utilities().getVersion();
    String ipAddress = await GetIp.ipAddress;
    var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var argumentsDeviceInfor = arguments["deviceInfor"] as DeviceInfor;
    var locationId = arguments["locationId"] as double;

    if (argumentsDeviceInfor != null) {
      await requestApiUpdate(context, argumentsDeviceInfor, locationId, name, appVersion, ipAddress);
    } else {
      await requestApiSetup(name, context, locationId, appVersion, ipAddress);
    }
  }

  Future requestApiSetup(
      String name, BuildContext context, double locationId, String appVersion, String ipAddress) async {
    var deviceInfor = await Utilities().getDeviceInfo();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      preferences.setString(Constants.KEY_DEVICE_NAME, name);
      getUserInfor(context, Constants.IPAD_CODE);
    }, (Errors message) async {
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      notifyListeners();
    });
    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    cancelableOperation = await ApiRequest().requestSetupDevice(
        context,
        name,
        deviceInfor.model,
        deviceInfor.identifier,
        deviceInfor.osVersion,
        appVersion,
        ipAddress,
        "",
        locationId,
        Constants.TIMEOUT_DEFAULT,
        firebaseId,
        callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future getUserInfor(BuildContext context, String type) async {
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
      await AppLocalizations.of(context).load(Locale(lang));
      var userInforString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_USER_INFOR, userInforString);
      preferences.setDouble(Constants.KEY_COMPANY_ID, userInfor.companyInfo.id);
      isLoading = false;
      notifyListeners();
      moveToWaiting();
    }, (Errors message) {
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      notifyListeners();
    });

    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }

  Future requestApiUpdate(BuildContext context, DeviceInfor argumentsDeviceInfor, double locationId, String name,
      String appVersion, String ipAddress) async {
    var deviceInfor = await Utilities().getDeviceInfo();
    argumentsDeviceInfor.locationId = locationId;
    argumentsDeviceInfor.name = name;
    argumentsDeviceInfor.osVersion = deviceInfor.osVersion;
    argumentsDeviceInfor.appVersion = appVersion;
    argumentsDeviceInfor.printAddress = "";
    argumentsDeviceInfor.ipAddress = ipAddress;
    argumentsDeviceInfor.timeout = Constants.TIMEOUT_DEFAULT;
    argumentsDeviceInfor.deviceId = deviceInfor.identifier;
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      preferences.setString(Constants.KEY_DEVICE_NAME, name);
      getUserInfor(context, Constants.IPAD_CODE);
    }, (Errors message) async {
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      notifyListeners();
    });

    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    cancelableUpdate = await ApiRequest().requestUpdateDevice(context, argumentsDeviceInfor, firebaseId, callBack);
    await cancelableUpdate.valueOrCancellation();
  }

  @override
  void dispose() {
    cancelableUpdate?.cancel();
    cancelableOperation?.cancel();
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    super.dispose();
  }
}
