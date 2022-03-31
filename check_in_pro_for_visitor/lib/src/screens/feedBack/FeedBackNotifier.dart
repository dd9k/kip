import 'dart:async';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/ConfigKiosk.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedBackNotifier extends MainNotifier {
  double starRating;
  double starRatingAPI = -1;
  Timer timerNext;
  bool isLoading = false;
  bool isShowLogo = true;
  bool isCountDownAgain = true;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  var isEventMode = false;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  ConfigKiosk configKiosk;

  FeedBackNotifier() {
    starRating = 0;
  }

  var isSyncNow = false;
  AsyncMemoizer<SharedPreferences> memCache = AsyncMemoizer();

  Future<SharedPreferences> getValue() async {
    return memCache.runOnce(() async {
      isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
      configKiosk = await utilities.getConfigKios();
      return preferences;
    });
  }

  void updateRatingChange(double index) {
    starRating = index;
    starRatingAPI = index;
    notifyListeners();
  }

  Future<void> moveToNextPage(BuildContext context) async {
    timerNext?.cancel();
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    if (isEventMode) {
      navigationService.pushNamedAndRemoveUntil(ScanQRScreen.route_name, WaitingScreen.route_name, arguments: {
        'isRestoreLang': true,
        'isCheckOut' : arguments["isCheckOut"]
      });
    } else {
      navigationService.navigateTo(WaitingScreen.route_name, 3);
    }
  }

  Future checkOut(BuildContext context, String comment) async {
    timerNext?.cancel();
    isLoading = true;
    notifyListeners();
    isSyncNow = arguments["isSyncNow"] as bool ?? false;
    var inviteCode = arguments["inviteCode"] as String;
    var phoneNumber = arguments["phoneNumber"] as String;
    if ((inviteCode == null || inviteCode.isEmpty) && (phoneNumber == null || phoneNumber.isEmpty)) {
      if (parent.isOnlineMode) {
        await checkOutOnline(context, comment);
      } else {
        await checkOutOffline(context, comment);
      }
    } else {
      if (isEventMode)  {
        var eventLog = arguments["eventLog"] as EventLog;
        eventLog.signOut = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
        eventLog.rating = starRatingAPI.toInt();
        eventLog.feedback = comment;
        db.eventLogDAO.updateRow(eventLog);
        locator<SyncService>().syncEventNow(context, eventLog);
        doneCheckOut(context);
      } else {
        await checkOutEvent(context, inviteCode, phoneNumber, comment);
      }
    }
  }

  Future checkOutOffline(BuildContext context, String comment) async {
    var visitorLog = arguments["visitorLog"] as VisitorLog;
    visitorLog.rating = starRatingAPI;
    visitorLog.feedback = comment;
    var dateCheckOut = DateTime.now().toUtc().millisecondsSinceEpoch;
    await db.visitorLogDAO.insertVistorLogSignOut(visitorLog, dateCheckOut);
    doneCheckOut(context);
  }

  Future checkOutOnline(BuildContext context, String comment) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      doneCheckOut(context);
    }, (Errors message) async {
      if (message.description == appLocalizations.noData) {
        moveToNextPage(context);
      } else {
        btnController.stop();
        if (message.code != -2) {
          Utilities().showErrorPop(context, message.description, null, null);
        }
      }
      isLoading = false;
      notifyListeners();
    });
    var visitorCheckIn = arguments["visitorCheckIn"] as VisitorCheckIn;
    var userInfor = await Utilities().getUserInfor();
    var signOutBy = userInfor?.deviceInfo?.id ?? 0;
    var branchId = userInfor?.deviceInfo?.branchId ?? 0;
    await ApiRequest()
        .requestCheckOut(context, visitorCheckIn.id, comment, starRatingAPI, signOutBy, branchId, callBack);
  }

  Future checkOutEvent(BuildContext context, String inviteCode, String phoneNumber, String comment) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      doneCheckOut(context);
    }, (Errors message) async {
      if (message.description == AppLocalizations.of(context).noData) {
        moveToNextPage(context);
      } else {
        btnController.stop();
        if (message.code != -2) {
          Utilities().showErrorPop(context, message.description, null, null);
        }
      }
      isLoading = false;
      notifyListeners();
    });
    var userInfor = await Utilities().getUserInfor();
    var signOutBy = userInfor?.deviceInfo?.id ?? 0;
    var branchId = userInfor?.deviceInfo?.branchId ?? 0;
    await ApiRequest()
        .requestCheckOutEvent(context, inviteCode, phoneNumber, comment, starRatingAPI, signOutBy, branchId, callBack);
  }

  void doneCheckOut(BuildContext context) {
    isLoading = false;
    notifyListeners();
    btnController.success();
    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () {
      moveToNextPage(context);
    });
  }

  void countDownToDone(BuildContext context, TextEditingController comment) {
    if (timerNext != null) {
      timerNext.cancel();
      isLoading = false;
      isCountDownAgain = !isCountDownAgain;
      notifyListeners();
    }
    timerNext = Timer(Duration(seconds: Constants.TIMEOUT_CHECK_OUT), () {
      checkOut(context, comment.text);
    });
  }

  @override
  void dispose() {
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    if (timerNext != null) {
      timerNext.cancel();
    }
    super.dispose();
  }
}
