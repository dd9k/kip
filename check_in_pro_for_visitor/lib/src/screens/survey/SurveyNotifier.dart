import 'dart:async';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/QuestionSurvey.dart';
import 'package:check_in_pro_for_visitor/src/model/SurveyForm.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyNotifier extends MainNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  String inviteCode;
  VisitorCheckIn visitor;
  var visitorType = Constants.VT_VISITORS;
  bool isBuilding = false;
  bool isDoneAnyWay = false;
  PrinterModel printer;
  bool isCapture = false;
  bool isQRScan = false;
  List<QuestionSurvey> listItem = List();
  bool isValidate = false;
  SurveyForm surveyForm;
  String langSaved = Constants.EN_CODE;
  bool isReload = false;
  List<QuestionSurvey> listOld = List();
  AsyncMemoizer<List<QuestionSurvey>> memCache = AsyncMemoizer();
  ScrollController scrollController = ScrollController();
  CancelableOperation cancelEvent;
  Timer timerDoneAnyWay;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();

  Future<List<QuestionSurvey>> getSurvey(BuildContext context) async {
    return memCache.runOnce(() async {
      langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      await appLocalizations.initLocalLang();
      surveyForm = await utilities.getSurvey();
      if (surveyForm.customFormData.bodyTemperature == 1) {
        temperatureHardCode();
      }
      listItem.addAll(surveyForm.customFormData.questions);
      listItem?.removeWhere((element) => element.isHidden == 1);
      listItem?.sort((a, b) => a.sort.compareTo(b.sort));
      visitor = arguments["visitor"] as VisitorCheckIn;
      inviteCode = arguments["inviteCode"] as String;
      visitorType = await utilities.getTypeInDb(context, visitor.visitorType);
      isBuilding = (await utilities.checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
      printer = await utilities.getPrinter();
      isCapture = (arguments["isCapture"] as bool) ?? false;
      isQRScan = (arguments["isQRScan"] as bool) ?? false;
      if (visitor.survey != null && visitor.survey.isNotEmpty) {
        List<dynamic> convert = jsonDecode(visitor.survey);
        listOld = convert.map((e) => QuestionSurvey.fromJson(e)).toList();
      }
      scrollController.addListener(() {
        utilities.moveToWaiting();
      });
      return listItem;
    });
  }

  Future<void> moveToNext(BuildContext context) async {
    isValidate = false;
    List<QuestionSurvey> listSurvey = List();
    listItem.forEach((QuestionSurvey element) {
      if (checkingValidator(element).isNotEmpty) {
        isValidate = true;
      }
      listSurvey.add(element.createSubmit());
    });
    if (!isValidate) {
      VisitorCheckIn visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
      visitorCheckIn.survey = jsonEncode(listSurvey);
      visitorCheckIn.surveyId = surveyForm.customFormData.surveyId;
      arguments["visitor"] = visitorCheckIn;
      FocusScope.of(context).requestFocus(FocusNode());
      if (isCapture) {
        navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: arguments);
      } else if (isQRScan) {
        actionEventMode(context, visitorCheckIn, isCapture);
      } else {
        navigationService.pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
            arguments: arguments);
      }
    } else {
      isReload = !isReload;
      notifyListeners();
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
        visitorCheckIn.faceCaptureFile, visitorCheckIn.faceCaptureRepoId, eventId
        , visitorCheckIn.surveyId, visitorCheckIn.survey, callBack);
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

  void temperatureHardCode() {
    Map<String, String> mapTitle = Map();
    Map<String, String> mapValue = Map();
    mapTitle[Constants.VN_CODE] = appLocalizations.titleSurvey0Vi;
    mapTitle[Constants.EN_CODE] = appLocalizations.titleSurvey0En;
    mapValue[Constants.VN_CODE] = appLocalizations.value0Survey2Vi;
    mapValue[Constants.EN_CODE] = appLocalizations.value0Survey2En;
    String title = jsonEncode(mapTitle);
    String value = jsonEncode(mapValue);
    listItem.add(QuestionSurvey(title, -1, [value], List(), "5", "1", 1, 0, -1));
  }

  String checkingValidator(QuestionSurvey questionSurvey) {
    if (questionSurvey.getSurveyType() != QuestionType.EDIT_TEXT) {
      if (questionSurvey.isRequired == 1 && questionSurvey?.getAnswer()?.isEmpty == true) {
        questionSurvey.errorText = appLocalizations.surveyValidate;
      } else {
        questionSurvey.errorText = "";
      }
      return questionSurvey.errorText;
    }
    switch (questionSurvey.getSurveySubType()) {
      case QuestionSubType.PHONE:
        {
          if (questionSurvey.getAnswer().isEmpty || utilities.getStringByLang(questionSurvey.getAnswerByIndex(0), langSaved).isEmpty) {
            if (questionSurvey.isRequired == 1) {
              questionSurvey.errorText = appLocalizations.surveyValidate;
            } else {
              questionSurvey.errorText = "";
            }
          } else {
            RegExp regExp = new RegExp(Validator.patternPhone);
            if (regExp.hasMatch(questionSurvey.getAnswerOptionValue(questionSurvey.getAnswerByIndex(0), langSaved))) {
              questionSurvey.errorText = "";
            } else {
              questionSurvey.errorText = appLocalizations.errorMinPhone;
            }
          }
          return questionSurvey.errorText;
        }

      case QuestionSubType.EMAIL:
        {
          if (questionSurvey.getAnswer().isEmpty || utilities.getStringByLang(questionSurvey.getAnswerByIndex(0), langSaved).isEmpty) {
            if (questionSurvey.isRequired == 1) {
              questionSurvey.errorText = appLocalizations.surveyValidate;
            } else {
              questionSurvey.errorText = "";
            }
          } else {
            RegExp regExp = RegExp(Validator.patternEmail);
            if (regExp.hasMatch(questionSurvey.getAnswerOptionValue(questionSurvey.getAnswerByIndex(0), langSaved))) {
              questionSurvey.errorText = "";
            } else {
              questionSurvey.errorText = appLocalizations.validateEmail;
            }
          }
          return questionSurvey.errorText;
        }

      default:
        {
          if (questionSurvey.isRequired == 1 && (questionSurvey.getAnswer().isEmpty || utilities.getStringByLang(questionSurvey.getAnswerByIndex(0), langSaved).isEmpty)) {
            questionSurvey.errorText = appLocalizations.surveyValidate;
          } else {
            questionSurvey.errorText = "";
          }
          return questionSurvey.errorText;
        }
    }
  }

  @override
  void dispose() {
    timerDoneAnyWay?.cancel();
    cancelEvent?.cancel();
    super.dispose();
  }
}
