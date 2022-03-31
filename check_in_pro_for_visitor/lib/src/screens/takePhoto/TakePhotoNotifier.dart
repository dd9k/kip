import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:async/async.dart';
import 'package:camera/camera.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/EventDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/RepoUpload.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:tflite/tflite.dart';
import '../../constants/Constants.dart';
import '../../utilities/Utilities.dart';
import 'dart:ui' as ui;

class TakePhotoNotifier extends MainNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  CancelableOperation cancelEvent;
  CameraController controller;
  bool reloadCamera = false;
  bool doneCamera = false;
  bool visibleButton = false;
  bool isRebuild = false;
  bool isScanId = false;
  bool isDelivery = false;
  bool isLoading = false;
  bool isCountDown = false;
  bool isBuilding = false;
  String inviteCode = "";
  String message = "";
  String path = "";
  Timer timerNext;
  Timer timerTakePhoto;
  int turnCamera = 0;
  bool _isDetecting = false;
  bool isStreamStopping = false;
  bool imageStream = false;
  bool isTakePhoto = false;
  bool isNext = false;
  List<dynamic> recognitions;
  int imgHeight;
  int imgWidth;
  bool isInit = false;
  PrinterModel printer;
  CancelableOperation cancelUpload;
  var visitorType = Constants.VT_VISITORS;
  bool isDoneAnyWay = false;
  Timer timerDoneAnyWay;
  bool isProcessing = false;
  String messagePopup = "";
  Future<void> convertController;
  AsyncMemoizer<void> memCache = AsyncMemoizer();
  bool isEventMode;
  EventLog eventLog;
  EventDetail eventDetail;
  final assetsAudioPlayer = AssetsAudioPlayer();
  String langSaved = Constants.EN_CODE;
  VisitorCheckIn visitor;
  AsyncMemoizer<SharedPreferences> memCachePrint = AsyncMemoizer();

  Future<void> initializeController(BuildContext context) async {
    return memCache.runOnce(() async {
      WidgetsFlutterBinding.ensureInitialized();
      timerTakePhoto?.cancel();
      _isDetecting = false;
      isTakePhoto = false;
      isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
      final cameras = await availableCameras();
      var frontCamera = cameras[1];
      controller = CameraController(
          frontCamera,
          ResolutionPreset.high, enableAudio: false
      );
      if (!isInit) {
        isInit = true;
//        await Tflite.loadModel(
//            model: "assets/tflite/ssd_mobilenet.tflite",
//            labels: "assets/tflite/ssd_mobilenet.txt");
        assetsAudioPlayer.open(Audio("assets/audios/ding.mp3"), showNotification: false, autoStart: false);
        assetsAudioPlayer.setVolume(1.0);
      }
      if (isEventMode) {
        eventDetail = await this.db.eventDetailDAO.getEventDetail();
      }
      langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;

      return convertController = controller.initialize().then((value) {
        jobDoneCamera(context);
      });
    });
  }

  Future<String> createQRImage() async {
    final qrValidationResult = QrValidator.validate(
      data: getDataQR(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
    var path = await Utilities().getLocalPathFile(Constants.FOLDER_TEMP, "qr_qr", "", null);
    var file = await Utilities().writeToFile(picData, path);
    var base64 = base64Encode(file.readAsBytesSync());
    return base64;
  }

  String getDataQR() {
    FormatQRCode formatQRCode;
    if (visitor.inviteCode != null) {
      formatQRCode = FormatQRCode(FormatQRCode.EVENT, visitor.inviteCode);
    } else if (visitor.phoneNumber != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_PHONE, visitor.phoneNumber);
    } else if (visitor.idCard != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_ID, visitor.idCard);
    }
    return jsonEncode(formatQRCode);
  }

  void jobDoneCamera(BuildContext context) {
//    var isDetectFace = preferences.getBool(Constants.KEY_FACE_DETECT) ?? false;
//    if (isDetectFace) {
//      _isDetecting = false;
//      startStream(context);
//    } else {
      countDownTakePhoto(context);
//    }
  }

  void startStream(BuildContext context) {
    if (_isDetecting) return;
    _isDetecting = true;
    if (isTakePhoto) return;
    controller.startImageStream((CameraImage image) async {
      if (!isStreamStopping) {
        isStreamStopping = true;
        await controller.stopImageStream();
        detectFace(image, context);
      } else {}
    });
  }

  Future<void> detectFace(CameraImage image, BuildContext context) async {
//    int startTime = new DateTime.now().millisecondsSinceEpoch;
//    await Tflite.detectObjectOnFrame(
//      bytesList: image.planes.map((plane) {
//        return plane.bytes;
//      }).toList(),
//      model: "SSDMobileNet",
//      imageHeight: image.height,
//      imageWidth: image.width,
//      imageMean: 127.5,
//      imageStd: 127.5,
//      threshold: 0.45,
//    ).then((recognitions) {
//      int endTime = new DateTime.now().millisecondsSinceEpoch;
//      imgHeight = image.height;
//      imgWidth = image.width;
//      var convertList = List.from(recognitions);
//      convertList.removeWhere((element) => element["confidenceInClass"] < 0.7);
//      if (convertList != null && convertList.isNotEmpty) {
//        var isActive = timerTakePhoto?.isActive ?? false;
//        if (!isActive && !isTakePhoto) {
//          countDownTakePhoto(context);
//        }
//      } else {
//        timerTakePhoto?.cancel();
//        this.message = "";
//        notifyListeners();
//      }
//      this.recognitions = convertList;
//      imageStream = !imageStream;
//      notifyListeners();
//      Timer(Duration(milliseconds: 100), () {
//        _isDetecting = false;
//        isStreamStopping = false;
//        startStream(context);
//      });
//    });
  }

  Future uploadOnline(BuildContext context, VisitorCheckIn visitorCheckIn, bool isReplace, bool isPrint) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var repoUpload = RepoUpload.fromJson(baseResponse.data);
      visitorCheckIn.faceCaptureRepoId = repoUpload.captureFaceRepoId;
      visitorCheckIn.faceCaptureFile = repoUpload.captureFaceFile;
      actionEventMode(context, visitorCheckIn, isReplace, isPrint);
    }, (Errors message) {
      if (message.code != -2) {
        if (message.description == Constants.ERROR_LIMIT_UPLOAD) {
          actionEventMode(context, visitorCheckIn, isReplace, isPrint);
        } else {
          _dissmissPopupWaiting();
          actionEventMode(context, visitorCheckIn, isReplace, isPrint);
//          Utilities().showErrorPop(context, message.description, null, null);
        }
      }
    });
    cancelUpload = CancelableOperation.fromFuture(
      ApiRequest().requestUploadFace(context, visitorCheckIn.imagePath, callBack),
      onCancel: () => {},
    );
    await cancelUpload.valueOrCancellation();
  }

  Future actionEventMode(BuildContext context, VisitorCheckIn visitorCheckIn, bool isReplace, bool isPrint) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var visitorDetail = VisitorCheckIn.fromJson(baseResponse.data);
      doneCheckIn(context, visitorDetail, isReplace, isPrint);
    }, (Errors message) async {
      isLoading = false;
      _dissmissPopupWaiting();
      var contentError = message.description;
      if (message.description.contains("field_name")) {
        contentError = AppLocalizations.of(context)
            .errorInviteCode
            .replaceAll("field_name", AppLocalizations.of(context).inviteCode);
      }
      if (message.code != -2) {
        Utilities().showErrorPop(context, contentError, Constants.AUTO_HIDE_LONG, () {}, callbackDismiss: () {
          Utilities().moveToWaiting();
        });
      } else {}
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var inviteCode = arguments["inviteCode"] as String;
    var phoneNumber = arguments["phoneNumber"] as String;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest().requestActionEvent(context, locationId, inviteCode, phoneNumber,
        visitorCheckIn.faceCaptureFile, visitorCheckIn.faceCaptureRepoId, eventId, visitorCheckIn.surveyId, visitorCheckIn.survey, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future<void> doneCheckIn(BuildContext context, VisitorCheckIn visitorCheckIn, bool isReplace, bool isPrint) async {
    if (isPrint && !isReplace) {
      changeMessagePopup(appLocalizations.waitPrinter);
      inviteCode = visitorCheckIn.inviteCode;
      notifyListeners();
      await Future.delayed(new Duration(milliseconds: 500));
      printTemplate(context, visitorCheckIn, isReplace, isPrint);
    } else {
      isDoneAnyWay = true;
      moveToReview(context, visitorCheckIn, isReplace, isPrint);
    }
  }

  Future countDownTakePhoto(BuildContext context) async {
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

  void countDownToNext(BuildContext context) {
    timerNext?.cancel();
    timerNext = Timer(Duration(seconds: Constants.DONE_TAKE_PHOTO), () async {
      await doNext(context);
    });
  }

  Future doNext(BuildContext context) async {
    if (!isNext) {
      isNext = true;
      timerNext?.cancel();
      var visitor = arguments["visitor"] as VisitorCheckIn;
      var isReplace = (arguments["isReplace"] as bool) ?? false;
      var isQRScan = (arguments["isQRScan"] as bool) ?? false;
      eventLog = arguments["eventLog"] as EventLog;
      isDelivery = (arguments["isDelivery"] as bool) ?? false;
      visitor?.imagePath = this.path;
      var isPrint = await Utilities().checkIsPrint(context, visitor?.visitorType);
      if (isQRScan) {
        _showPopupWaiting(appLocalizations.waitingTitle);
        if (isEventMode) {
          actionOff(context, isReplace, isPrint);
        } else {
          uploadOnline(context, visitor, isReplace, isPrint);
        }
      } else {
        moveToReview(context, visitor, isReplace, isPrint);
      }
    }
  }

  Future<void> actionOff(BuildContext context, bool isReplace, bool isPrint) async {
    eventLog?.signIn = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    var userInfor = await Utilities().getUserInfor();
    eventLog?.signInBy = userInfor?.deviceInfo?.id ?? 0;
    var visitor = VisitorCheckIn.copyWithEventLog(eventLog);
    var fileBytes = await Utilities().rotateAndResize(this.path);
    var file = await Utilities().saveLocalFile(
        Constants.FOLDER_FACE_OFFLINE, visitor.phoneNumber, eventLog?.signIn?.toString(), Constants.PNG_ETX, fileBytes);
    visitor.imagePath = file?.path ?? "";
    eventLog?.imagePath = file?.path ?? "";
    doneCheckIn(context, visitor, isReplace, isPrint);
  }

  Future<void> printTemplate(BuildContext context, VisitorCheckIn visitorCheckIn, bool isReplace, bool isPrint) async {
    isLoading = true;
    notifyListeners();
    timerDoneAnyWay = Timer(Duration(seconds: Constants.TIMEOUT_PRINTER), () {
      if (!isDoneAnyWay) {
        isDoneAnyWay = true;
        moveToReview(context, visitorCheckIn, isReplace, isPrint);
      }
    });
    String response = "";
    try {
      if (printer != null) {
        RenderRepaintBoundary boundary = repaintBoundary.currentContext.findRenderObject();
        Utilities().printJob(printer, boundary);
        if (!isDoneAnyWay) {
          timerDoneAnyWay?.cancel();
          isDoneAnyWay = true;
          moveToReview(context, visitorCheckIn, isReplace, isPrint);
        }
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      Utilities().printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        isDoneAnyWay = true;
        moveToReview(context, visitorCheckIn, isReplace, isPrint);
      }
    } catch (e) {}
  }

  void takePhotoAgain(BuildContext context) {
    isCountDown = false;
    timerNext?.cancel();
    reloadCamera = !reloadCamera;
    visibleButton = false;
    _isDetecting = false;
    isTakePhoto = false;
    Utilities().moveToWaiting();
    notifyListeners();
    jobDoneCamera(context);
  }

  Future takePhoto(BuildContext context) async {
    if (!isTakePhoto) {
      await convertController;
      timerTakePhoto?.cancel();
      isTakePhoto = true;
      message = "";
      try {
        // Ensure that the camera is initialized.
        var cacheDirectory = await getTemporaryDirectory();
        final path = join(
          // Store the picture in the temp directory.
          // Find the temp directory using the `path_provider` plugin.
          cacheDirectory.path,
          '${DateTime.now()}.png',
        );
        this.path = path;
        await Future.delayed(new Duration(milliseconds: 100));
        await controller.takePicture(path);
      } catch (e) {
        Utilities().printLog(e.toString());
        takePhotoAgain(context);
      }
      visibleButton = true;
      reloadCamera = true;
      isCountDown = true;
      notifyListeners();
    }
  }

  Future<SharedPreferences> getType(BuildContext context, String settingKey) async {
    return memCachePrint.runOnce(() async {
      printer = await Utilities().getPrinter();
      visitorType = await Utilities().getTypeInDb(context, settingKey);
      visitor = arguments["visitor"] as VisitorCheckIn;
      isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
      if (eventDetail?.badgeTemplate != null && eventDetail?.badgeTemplate?.isNotEmpty == true) {
        String badgeBase64 = await createQRImage();
        eventDetail?.badgeTemplate?.replaceAll(Constants.BADGE_QR, badgeBase64);
      }
      return preferences;
    });
  }

  Future<void> moveToReview(BuildContext context, VisitorCheckIn visitor, bool isReplace, bool isPrint) async {
    _dissmissPopupWaiting();
    visibleButton = false;
    this.message = "";
    _isDetecting = false;
    isLoading = false;
//    notifyListeners();
    timerNext?.cancel();
    controller?.dispose();
    var inviteCode = arguments["inviteCode"] as String;
    var isQRScan = arguments["isQRScan"] as bool ?? false;
    var isScanId = arguments["isScanId"] as bool ?? false;
    if (isReplace) {
      locator<NavigationService>()
          .pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name, arguments: {
        'visitor': visitor,
        'isScanId': isScanId,
        'inviteCode': inviteCode,
        'isDelivery': isDelivery,
      });
    } else {
      if (isQRScan) {
        if (isEventMode) {
          assetsAudioPlayer.play();
          locator<SyncService>().syncEventNow(context, eventLog);
          Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LITTLE,
              AppLocalizations.of(context).successTitle, null, () {
            locator<NavigationService>()
                .pushNamedAndRemoveUntil(ScanQRScreen.route_name, WaitingScreen.route_name, arguments: {
              'isRestoreLang': true,
              'isCheckOut' : arguments["isCheckOut"]
            });
          });
        } else {
          locator<NavigationService>()
              .pushNamedAndRemoveUntil(ThankYouScreen.route_name, WaitingScreen.route_name, arguments: {
            'visitor': visitor,
            'isCheckOut' : arguments["isCheckOut"]
          });
        }
      } else {
        locator<NavigationService>()
            .pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name, arguments: {
          'visitor': visitor,
          'inviteCode': inviteCode,
          'isDelivery': isDelivery,
          'isScanId': isScanId,
        }).then((result) {
          isRebuild = !isRebuild;
          isNext = false;
          takePhotoAgain(context);
          notifyListeners();
        });
      }
    }
  }

  void _showPopupWaiting(String message) {
    isProcessing = true;
    messagePopup = message;
    notifyListeners();
  }

  void changeMessagePopup(String message) {
    messagePopup = message;
    notifyListeners();
  }

  void _dissmissPopupWaiting() {
    isProcessing = false;
    notifyListeners();
  }

  @override
  void dispose() {
    assetsAudioPlayer?.dispose();
    visibleButton = false;
    timerNext?.cancel();
    timerTakePhoto?.cancel();
    cancelEvent?.cancel();
    cancelUpload?.cancel();
    timerDoneAnyWay?.cancel();
//    print("stopImageStream dispose...............");
//    controller?.stopImageStream();
    controller?.dispose();
    super.dispose();
  }
}
