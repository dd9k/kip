import 'dart:async';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/model/BranchInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputDeviceName/InputDeviceNameScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseListResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MainNotifier.dart';

class LocationNotifier extends MainNotifier {
  bool isReload = false;
  bool isInit = false;
  bool autoFocus = false;
  bool isShowLogo = true;
  bool hideLoading = true;
  String errorText;
  BranchInfor locationInfor;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  AsyncMemoizer<List<BranchInfor>> memCache = AsyncMemoizer();

  Future<List<BranchInfor>> getLocation(BuildContext context) async {
    return memCache.runOnce(() async {
      var completer = new Completer<List<BranchInfor>>();
      ApiCallBack callBack = ApiCallBack((BaseListResponse baseListResponse) async {
        List<BranchInfor> infor = baseListResponse.data.map((Map model) => BranchInfor.fromJson(model)).toList();
        if (infor.length <= 1) {
          moveToInputDevice(context, (infor.isNotEmpty) ? infor[0].branchId : 0.0, false);
        } else {
          completer.complete(infor);
        }
      }, (Errors message) async {
        if (message.code != -2) {
          Utilities().showErrorPop(context, message.description, null, null);
        }
      });

      await ApiRequest().requestLocationInfor(context, callBack);
      return completer.future;
    });
  }

  List<BranchInfor> getSuggestions(List<BranchInfor> list, String query) {
    var temp = list.where((item) => item.branchName.toLowerCase().contains(query.toLowerCase())).toList();
    return temp;
  }

  void moveToInputDevice(BuildContext context, double locationId, bool isShowBack) {
    var deviceInfor = arguments["deviceInfor"];
    locator<NavigationService>().navigateTo(
      InputDeviceNameScreen.route_name,
      1,
      arguments: {'locationId': locationId, 'isShowBack': isShowBack, 'deviceInfor': deviceInfor},
    );
  }

  void handlerError(BuildContext context, String text) {
    if (text.isEmpty) {
      errorText = AppLocalizations.of(context).translate(AppString.MESSAGE_SELECT_BRANCH_CHATBOX);
    } else {
      errorText = AppLocalizations.of(context).noLocation;
    }
    isReload = !isReload;
    notifyListeners();
  }

  @override
  void dispose() {
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    super.dispose();
  }
}
