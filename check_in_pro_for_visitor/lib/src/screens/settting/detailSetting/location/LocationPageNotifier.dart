import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseListResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/BranchInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/SettingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_ip/get_ip.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/Constants.dart';
import '../../../../model/UserInfor.dart';

class LocationPageNotifier extends MainNotifier {
  AsyncMemoizer<List<BranchInfor>> memCache = AsyncMemoizer();
  bool isReload = false;
  bool isLoading = true;
  double locationId;
  String deviceName;
  List<BranchInfor> listBranch = List();
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  AsyncMemoizer<UserInfor> memCacheUser = AsyncMemoizer();
  var completer = Completer<UserInfor>();

  Future<List<BranchInfor>> getLocation(BuildContext context) async {
    return memCache.runOnce(() async {
      try {
        var completer = new Completer<List<BranchInfor>>();
        ApiCallBack callBack = ApiCallBack((BaseListResponse baseListResponse) async {
          List<BranchInfor> infor = baseListResponse.data.map((Map model) => BranchInfor.fromJson(model)).toList();
          if (infor.length <= 0) {
          } else {
            infor.firstWhere((element) => element.branchId == locationId).isSelect = true;
            infor.sort((a, b) => a.isSelect ? 0 : 1);
            listBranch = infor;
            completer.complete(infor);
          }
          isLoading = false;
          notifyListeners();
        }, (Errors message) async {
          if (message.code != -2) {
            Utilities().showErrorPop(context, message.description, null, null);
          }
          memCache = AsyncMemoizer();
          isReload = !isReload;
          isLoading = false;
          notifyListeners();
        });

        await ApiRequest().requestLocationInfor(context, callBack);
        return completer.future;
      } catch (e) {}
      return null;
    });
  }

  Future<UserInfor> getCurrentInfor() async {
    return memCacheUser.runOnce(() async {
      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
        var userInforString = JsonEncoder().convert(baseResponse.data);
        preferences.setString(Constants.KEY_USER_INFOR, userInforString);
        var userInfor = UserInfor.fromJson(baseResponse.data);
        locationId = userInfor.deviceInfo.branchId;
        deviceName = userInfor.deviceInfo.name;
        completer.complete(userInfor);
      }, (Errors message) {
        if (message.code != -2) {
          Utilities().showErrorPop(context, message.description, null, null);
        }
      });

      var deviceInfor = await Utilities().getDeviceInfo();
      await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
      return completer.future;
    });
  }

  Future getUserInfor(BuildContext context, String type) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var userInforString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_USER_INFOR, userInforString);
      isLoading = false;
      btnController.success();
      Background.of(context).updateReload(true);
      SettingScreen.of(context).updateReload(true);
      await Future.delayed(Duration(milliseconds: 500));
      Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_SMALL,
          AppLocalizations.of(context).successTitle, AppLocalizations.of(context).saveSuccess, null);
      btnController.stop();
      notifyListeners();
    }, (Errors message) {
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      btnController.stop();
      notifyListeners();
    });

    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }

  void updateBranch(BranchInfor branchInfor) {
    locationId = branchInfor.branchId;
    listBranch.forEach((element) {
      if (element.branchId == locationId) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });
    isReload = !isReload;
    notifyListeners();
  }

  Future requestApiUpdate(BuildContext context, String name) async {
    isLoading = true;
    notifyListeners();
    var deviceInforBranch = DeviceInfor.init();
    var deviceInfor = await Utilities().getDeviceInfo();
    String ipAddress = await GetIp.ipAddress;
    deviceInforBranch.locationId = locationId;
    deviceInforBranch.branchId = locationId;
    deviceInforBranch.name = name;
    deviceInforBranch.osVersion = deviceInfor.osVersion;
    deviceInforBranch.ipAddress = ipAddress;
    deviceInforBranch.deviceId = deviceInfor.identifier;
    deviceInforBranch.id = (await Utilities().getUserInfor()).deviceInfo.id;

    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      preferences.setString(Constants.KEY_DEVICE_NAME, name);
      preferences.setDouble(Constants.KEY_EVENT_ID, null);
      preferences.setBool(Constants.KEY_EVENT, false);
      preferences.setDouble(Constants.KEY_EVENT_ID, null);
      preferences.setBool(Constants.KEY_SYNC_EVENT, false);
      getUserInfor(context, Constants.IPAD_CODE);
    }, (Errors message) async {
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      btnController.stop();
      notifyListeners();
    });
    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    await ApiRequest().requestUpdateDevice(context, deviceInforBranch, firebaseId, callBack);
  }
}
