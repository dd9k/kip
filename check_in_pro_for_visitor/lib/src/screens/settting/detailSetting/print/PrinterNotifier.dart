import 'dart:convert';
import 'dart:isolate';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../MainNotifier.dart';

class PrintNotifier extends MainNotifier {
  List<PrinterModel> devices = [];
  bool isLoading = true;

  //loading animation
  bool isReload = false;
  bool isDoublePrint = false;
  AsyncMemoizer<List<PrinterModel>> memCache = AsyncMemoizer();
  Isolate isolate;

  void reload() {
    isLoading = true;
    notifyListeners();
  }

  Future<List<ItemSwitch>> getSaveItems() async {
    isDoublePrint = (preferences.getBool(Constants.KEY_DOUBLE_PRINT) ?? false);
    List<ItemSwitch> items = <ItemSwitch>[
      ItemSwitch(
          title: appLocalizations.doublePrint,
          subtitle: appLocalizations.doublePrintSub,
          icon: Icons.content_copy,
          isSelect: isDoublePrint,
          switchType: SwitchType.OTHER),
    ];
    return items;
  }

  Future<void> switchItem(Function animation, ItemSwitch item) async {
    switch (item.switchType) {
      case SwitchType.OTHER:
        {
          item.isSelect = !item.isSelect;
          preferences.setBool(Constants.KEY_DOUBLE_PRINT, item.isSelect);
          animation();
          isDoublePrint = item.isSelect;
          notifyListeners();
          break;
        }
      default:
        {}
    }
  }

  //call native printer
  Future<List<PrinterModel>> findAllPrinter(BuildContext context) async {
    return memCache.runOnce(() async {
      try {
        var listPrinter = await Utilities().findAllPrinter();
        devices.addAll(listPrinter);
      } catch (e) {
        print("catch catch catch ${e.toString()}");
      }
      isLoading = false;
      notifyListeners();
      return devices;
    });
  }

  Future<void> printTest(BuildContext context, PrinterModel printerModel) async {
    printerModel?.numberOfCopy = isDoublePrint ? 2 : 1;
    var status = await printerModel.printTest();
    if (status != Constants.STATUS_SUCCESS) {
      Utilities().showErrorPop(context, printerModel.getErrorCode(context, status), null, null);
    }
  }

  Future<void> connectPrinter(BuildContext context, PrinterModel item) async {
    if (!item.isConnect) {
      await item.connectPrinter();
      requestApiUpdate(context, item.ipAddress);
    } else {
      preferences.setString(Constants.KEY_PRINTER, "");
      requestApiUpdate(context, "");
    }
    devices.forEach((element) {
      if (element.ipAddress == item.ipAddress) {
        element.isConnect = !item.isConnect;
      } else {
        element.isConnect = false;
      }
    });
    isReload = !isReload;
    notifyListeners();
  }

  Future requestApiUpdate(BuildContext context, String printAddress) async {
    var deviceInforBranch = DeviceInfor.init();
    deviceInforBranch.printAddress = printAddress;
    deviceInforBranch.id = (await Utilities().getUserInfor()).deviceInfo.id;
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      getUserInfor(context, Constants.IPAD_CODE);
    }, (Errors message) async {});

    var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    await ApiRequest().requestUpdateDevice(context, deviceInforBranch, firebaseId, callBack);
  }

  Future getUserInfor(BuildContext context, String type) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var userInforString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_USER_INFOR, userInforString);
      var userInfor = UserInfor.fromJson(baseResponse.data);
      var lang = userInfor?.companyLanguage?.elementAt(0)?.languageCode ?? Constants.EN_CODE;
      if (!Constants.LIST_LANG.contains(lang)) {
        lang = Constants.EN_CODE;
      }
      preferences.setString(Constants.KEY_LANGUAGE, lang);
      await AppLocalizations.of(context).load(Locale(lang));
    }, (Errors message) {});

    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }
}
