import 'dart:async';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/RepoUpload.dart';
import 'package:check_in_pro_for_visitor/src/model/ValidateEvent.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class ReviewCheckInNotifier extends MainNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  CancelableOperation cancelCheckIn;
  CancelableOperation cancelEvent;
  CancelableOperation cancelableOperation;
  CancelableOperation cancelableUploadID;
  EventLog eventLog;
  bool isLoading = false;
  bool isInit = false;
  bool isShowPrinter = false;
  bool isScanId = false;
  bool isDelivery = false;
  bool isBuilding = false;
  Timer timerNext;
  bool isEventMode = false;
  var arguments;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  String path;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  MyApp parent;
  Database db;
  var isPrint = false;
  var isCapture = false;
  var isDisable = false;
  PrinterModel printer;
  bool isDoneAnyWay = false;
  Timer timerDoneAnyWay;
  var visitorType = Constants.VT_VISITORS;

  void moveToNext(BuildContext context, HomeNextScreen homeNextScreen, VisitorCheckIn visitor) {
    timerNext?.cancel();
    cancelableOperation?.cancel();
    cancelCheckIn?.cancel();
    switch (homeNextScreen) {
      case HomeNextScreen.CHECK_IN:
        {
          locator<NavigationService>().navigateTo(InputInformationScreen.route_name, 1, arguments: {
            'visitor': visitor,
            'isReplace': true,
            'isScanId': isScanId,
            'isDelivery': isDelivery
          }).then((value) {
            countDownToCheckIn(context);
          });
          notifyListeners();
          break;
        }
      case HomeNextScreen.FACE_CAP:
        {
          locator<NavigationService>().navigateTo(TakePhotoScreen.route_name_temp, 1, arguments: {
            'visitor': visitor,
            'isReplace': true,
            'isScanId': isScanId,
            'isDelivery': isDelivery
          }).then((value) {
            countDownToCheckIn(context);
          });
          notifyListeners();
          break;
        }
      case HomeNextScreen.SCAN_ID:
        {
          locator<NavigationService>().navigateTo(ScanVisionScreen.route_name, 1, arguments: {
            'visitor': visitor,
            'isReplace': true,
            'isScanId': isScanId,
            'isDelivery': isDelivery
          }).then((value) {
            countDownToCheckIn(context);
          });
          notifyListeners();
          break;
        }
      case HomeNextScreen.THANK_YOU:
        {
          locator<NavigationService>()
              .pushNamedAndRemoveUntil(ThankYouScreen.route_name, WaitingScreen.route_name, arguments: {
            'visitor': visitor,
          });
          notifyListeners();
          break;
        }
      case HomeNextScreen.COVID:
        {
          locator<NavigationService>()
              .pushNamedAndRemoveUntil(CovidScreen.route_name, WaitingScreen.route_name, arguments: {
            'visitor': visitor,
          });
          notifyListeners();
          break;
        }
      default:
        {
          break;
        }
    }
  }

  void checkIn(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    timerNext?.cancel();
    var visitor = arguments["visitor"] as VisitorCheckIn;
    path = visitor.imagePath;
    if (visitor.visitorType == null || visitor.visitorType.isEmpty) {
      var type = TypeVisitor.VISITOR;
      var listType = await db.visitorTypeDAO.getAlls();
      if (listType != null && listType.isNotEmpty) {
        type = listType[0].settingKey;
      }
      if (isDelivery) {
        type = TypeVisitor.DELIVERY;
      }
      visitor.visitorType = type;
    }
    if (parent.isOnlineMode) {
      if (isScanId) {
        await uploadIdCardOnline(context, visitor);
      } else if (isEventMode) {
        actionOff(context, visitor);
      } else if (isCapture) {
        await uploadFace(context, visitor);
      } else {
        await checkInOnline(context, visitor);
      }
    } else {
      await checkInOffline(context, visitor, isCapture);
    }
  }

  Future<void> actionOff(BuildContext context, VisitorCheckIn visitor) async {
    EventLog other = await db.eventLogDAO.getFirstLog();
    eventLog = EventLog.copyWithVisitor(visitor, other);
    eventLog?.signIn = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    var userInfor = await Utilities().getUserInfor();
    eventLog?.signInBy = userInfor?.deviceInfo?.id ?? 0;
    eventLog?.isNew = true;
    var fileBytes = await Utilities().rotateAndResize(this.path);
    var file = await Utilities().saveLocalFile(
        Constants.FOLDER_FACE_OFFLINE, visitor.phoneNumber, eventLog?.signIn?.toString(), Constants.PNG_ETX, fileBytes);
    visitor.imagePath = file?.path ?? "";
    eventLog?.imagePath = file?.path ?? "";
    var id = await db.eventLogDAO.insertNew(eventLog);
    eventLog?.id = id;
    doneCheckIn(context, visitor);
  }

  Future<SharedPreferences> getType(BuildContext context, String settingKey) async {
    visitorType = await Utilities().getTypeInDb(context, settingKey);
    printer = await Utilities().getPrinter();
    isPrint = await Utilities().checkIsPrint(context, settingKey);
    isCapture = await Utilities().checkIsCapture(context, settingKey);
    isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
    arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    isDelivery = arguments["isDelivery"] as bool ?? false;
    isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    return preferences;
  }

  Future checkInOffline(BuildContext context, VisitorCheckIn visitor, bool isCapture) async {
    var checkInDate = DateTime.now().toUtc().millisecondsSinceEpoch;
    if (isScanId) {
      var fileBytes = await Utilities().rotateAndResize(visitor.imageIdPath);
      var file = await Utilities().saveLocalFile(
          Constants.FOLDER_ID_OFFLINE, visitor.phoneNumber, checkInDate.toString(), Constants.PNG_ETX, fileBytes);
      visitor.imageIdPath = file.path;
    }
    if (isCapture) {
      var fileBytes = await Utilities().rotateAndResize(visitor.imagePath);
      var file = await Utilities().saveLocalFile(
          Constants.FOLDER_FACE_OFFLINE, visitor.phoneNumber, checkInDate.toString(), Constants.PNG_ETX, fileBytes);
      visitor.imagePath = file.path;
      await db.visitorCheckInDAO.insertNewOrUpdateOld(visitor, checkInDate);
      if (visitor.fromCompany != null && visitor.fromCompany.isNotEmpty) {
        db.visitorCompanyDAO.insertCompanyName(visitor.fromCompany.trim());
      }
      doneCheckIn(context, visitor);
    } else {
      visitor.imagePath = null;
      await db.visitorCheckInDAO.insertNewOrUpdateOld(visitor, checkInDate);
      doneCheckIn(context, visitor);
    }
  }

  Future checkInOnline(BuildContext context, VisitorCheckIn visitor) async {
    cancelableOperation?.cancel();
    cancelCheckIn?.cancel();
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    if (isEventMode) {
      checkInEvent(visitor, context);
    } else {
      checkInNormal(visitor, context);
    }
//    await cancelCheckIn?.valueOrCancellation();
  }

  Future<void> checkInNormal(VisitorCheckIn visitor, BuildContext context) async {
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      notifyListeners();
      //Callback SUCCESS
      VisitorCheckIn visitorCheckIn = VisitorCheckIn.fromJson(baseResponse.data);
      db.visitorCheckInDAO.insertNewOrUpdateOld(visitor, null, isAddVisitorLog: false);
      if (visitorCheckIn.fromCompany != null && visitorCheckIn.fromCompany.isNotEmpty) {
        db.visitorCompanyDAO.insertCompanyName(visitorCheckIn.fromCompany.trim());
      }
      doneCheckIn(context, visitor);
    }, (Errors message) async {
      //Callback ERROR
      btnController.stop();
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      notifyListeners();
    });

    cancelCheckIn = await ApiRequest().requestVisitorCheckIn(context, visitor.toJson(), listCallBack);
  }

  Future<void> checkInEvent(VisitorCheckIn visitor, BuildContext context) async {
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      notifyListeners();
      //Callback SUCCESS
      db.visitorCheckInDAO.insertNewOrUpdateOld(visitor, null, isAddVisitorLog: false);
      if (visitor.fromCompany != null && visitor.fromCompany.isNotEmpty) {
        db.visitorCompanyDAO.insertCompanyName(visitor.fromCompany.trim());
      }
      doneCheckIn(context, visitor);
    }, (Errors message) async {
      //Callback ERROR
      btnController.stop();
      if (message.description == Constants.EVENT_ERROR) {
        validateActionEvent(visitor, context);
      } else {
        Utilities().showErrorPop(context, message.description, null, () {
          locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
        });
        isLoading = false;
      }
      notifyListeners();
    });
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelCheckIn = await ApiRequest().requestInviteEvent(context, visitor.toJson(), eventId, listCallBack);
  }

  Future validateActionEvent(VisitorCheckIn visitorCheckIn, BuildContext context) async {
    Utilities().cancelWaiting();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var validate = ValidateEvent.fromJson(baseResponse.data);
      if (validate.status == Constants.VALIDATE_IN) {
        actionEventMode(visitorCheckIn, context);
      } else if (validate.status == Constants.VALIDATE_OUT) {
        locator<NavigationService>()
            .pushNamedAndRemoveUntil(FeedBackScreen.route_name, WaitingScreen.route_name, arguments: {
          'visitorCheckIn': visitorCheckIn,
          'visitorLog': null,
          'inviteCode': null,
          'phoneNumber': visitorCheckIn.phoneNumber,
          'isSyncNow': false,
          'isEvent': true,
        });
      }
    }, (Errors message) async {
      isLoading = false;
      btnController.stop();
      Utilities().showErrorPop(context, message.description, Constants.AUTO_HIDE_LONG, () {
        locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
      }, callbackDismiss: () {
        locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
      });
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var companyId = userInfor.companyInfo.id ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest().requestValidateActionEvent(
        context, companyId, locationId, null, visitorCheckIn.phoneNumber, eventId, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future actionEventMode(VisitorCheckIn visitorCheckIn, BuildContext context) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var visitor = VisitorCheckIn.fromJson(baseResponse.data);
      doneCheckIn(context, visitor);
    }, (Errors message) async {
      btnController.stop();
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, null);
      }
      isLoading = false;
      notifyListeners();
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest().requestActionEvent(context, locationId, null, visitorCheckIn.phoneNumber,
        visitorCheckIn.faceCaptureFile, visitorCheckIn.faceCaptureRepoId, eventId, null, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future uploadIdCardOnline(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var repoUpload = RepoUpload.fromJson(baseResponse.data);
      visitorCheckIn.idCardRepoId = repoUpload.captureFaceRepoId;
      visitorCheckIn.idCardFile = repoUpload.captureFaceFile;
      if (isCapture) {
        uploadFace(context, visitorCheckIn);
      } else {
        checkInOnline(context, visitorCheckIn);
      }
    }, (Errors message) {
      if (message.code != -2) {
        if (message.description == Constants.ERROR_LIMIT_UPLOAD) {
          checkInOnline(context, visitorCheckIn);
        } else {
          btnController.stop();
          Utilities().showErrorPop(context, message.description, null, null);
        }
      } else {
        btnController.stop();
      }
    });
    cancelableUploadID = await ApiRequest().requestUploadIDCard(context, visitorCheckIn.imageIdPath, callBack);
    await cancelableUploadID.valueOrCancellation();
  }

  Future uploadFace(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var repoUpload = RepoUpload.fromJson(baseResponse.data);
      visitorCheckIn.faceCaptureRepoId = repoUpload.captureFaceRepoId;
      visitorCheckIn.faceCaptureFile = repoUpload.captureFaceFile;
      checkInOnline(context, visitorCheckIn);
    }, (Errors message) {
      if (message.code != -2) {
        if (message.description == Constants.ERROR_LIMIT_UPLOAD) {
          checkInOnline(context, visitorCheckIn);
        } else {
          checkInOnline(context, visitorCheckIn);
//          btnController.stop();
//          Utilities().showErrorPop(context, message.description, null, null);
        }
      } else {
        btnController.stop();
      }
    });
    cancelableOperation = await ApiRequest().requestUploadFace(context, visitorCheckIn.imagePath, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future<void> doneCheckIn(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    if (isPrint) {
      isShowPrinter = true;
      notifyListeners();
      callPrinter(context, visitorCheckIn);
    } else {
      handlerDone(context, visitorCheckIn);
    }
  }

  void countDownToNext(BuildContext context, VisitorCheckIn visitorCheckIn) {
    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () async {
      isLoading = false;
      isShowPrinter = false;
      notifyListeners();
      if (await Utilities().isSurveyCovid(context, visitorCheckIn.visitorType)) {
        moveToNext(context, HomeNextScreen.COVID, visitorCheckIn);
      } else {
        moveToNext(context, HomeNextScreen.THANK_YOU, visitorCheckIn);
      }
    });
  }

  void countDownToCheckIn(BuildContext context) {
    isInit = true;
    timerNext = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timer.tick == Constants.DONE_CHECK_IN - 1) {
        disableButton();
      } else if (timer.tick == Constants.DONE_CHECK_IN) {
        btnController?.start();
      }
    });
  }

  void disableButton() {
    isDisable = true;
    notifyListeners();
  }

  double getWidthCard(BuildContext context) {
    return 200 +
        locator<AppDestination>()
            .getPadding(context, AppDestination.PADDING_BIGGER, AppDestination.PADDING_BIGGER_HORIZONTAL, false) +
        (Constants.MAX_NUMBER_NAME * locator<AppDestination>().getTextBigger(context));
  }

  Future<void> callPrinter(BuildContext context, VisitorCheckIn visitorCheckIn) async {
    timerDoneAnyWay = Timer(Duration(seconds: Constants.TIMEOUT_PRINTER), () {
      if (!isDoneAnyWay) {
        handlerDone(context, visitorCheckIn);
      }
    });
    String response = "";
    try {
      if (printer != null) {
        RenderRepaintBoundary boundary = repaintBoundary.currentContext.findRenderObject();
        await Utilities().printJob(printer, boundary);
        if (!isDoneAnyWay) {
          timerDoneAnyWay?.cancel();
          handlerDone(context, visitorCheckIn);
        }
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      Utilities().printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        handlerDone(context, visitorCheckIn);
      }
    } catch (e) {}
  }

  void handlerDone(BuildContext context, VisitorCheckIn visitorCheckIn) {
    isDoneAnyWay = true;
    btnController.success();
    locator<SyncService>().syncEventNow(context, eventLog);
    countDownToNext(context, visitorCheckIn);
  }

  @override
  void dispose() {
    timerDoneAnyWay?.cancel();
    timerNext?.cancel();
    cancelEvent?.cancel();
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    cancelableOperation?.cancel();
    cancelCheckIn?.cancel();
    super.dispose();
  }
}
