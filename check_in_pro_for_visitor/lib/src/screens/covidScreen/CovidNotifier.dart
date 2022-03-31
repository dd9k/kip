import 'dart:async';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/CovidModel.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/SurveyForm.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CovidNotifier extends MainNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  String inviteCode;
  VisitorCheckIn visitor;
  var visitorType = Constants.VT_VISITORS;
  bool isBuilding = false;
  bool isDoneAnyWay = false;
  PrinterModel printer;
  bool isCapture = false;
  bool isQRScan = false;
  Color colorTitle;
  bool isOpeningKeyboard = false;
  Timer timerNext;
  bool isUsePhone = true;
  RoundedLoadingButtonController btnController = RoundedLoadingButtonController();
  AsyncMemoizer<CovidModel> memCache = AsyncMemoizer();
  Timer timerDoneAnyWay;
  CancelableOperation cancelEvent;

  Future<void> moveToNextPage(BuildContext context) async {
    if (timerNext != null) {
      timerNext.cancel();
    }
    var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
    if (isCapture) {
      navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: arguments);
    } else if (isQRScan) {
      actionEventMode(context, visitorCheckIn, isCapture);
    } else {
      locator<NavigationService>()
          .pushNamedAndRemoveUntil(ThankYouScreen.route_name, WaitingScreen.route_name, arguments: {
        'visitor': visitorCheckIn,
      });
    }
  }

  Future actionEventMode(BuildContext context, VisitorCheckIn visitorCheckIn, bool isCapture) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      btnController?.success();
      if (isCapture) {
        navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: arguments).then((value) {
          btnController?.stop();
        });
      } else {
        doneCheckIn(context, visitorCheckIn, isCapture);
      }
    }, (Errors message) async {
      btnController?.stop();
      var contentError = message.description;
      if (message.description.contains("field_name")) {
        contentError = appLocalizations
            .errorInviteCode
            .replaceAll("field_name", appLocalizations.inviteCode);
      }
      if (message.code != -2) {
        utilities.showErrorPop(context, contentError, Constants.AUTO_HIDE_LONG, () {}, callbackDismiss: () {
          utilities.moveToWaiting();
        });
      } else {}
    });
    var userInfor = await utilities.getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var inviteCode = arguments["inviteCode"] as String;
    var phoneNumber = arguments["phoneNumber"] as String;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest().requestActionEvent(context, locationId, inviteCode, phoneNumber,
        visitorCheckIn.faceCaptureFile, visitorCheckIn.faceCaptureRepoId, eventId, null, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future<void> doneCheckIn(BuildContext context, VisitorCheckIn visitorCheckIn, bool isCapture) async {
    var isPrint = await utilities.checkIsPrint(context, visitor?.visitorType);
    if (isPrint) {
      await Future.delayed(new Duration(milliseconds: 500));
      callPrinter(context, visitorCheckIn);
    } else {
      handlerDone();
    }
  }

  void handlerDone() {
    isDoneAnyWay = true;
    navigationService
        .pushNamedAndRemoveUntil(ThankYouScreen.route_name, WaitingScreen.route_name, arguments: {
      'visitor': visitor,
      'isCheckOut' : arguments["isCheckOut"]
    });
  }

  Future<void> callPrinter(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    timerDoneAnyWay = Timer(Duration(seconds: Constants.TIMEOUT_PRINTER), () {
      if (!isDoneAnyWay) {
        handlerDone();
      }
    });
    String response = "";
    try {
      if (printer != null) {
        RenderRepaintBoundary boundary = repaintBoundary.currentContext.findRenderObject();
        await utilities.printJob(printer, boundary);
        if (!isDoneAnyWay) {
          timerDoneAnyWay?.cancel();
          handlerDone();
        }
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      utilities.printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        handlerDone();
      }
    } catch (e) {}
  }

  void countDownToDone(BuildContext context) {
    timerNext?.cancel();
    timerNext = Timer(Duration(seconds: 120), () {
      moveToNextPage(context);
    });
  }

  void updateForm() {
    isUsePhone = !isUsePhone;
    notifyListeners();
  }

  Future<CovidModel> getConfig() async {
    return memCache.runOnce(() async {
      visitor = arguments["visitor"] as VisitorCheckIn;
      inviteCode = arguments["inviteCode"] as String;
      visitorType = await utilities.getTypeInDb(context, visitor.visitorType);
      isBuilding = (await utilities.checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
      printer = await utilities.getPrinter();
      isCapture = (arguments["isCapture"] as bool) ?? false;
      isQRScan = (arguments["isQRScan"] as bool) ?? false;
      SurveyForm surveyForm = await Utilities().getSurvey();
      if (surveyForm.embeddedLinkData?.titleColor == null) {
        colorTitle = AppColor.MAIN_TEXT_COLOR;
      } else {
        var value = Constants.PREFIX_COLOR +
            surveyForm.embeddedLinkData.titleColor.replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
        colorTitle = Color(int.parse(value));
      }
      return surveyForm.embeddedLinkData;
    });
  }

  @override
  void dispose() {
    cancelEvent?.cancel();
    timerNext?.cancel();
    timerDoneAnyWay?.cancel();
    super.dispose();
  }
}
