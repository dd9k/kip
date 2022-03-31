import 'dart:async';
import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/IDScanResult.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardModel.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardNew.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/IDCardOld.dart';
import 'package:check_in_pro_for_visitor/src/model/idCard/PassPort.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/Constants.dart';
import '../../utilities/Utilities.dart';

class ScanVisionNotifier extends MainNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  CameraController controller;
  bool isRebuild = false;
  bool reloadCamera = false;
  String message = "";
  String path = "";
  Timer timerNext;
  Timer timerTakePhoto;
  Timer timerCancelDetect;
  int turnCamera = 0;
  bool isStreamStopping = false;
  CancelableOperation cancelSearch;
  CancelableOperation cancelableOperation;
  CancelableOperation cancelableORC;
  bool imageStream = false;
  bool isTakePhoto = false;
  List<dynamic> recognitions;
  int imgHeight;
  int imgWidth;
  var isEventMode = false;
  var isCheckIn = true;
  var isDetectingQCR = false;
  var isDelivery = false;
  var isReturn = false;
  var isReplace = false;
  var visitorType = Constants.VT_VISITORS;
  BuildContext _cx;
  var capAgain = true;
  bool isProcessing = false;
  VisitorCheckIn visitorBackup;
  bool doneCamera = false;
  Future<void> convertController;
  int numberTake = 1;

  Future<void> initializeController(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    _cx = context;
    timerTakePhoto?.cancel();
    isTakePhoto = false;
    isReplace = arguments["isReplace"] as bool ?? false;
    isDelivery = arguments["isDelivery"] as bool ?? false;
    isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    isCheckIn = (arguments["isCheckIn"] as bool) ?? true;
    visitorBackup = arguments["visitor"] as VisitorCheckIn;

    var useFrontCamera = (preferences.getBool(Constants.KEY_FRONT_CAMERA) ?? true);
    var indexCamera = 0;
    if (useFrontCamera) {
      indexCamera = 1;
    }
    final cameras = await availableCameras();
    var frontCamera = cameras[indexCamera];
    controller = CameraController(frontCamera, ResolutionPreset.max, enableAudio: false);
    return convertController = controller.initialize().then((value) {
      countDownTakePhoto(context);
    });
  }

  Future countDownTakePhoto(BuildContext context) async {
    if (!capAgain) {
      return;
    }
    timerTakePhoto?.cancel();
    var timeToTakePhoto = (await Utilities().getConfigKios()).picCountdownInterval + 1;
    timerTakePhoto = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (timer.tick < timeToTakePhoto) {
        message = (timeToTakePhoto - timer.tick).toString();
        notifyListeners();
      } else {
        await takePhoto(context);
      }
    });
  }

  void takePhotoAgain() {
    numberTake++;
    isTakePhoto = false;
    timerNext?.cancel();
    countDownTakePhoto(_cx);
  }

  void rebuildCamera() {
    isRebuild = !isRebuild;
    notifyListeners();
  }

  Future takePhoto(BuildContext context) async {
    if (!isTakePhoto) {
      Utilities().moveToWaiting();
      isTakePhoto = true;
      timerTakePhoto?.cancel();
      message = "";
      notifyListeners();
      try {
        // Ensure that the camera is initialized.
        await convertController;
        var cacheDirectory = await getTemporaryDirectory();
        final path = join(
          // Store the picture in the temp directory.
          // Find the temp directory using the `path_provider` plugin.
          cacheDirectory.path,
          '${DateTime.now()}${Constants.SCAN_VISION}.png',
        );
        this.path = path;
        await Future.delayed(new Duration(milliseconds: 100));
        await controller.takePicture(path);
        _showPopupWaiting();
        final filePath = await saveToFileLocal(this.path, DateTime.now().toUtc().millisecondsSinceEpoch.toString());
//      uploadIdCardOnline(context, filePath);
        requestOCR(context, filePath);
      } catch (e) {
        print(e);
      }
    }
  }

  Future requestOCR(BuildContext context, String path) async {
    isDetectingQCR = true;
    timerCancelDetect?.cancel();
    timerCancelDetect = Timer(Constants.CONNECTION_TIME_OUT_OCR, () {
      if (isDetectingQCR) {
        isDetectingQCR = false;
        cancelableORC?.cancel();
        showPopupError(context, AppLocalizations.of(context).scanIdFail);
      }
    });
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      isDetectingQCR = false;
      timerCancelDetect?.cancel();
      IDCardModel idCardModel;
      switch (baseResponse.typeCard) {
        case IDCardType.ID_CARD_NEW:
          {
            idCardModel = IDCardNew.fromJson(baseResponse.data);
            break;
          }
        case IDCardType.ID_CARD_OLD:
          {
            idCardModel = IDCardOld.fromJson(baseResponse.data);
            break;
          }
        case IDCardType.PASSPORT:
          {
            idCardModel = PassPort.fromJson(baseResponse.data);
            break;
          }
        default:
          {
            idCardModel = IDCardNew.fromJson(baseResponse.data);
            break;
          }
      }
      if (isCheckIn) {
        if (idCardModel.getID() == null || idCardModel.getID().isEmpty) {
          showPopupError(context, AppLocalizations.of(context).scanIdFail);
        } else {
          if (isReplace) {
            var visitOld = idCardModel.createVisitor(visitorBackup, true);
            moveToNextPage(context, visitOld, null, false);
          } else {
            searchVisitor(context, idCardModel);
          }
        }
      } else {
        if (idCardModel.getID() == null || idCardModel.getID().isEmpty) {
          showPopupError(context, AppLocalizations.of(context).scanIdFail);
        } else {
          searchVisitorCheckOut(context, idCardModel);
        }
      }
    }, (Errors message) async {
      isDetectingQCR = false;
      timerCancelDetect?.cancel();
      if (message.code != -2) {
//        var mess = message.description;
//        Utilities().showErrorPop(context, mess, null, () {});
        showPopupError(context, AppLocalizations.of(context).scanIdFail);
      }
    });

    cancelableORC = await ApiRequest().requestOCRTemp(context, path, callBack);
    await cancelableORC.valueOrCancellation();
  }

  Future searchVisitorCheckOut(BuildContext context, IDCardModel idCardModel) async {
//    if (parent.isOnlineMode) {
//      bool isHaveOff = await searchOffline(context, phone);
//      if (!isHaveOff) {
//        await searchOnline(context, phone);
//      }
    await searchCheckOutOnline(context, idCardModel);
//    } else {
//      await searchCheckOutOffline(context, idCardModel);
//    }
  }

  Future<bool> searchCheckOutOffline(BuildContext context, IDScanResult idScanResult) async {
    var dateCheckOut = DateTime.now().toUtc().millisecondsSinceEpoch;
    var result = await db.visitorLogDAO.checkExistCheckOutByIdCard(idScanResult.id, dateCheckOut);
    if (result is VisitorLog) {
      var userInfor = await Utilities().getUserInfor();
      var visitorDetail = await db.visitorCheckInDAO.getByIdCard(idScanResult.id, userInfor.companyInfo.id);
//      if (parent.isOnlineMode) {
//        isSyncNow = true;
//      }
      moveToNextPage(context, visitorDetail, result, false);
      return true;
    } else if (result is String) {
      if (parent.isOnlineMode) {
        return false;
      }
      Errors errors;
      if (result == "GEN_DataNotFound") {
        errors = Errors(0, AppLocalizations.of(context).noData, DialogType.ERROR);
      } else {
        errors = Errors(0, AppLocalizations.of(context).noVisitor, DialogType.ERROR);
      }
      noVisitorAlert(errors, context);
      return false;
    }
  }

  Future searchCheckOutOnline(BuildContext context, IDCardModel idCardModel) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var visitorDetail = VisitorCheckIn.fromJson(baseResponse.data);
      moveToNextPage(context, visitorDetail, null, false);
    }, (Errors message) async {
      _dissmissPopupWaiting();
      if (message.code < 0) {
        if (message.code != -2) {
          var mess = message.description;
          if (message.description.contains("field_name")) {
            mess = message.description.replaceAll("field_name", AppLocalizations.of(context).inviteCode);
          }
          Utilities().showErrorPop(context, mess, null, () {});
        } else {}
      } else {
        noVisitorAlert(message, context);
      }
    });

    cancelableOperation = await ApiRequest().requestSearchVisitorCheckOut(context, null, idCardModel.getID(), callBack);
    await cancelableOperation.valueOrCancellation();
  }

  void noVisitorAlert(Errors message, BuildContext context) {
    var errorText = message.description;
    if (message.description == AppLocalizations.of(context).noData) {
      errorText = AppLocalizations.of(context).noPhone;
    }
    showPopupError(context, errorText);
//    Utilities().showErrorPop(context, errorText, null, () {
//      locator<NavigationService>().navigatePop();
//    });
  }

  Future searchVisitor(BuildContext context, IDCardModel idCardModel) async {
//    if (parent.isOnlineMode) {
    await searchVisitorOnline(context, idCardModel);
//    } else {
//      await searchVisitorOffline(context, idScanResult);
//    }
  }

//  Future searchVisitorOffline(
//      BuildContext context, IDScanResult idScanResult) async {
//    var userInfor = await Utilities().getUserInfor();
//    var visitor = await db.visitorCheckInDAO
//        .getByIdCard(idScanResult.id, userInfor.companyInfo.id);
//    if (visitor == null) {
//      isReturn = false;
//      VisitorCheckIn visitorCheckIn = VisitorCheckIn.inital();
//      visitorCheckIn.fullName = idScanResult.fullName;
//      visitorCheckIn.idCard = idScanResult.id;
//      moveToNextPage(context, visitorCheckIn, null, false);
//    } else {
//      isReturn = true;
//      moveToNextPage(context, visitor, null, false);
//    }
//  }

//  Future uploadIdCardOnline(BuildContext context, String path) async {
//    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {}, (Errors message) {});
//    ApiRequest().requestUploadIDCard(context, path, callBack);
//  }

  Future searchVisitorOnline(BuildContext context, IDCardModel idCardModel) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      if (baseResponse.data == null) {
        isReturn = false;
        VisitorCheckIn visitor = idCardModel.createVisitor(visitorBackup, true);
        moveToNextPage(context, visitor, null, false);
      } else {
        isReturn = true;
        VisitorCheckIn visitor = idCardModel.createVisitor(VisitorCheckIn.fromJson(baseResponse.data), false);
        initDataBackup(visitor);
        moveToNextPage(context, visitor, null, false);
      }
    }, (Errors message) async {
      if (message.code != -2) {
        _dissmissPopupWaiting();
        Utilities().showErrorPop(context, message.description, null, () {});
      } else {}
    });

    cancelSearch = await ApiRequest().requestSearchVisitor(context, null, idCardModel.getID(), callBack);
    await cancelSearch.valueOrCancellation();
  }

  Future<String> saveToFileLocal(String path, String filename) async {
    var fileBytes = await Utilities().rotateAndResize(path);
    var file = await Utilities().saveLocalFile(Constants.FOLDER_TEMP, '', filename, Constants.PNG_ETX, fileBytes);
    return file.path;
  }

  void initDataBackup(VisitorCheckIn visitor) {
    if (isCheckIn) {
      visitor.toCompany = visitorBackup.toCompany;
      visitor.toCompanyId = visitorBackup.toCompanyId;
      visitor.floor = visitorBackup.floor;
      visitor.contactPersonId = visitorBackup.contactPersonId;
      visitor.visitorType = visitorBackup.visitorType;
    }
  }

  Future<SharedPreferences> getType(BuildContext context, String settingKey) async {
    visitorType = await Utilities().getTypeInDb(context, settingKey);
    return preferences;
  }

  Future<void> moveToNextPage(
      BuildContext context, VisitorCheckIn visitorNew, VisitorLog visitorLog, bool isScanFail) async {
    _dissmissPopupWaiting();
    controller?.dispose();
    this.message = "";
    capAgain = false;
    reloadCamera = true;
    notifyListeners();
    timerTakePhoto?.cancel();
    timerNext?.cancel();
    var convertVisitor = visitorNew;
    if (isReplace) {
      List<CheckInFlow> flows = await db.checkInFlowDAO.getbyTemplateCode(visitorNew.visitorType);
      convertVisitor = VisitorCheckIn.createVisitorByFlow(flows, visitorNew);
      convertVisitor.visitorType = visitorNew.visitorType;
    }

    if (isDelivery) {
      convertVisitor.visitorType = TypeVisitor.DELIVERY;
    }
    convertVisitor.imageIdPath = path;
    convertVisitor.toCompanyId = visitorBackup.toCompanyId;
    convertVisitor.floor = visitorBackup.floor;
    convertVisitor.toCompany = visitorBackup.toCompany;
    convertVisitor.contactPersonId = visitorBackup.contactPersonId;
    if (isCheckIn) {
      CompanyBuilding companyBuilding = (arguments["companyBuilding"] as CompanyBuilding);
      if (isScanFail) {
        locator<NavigationService>().navigateTo(InputPhoneScreen.route_name, 1, arguments: {
          'isDelivery': isDelivery,
          'visitor': convertVisitor,
          'haveType': true,
          'companyBuilding': companyBuilding
        }).then((value) {
          handlerBack();
        });
      } else if (isReplace) {
        locator<NavigationService>().pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
            arguments: {
              'visitor': convertVisitor,
              'isShowBack': false,
              'isScanId': true,
              'isDelivery': isDelivery
            }).then((value) {
          handlerBack();
        });
      } else {
        List<VisitorType> listType = await db.visitorTypeDAO.getAlls();
        bool isScanIdStep = convertVisitor.visitorType != null;
        if (!isDelivery) {
          if (convertVisitor.visitorType == null ||
              await db.visitorTypeDAO.getVisitorTypeBySettingKey(convertVisitor.visitorType) == null) {
            if (listType.isNotEmpty) {
              convertVisitor.visitorType = listType[0].settingKey;
            } else {
              convertVisitor.visitorType = TypeVisitor.VISITOR;
            }
          }
        } else {
          convertVisitor.visitorType = TypeVisitor.DELIVERY;
        }
        List<CheckInFlow> flows = await db.checkInFlowDAO.getbyTemplateCode(convertVisitor.visitorType);
        var listHaveAlways = flows.where((element) =>
            element.getRequestType() == RequestType.ALWAYS || element.getRequestType() == RequestType.ALWAYS_NO);
        bool isHaveAlways = (listHaveAlways != null && listHaveAlways.isNotEmpty);
        convertVisitor = VisitorCheckIn.createVisitorByFlow(flows, visitorNew);
        convertVisitor.visitorType = visitorNew.visitorType;
        convertVisitor.toCompanyId = visitorBackup.toCompanyId;
        convertVisitor.toCompany = visitorBackup.toCompany;
        convertVisitor.contactPersonId = visitorBackup.contactPersonId;
        convertVisitor.floor = visitorBackup.floor;
        var isCapture = await Utilities().checkIsCapture(context, convertVisitor?.visitorType);
        var isAllowContact = await Utilities().checkAllowContact(_cx, convertVisitor?.visitorType);
        bool isSurvey = await Utilities().isSurveyCustom(_cx, convertVisitor?.visitorType);
        bool isBuilding = companyBuilding != null;
        Utilities().createStep(_cx, listType.length > 1, isBuilding, isScanIdStep, isAllowContact, isSurvey,
            isHaveAlways, isReturn, isCapture);
        if (isAllowContact) {
          locator<NavigationService>().navigateTo(ContactScreen.route_name, 1, arguments: {
            'visitor': convertVisitor,
            'isShowBack': false,
            'isScanId': true,
            'isDelivery': isDelivery,
            'isReplace': false,
            'isReturn': isReturn,
            'isCapture': isCapture,
            'isHaveAlways': isHaveAlways,
            'companyBuilding': companyBuilding,
          }).then((value) {
            handlerBack();
          });
        } else if (isHaveAlways || !isReturn) {
          locator<NavigationService>().navigateTo(InputInformationScreen.route_name, 1, arguments: {
            'visitor': convertVisitor,
            'isShowBack': false,
            'isScanId': true,
            'isDelivery': isDelivery,
            'isReturn': isReturn,
            'companyBuilding': companyBuilding,
          }).then((value) {
            handlerBack();
          });
        } else if (isSurvey) {
          locator<NavigationService>().navigateTo(SurveyScreen.route_name, 1, arguments: {
            'visitor': convertVisitor,
            'isReplace': false,
            'isScanId': true,
            'isShowBack': true,
            'isDelivery': isDelivery,
            'isCapture': isCapture,
            'companyBuilding': companyBuilding,
          }).then((_) {
            handlerBack();
          });
        } else if (isCapture) {
          locator<NavigationService>().navigateTo(TakePhotoScreen.route_name, 1, arguments: {
            'visitor': convertVisitor,
            'isReplace': false,
            'isShowBack': true,
            'isScanId': true,
            'isDelivery': isDelivery,
            'companyBuilding': companyBuilding,
          }).then((value) {
            handlerBack();
          });
        } else {
          locator<NavigationService>().pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
              arguments: {'visitor': convertVisitor, 'isShowBack': false, 'isScanId': true, 'isDelivery': isDelivery, 'companyBuilding': companyBuilding,});
        }
      }
    } else {
      if (isScanFail) {
        locator<NavigationService>()
            .navigateTo(CheckOutScreen.route_name, 1, arguments: {'isDelivery': isDelivery}).then((value) {
          handlerBack();
        });
      } else {
        locator<NavigationService>()
            .pushNamedAndRemoveUntil(FeedBackScreen.route_name, WaitingScreen.route_name, arguments: {
          'visitorCheckIn': convertVisitor,
          'visitorLog': visitorLog,
          'inviteCode': null,
          'isSyncNow': false,
          'isShowBack': false,
          'isDelivery': isDelivery,
        });
      }
    }
  }

  Future<bool> isShowVisitorType(
      VisitorCheckIn visitorCheckIn, List<CheckInFlow> flows, List<VisitorType> listType) async {
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    bool isHaveVisitorType = false;
    flows.forEach((CheckInFlow element) {
      if (element.stepCode == StepCode.VISITOR_TYPE) {
        isHaveVisitorType = true;
      }
    });
    return (listType.length >= 2) && !isEventMode && isHaveVisitorType && !isDelivery;
  }

  void handlerBack() {
    capAgain = true;
    reloadCamera = false;
    takePhotoAgain();
    notifyListeners();
  }

  void showPopupError(BuildContext context, String content) {
    _dissmissPopupWaiting();
    if (!capAgain) {
      return;
    }
    capAgain = false;
    if (numberTake <= 3) {
      utilities.showNoButtonDialog(context, false, DialogType.INFO, Constants.AUTO_HIDE_LESS,
          AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION), content, () {
            Utilities().moveToWaiting();
            capAgain = true;
            takePhotoAgain();
          });
    } else {
      Utilities().showTwoButtonDialog(
          context,
          DialogType.INFO,
          null,
          AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
          content,
          isReplace ? AppLocalizations.of(context).btnBack : AppLocalizations.of(context).usePhone,
          AppLocalizations.of(context).translate(AppString.BUTTON_TRY_AGAIN), () {
        if (isReplace) {
          locator<NavigationService>().navigatePop(context);
        } else {
          initDataBackup(visitorBackup);
          moveToNextPage(context, visitorBackup, null, true);
        }
      }, () {
        Utilities().moveToWaiting();
        capAgain = true;
        takePhotoAgain();
      });
    }
  }

  void _showPopupWaiting() {
    if (!capAgain) {
      return null;
    }
    isProcessing = true;
    notifyListeners();
  }

  void _dissmissPopupWaiting() {
    if (!capAgain) {
      return null;
    }
    isProcessing = false;
    notifyListeners();
  }

  @override
  void dispose() {
    capAgain = false;
    timerTakePhoto?.cancel();
    timerNext?.cancel();
    controller?.dispose();
    cancelableORC?.cancel();
    cancelableOperation?.cancel();
    cancelSearch?.cancel();
    super.dispose();
  }
}
