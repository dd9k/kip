import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlowObject.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/EventDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/ListCheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/ValidateEvent.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/ConnectionStatusSingleton.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../MainNotifier.dart';
import 'dart:ui' as ui;

class ScanQRNotifier extends MainNotifier {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey repaintBoundary = new GlobalKey();
  bool isShowPrinter = false;
  int turnCamera = 0;
  QRViewController controller;
  bool isScanned = false;
  bool isLoading = false;
  bool isShowClear = false;
  bool isShowLogo = true;
  bool isCapture = false;
  bool isPrint = false;
  bool isCheckOut = false;
  bool isBuilding = false;
  VisitorCheckIn visitorDetail;
  var isEventMode = false;
  String qrCodeStr = "";
  var eventId;
  var eventTicketId;
  bool isLoadCamera = true;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  CancelableOperation cancelEvent;
  CancelableOperation cancelEventTicket;
  CancelableOperation cancelGetFlow;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  var isRestoreLang = false;
  var visitorType = Constants.VT_VISITORS;
  PrinterModel printer;
  bool isDoneAnyWay = false;
  Timer timerDoneAnyWay;
  AsyncMemoizer<bool> memCache = AsyncMemoizer();
  String lastQR = "";
  Timer timerReset;
  final assetsAudioPlayer = AssetsAudioPlayer();
  EventLog eventLog;
  EventDetail eventDetail;
  EventTicket eventTicket = EventTicket.init();
  String langSaved = Constants.EN_CODE;
  bool isEventTicket = false;

  void showClear(bool isShow) {
    isShowClear = isShow;
    notifyListeners();
  }

  Future<void> startStream(BuildContext context) async {
    controller.scannedDataStream.listen((scanData) async {
      if (this.controller != null && !isScanned && scanData.code != lastQR) {
        lastQR = scanData.code;
        resetLastQR();
        this.isScanned = true;
        getDataFromQR(scanData.code);
      }
    });
  }

  void resetLastQR() {
    timerReset?.cancel();
    timerReset = Timer(Constants.TIMER_PREVENT_SCAN, () async {
      lastQR = "";
    });
  }

  void getDataFromQR(String scanData) {
    try {
      FormatQRCode formatQRCode = FormatQRCode.fromJson(jsonDecode(scanData));
      qrCodeStr = formatQRCode.data;
      notifyListeners();
      utilities.tryActionLoadingBtn(btnController, BtnLoadingAction.START);
    } catch (e) {
      isLoading = false;
      utilities.tryActionLoadingBtn(btnController, BtnLoadingAction.STOP);
      Utilities().showErrorPopNo(context, appLocalizations.invalidQR, Constants.AUTO_HIDE_LESS, callbackDismiss: () {
        this.isScanned = false;
        this.qrCodeStr = '';
        utilities.moveToWaiting();
      });
    }
  }

  Future validateInviteOnl(String inviteCode, String phoneNumber, BuildContext context) async {
    Utilities().moveToWaiting();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var validate = ValidateEvent.fromJson(baseResponse.data);
      if (validate.status == Constants.VALIDATE_IN) {
        var visitorCheckIn = validate.visitor;
        isCapture = await Utilities().checkIsCapture(context, visitorCheckIn.visitorType);
        bool isSurvey = await Utilities().isSurveyCustom(context, visitorCheckIn.visitorType);
        bool isCovid = await Utilities().isSurveyCovid(context, visitorCheckIn.visitorType);
        if (isSurvey) {
          moveToNextScreen(context, visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.SURVEY);
        } else if (isCovid) {
          moveToNextScreen(context, visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.COVID);
        } else {
          if (isCapture) {
            moveToNextScreen(context, visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.FACE_CAP);
          } else {
            actionEventModeOnl(inviteCode, phoneNumber, context);
          }
        }
      } else if (validate.status == Constants.VALIDATE_OUT) {
        moveToNextScreen(context, validate.visitor, inviteCode, phoneNumber, HomeNextScreen.FEED_BACK);
      }
    }, (Errors message) async {
      isLoading = false;
      btnController.stop();
      if (message.code != -2) {
        var content;
        if (message.description == appLocalizations.errorInviteCode) {
          if (isEventMode && this.eventId != null) {
            if (inviteCode != null) {
              content = appLocalizations
                  .errorEventCode
                  .replaceAll("field_name", appLocalizations.inviteCode);
            } else {
              content = appLocalizations
                  .errorEventCode
                  .replaceAll("field_name", appLocalizations.phoneNumber);
            }
            Utilities().showTwoButtonDialog(
                context,
                DialogType.INFO,
                null,
                appLocalizations.titleNotification,
                content,
                appLocalizations.translate(AppString.BUTTON_CLOSE),
                appLocalizations.btnContinue, () async {
              this.isScanned = false;
              Utilities().moveToWaiting();
              this.qrCodeStr = '';
            }, () {
              this.isScanned = false;
              this.qrCodeStr = '';
              moveToNextScreen(
                  context, VisitorCheckIn.initPhone(phoneNumber), inviteCode, phoneNumber, HomeNextScreen.CHECK_IN);
            });
          } else {
            if (inviteCode != null) {
              content = appLocalizations
                  .errorInviteCode
                  .replaceAll("field_name", appLocalizations.inviteCode);
            } else {
              content = appLocalizations
                  .errorInviteCode
                  .replaceAll("field_name", appLocalizations.phoneNumber);
            }
            Utilities().showErrorPop(context, content, Constants.AUTO_HIDE_LONG, () {
              this.isScanned = false;
              Utilities().moveToWaiting();
              this.qrCodeStr = '';
            }, callbackDismiss: () {
              this.isScanned = false;
              this.qrCodeStr = '';
            });
          }
        } else {
          content = message.description;
          Utilities().showErrorPop(context, content, Constants.AUTO_HIDE_LONG, () {
            this.isScanned = false;
            Utilities().moveToWaiting();
            this.qrCodeStr = '';
          }, callbackDismiss: () {
            this.isScanned = false;
            this.qrCodeStr = '';
          });
        }
      } else {
        this.isScanned = false;
        this.qrCodeStr = '';
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var companyId = userInfor.companyInfo.id ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest()
        .requestValidateActionEvent(context, companyId, locationId, inviteCode, phoneNumber, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  void validate(String inviteCode, String phoneNumber, BuildContext context) {
      if (isEventMode) {
        if (!isEventTicket) {
          validateEventOff(inviteCode, phoneNumber, context);
        } else {
          checkInEventTicket(inviteCode, context);
        }
      } else {
        validateInviteOnl(inviteCode, phoneNumber, context);
      }
  }

  Future validateEventOff(String inviteCode, String phoneNumber, BuildContext context) async {
    if (utilities.checkExpiredEvent(isEventMode, eventDetail)) {
      utilities.actionAfterExpired(context, () => navigationService.navigateTo(WaitingScreen.route_name, 3));
    } else {
      Utilities().moveToWaiting();
      eventLog = await this.db.eventLogDAO.validate(inviteCode, phoneNumber);
      VisitorCheckIn visitorCheckIn = VisitorCheckIn.copyWithEventLog(eventLog);
      if (eventLog.status == Constants.VALIDATE_IN) {
        if (!isCheckOut) {
          await actionIn(visitorCheckIn, context, inviteCode, phoneNumber);
        } else {
          validateEventOnl(inviteCode, phoneNumber, context, false);
        }
      } else if (eventLog.status == Constants.VALIDATE_OUT) {
        if (isCheckOut) {
          validateEventOnl(inviteCode, phoneNumber, context, false);
        } else {
          actionOut(context, visitorCheckIn, inviteCode, phoneNumber);
        }
      } else if (eventLog.status == Constants.VALIDATE_WRONG) {
        validateEventOnl(inviteCode, phoneNumber, context, true);
      } else if (eventLog.status == Constants.VALIDATE_ALREADY) {
        btnController.stop();
        showPopError(context, appLocalizations.alreadyCheckout);
      }
    }
  }

  void showPopError(BuildContext context, String message) {
    Utilities().showErrorPop(context, message, Constants.AUTO_HIDE_LONG, () {
      this.isScanned = false;
      Utilities().moveToWaiting();
      this.qrCodeStr = '';
    }, callbackDismiss: () {
      this.isScanned = false;
      this.qrCodeStr = '';
    });
  }

  Future validateEventOnl(String inviteCode, String phoneNumber, BuildContext context, bool isWrong) async {
    Utilities().moveToWaiting();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var eventLogNew = EventLog.fromJson(baseResponse.data);
      if (isWrong) {
        await db.eventLogDAO.insertNew(eventLogNew);
        validateEventOff(inviteCode, phoneNumber, context);
      } else {
        if (eventLogNew.signIn == null && isCheckOut) {
          btnController.stop();
          showPopError(context, appLocalizations.noVisitor);
        } else {
          eventLog.signIn = eventLogNew.signIn;
          eventLog.signOut = eventLogNew.signOut;
          eventLog.faceCaptureFile = eventLogNew.faceCaptureFile;
          db.eventLogDAO.updateRow(eventLog);
          VisitorCheckIn visitorCheckIn = VisitorCheckIn.copyWithEventLog(eventLog);
          if (eventLogNew.signIn == null) {
            await actionIn(visitorCheckIn, context, inviteCode, phoneNumber);
          } else if (eventLogNew.signOut == null) {
            actionOut(context, visitorCheckIn, inviteCode, phoneNumber);
          } else {
            btnController.stop();
            showPopError(context, appLocalizations.alreadyCheckout);
          }
        }
      }
    }, (Errors message) async {
      if (message.code == -2) {
        showPopError(context, appLocalizations.translate(AppString.NO_INTERNET));
      } else {
        isLoading = false;
        btnController.stop();
        actionWrong(inviteCode, context, phoneNumber);
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var companyId = userInfor.companyInfo.id ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest()
        .requestValidateOff(context, companyId, locationId, inviteCode, phoneNumber, eventId, callBack);
    await cancelEvent.valueOrCancellation();
  }

  void actionWrong(String inviteCode, BuildContext context, String phoneNumber) {
    var content;
    if (isEventMode && this.eventId != null && !isCheckOut) {
      if (inviteCode != null) {
        content = appLocalizations.errorEventCode.replaceAll("field_name", appLocalizations.inviteCode);
      } else {
        content = appLocalizations.errorEventCode.replaceAll("field_name", appLocalizations.phoneNumber);
      }
      Utilities().showTwoButtonDialog(context, DialogType.INFO, null, appLocalizations.titleNotification, content,
          appLocalizations.translate(AppString.BUTTON_CLOSE), appLocalizations.btnContinue, () async {
        this.isScanned = false;
        Utilities().moveToWaiting();
        this.qrCodeStr = '';
      }, () {
        this.isScanned = false;
        this.qrCodeStr = '';
        moveToNextScreen(
            context, VisitorCheckIn.initPhone(phoneNumber), inviteCode, phoneNumber, HomeNextScreen.CHECK_IN);
      });
    } else {
      if (inviteCode != null) {
        content = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.inviteCode);
      } else {
        content = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.phoneNumber);
      }
      Utilities().showErrorPop(context, content, Constants.AUTO_HIDE_LONG, () {
        this.isScanned = false;
        Utilities().moveToWaiting();
        this.qrCodeStr = '';
      }, callbackDismiss: () {
        this.isScanned = false;
        this.qrCodeStr = '';
      });
    }
  }

  void actionOut(BuildContext context, VisitorCheckIn visitorCheckIn, String inviteCode, String phoneNumber) {
    if (!isEventMode || isEventMode && isCheckOut) {
      moveToNextScreen(context, visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.FEED_BACK);
    } else {
      btnController.stop();
      this.isScanned = false;
      this.qrCodeStr = '';
      notifyListeners();
      utilities.showToast(appLocalizations.alreadyCheckin);
    }
  }

  Future actionIn(VisitorCheckIn visitorCheckIn, BuildContext context, String inviteCode, String phoneNumber) async {
    if (!isEventMode || isEventMode && !isCheckOut) {
      isCapture = await Utilities().checkIsCapture(context, visitorCheckIn.visitorType);
      if (isCapture) {
        moveToNextScreen(context, visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.FACE_CAP);
      } else {
        actionEventModeOff(visitorCheckIn, inviteCode, context);
      }
    } else {
      //          utilities.showToast(appLocalizations.alreadyCheckin);
    }
  }

  Future<void> reloadCamera() async {
    qrKey = GlobalKey(debugLabel: 'QR');
    isLoadCamera = false;
    notifyListeners();
    await Future.delayed(Duration(milliseconds: 200));
    isLoadCamera = true;
    notifyListeners();
  }

  Future actionEventModeOnl(String inviteCode, String phoneNumber, BuildContext context) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      await actionDoneIn(context, VisitorCheckIn.fromJson(baseResponse.data), inviteCode);
    }, (Errors message) async {
      isLoading = false;
      btnController.stop();
      var contentError = message.description;
      if (message.description.contains("field_name")) {
        contentError = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.inviteCode);
      }
      if (message.code != -2) {
        Utilities().showErrorPop(context, contentError, Constants.AUTO_HIDE_LONG, () {
          this.isScanned = false;
          this.qrCodeStr = '';
        }, callbackDismiss: () {
          this.isScanned = false;
          Utilities().moveToWaiting();
          this.qrCodeStr = '';
        });
      } else {
        this.isScanned = false;
        this.qrCodeStr = '';
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest()
        .requestActionEvent(context, locationId, inviteCode, phoneNumber, null, null, eventId, null, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future actionEventModeOff(VisitorCheckIn visitorCheckIn, String inviteCode, BuildContext context) async {
    eventLog.signIn = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    var userInfor = await Utilities().getUserInfor();
    eventLog?.signInBy = userInfor?.deviceInfo?.id ?? 0;
    this.db.eventLogDAO.updateRow(eventLog);
    await actionDoneIn(context, visitorCheckIn, inviteCode);
  }

  Future actionDoneIn(BuildContext context, VisitorCheckIn visitorCheckIn, String inviteCode) async {
    visitorDetail = visitorCheckIn;
    var isPrint = await Utilities().checkIsPrint(context, visitorDetail?.visitorType);
    if (isPrint) {
      //        isShowPrinter = true;
      //        notifyListeners();
      if (eventDetail?.badgeTemplate != null && eventDetail?.badgeTemplate?.isNotEmpty == true) {
        String badgeBase64 = await createQRImage();
        eventDetail?.badgeTemplate?.replaceAll(Constants.BADGE_QR, badgeBase64);
      }
      visitorType = await Utilities().getTypeInDb(context, visitorDetail.visitorType);
      notifyListeners();
      await Future.delayed(new Duration(milliseconds: 500));
      printTemplate(context, visitorDetail, isPrint, inviteCode);
    } else {
      isDoneAnyWay = true;
      doNextFlow(context, visitorDetail, inviteCode);
    }
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
    if (visitorDetail.inviteCode != null) {
      formatQRCode = FormatQRCode(FormatQRCode.EVENT, visitorDetail.inviteCode);
    } else if (visitorDetail.phoneNumber != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_PHONE, visitorDetail.phoneNumber);
    } else if (visitorDetail.idCard != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_ID, visitorDetail.idCard);
    }
    return jsonEncode(formatQRCode);
  }

  Future<void> printTemplate(
      BuildContext context, VisitorCheckIn visitorCheckIn, bool isPrint, String inviteCode) async {
    timerDoneAnyWay = Timer(Duration(seconds: Constants.TIMEOUT_PRINTER), () {
      if (!isDoneAnyWay) {
        isDoneAnyWay = true;
        doNextFlow(context, visitorCheckIn, inviteCode);
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
          doNextFlow(context, visitorCheckIn, inviteCode);
        }
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      Utilities().printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        isDoneAnyWay = true;
        doNextFlow(context, visitorCheckIn, inviteCode);
      }
    } catch (e) {}
  }

  getDataOnline(VisitorCheckIn visitorCheckIn, BuildContext context, String inviteCode) async {
    var result = new Completer<List<CheckInFlow>>();
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      //Callback SUCCESS
      var _resp = ListCheckInFlow.fromJson(baseResponse.data);
      List<CheckInFlowObject> flows = _resp.flows;
      var badgeTemplate = _resp.badgeTemplateCode;
      preferences.setString(Constants.KEY_BADGE_PRINTER, badgeTemplate);
      await db.checkInFlowDAO.deleteAlls();
      await Future.forEach(flows, (element) async {
        await db.checkInFlowDAO.insert(element);
      });
    }, (Errors message) {
      //Callback ERROR
      btnController.stop();
      if (message.code != -2) {
        Utilities().showErrorPop(context, message.description, null, () {
          this.isScanned = false;
          this.qrCodeStr = '';
        }, callbackDismiss: () {
          this.isScanned = false;
          this.qrCodeStr = '';
        });
      } else {
        this.isScanned = false;
        this.qrCodeStr = '';
      }
      isLoading = false;
      notifyListeners();
    });
    var currentInfor = await Utilities().getUserInfor();
    var branchId = currentInfor?.deviceInfo?.branchId ?? 0;
    cancelGetFlow = await ApiRequest().requestGetFlow(context, branchId, listCallBack);
    await cancelGetFlow.valueOrCancellation();
    return result.future;
  }

  Future<void> doNextFlow(BuildContext context, VisitorCheckIn visitorCheckIn, String inviteCode) async {
    isShowPrinter = false;
    isLoading = false;
    notifyListeners();
    btnController.success();
    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () {
      moveToNextScreen(context, visitorCheckIn, inviteCode, null, HomeNextScreen.THANK_YOU);
    });
  }

  void moveToNextScreen(
      BuildContext context, VisitorCheckIn visitorCheckIn, String inviteCode, String phoneNumber, HomeNextScreen type) {
    switch (type) {
      case HomeNextScreen.SURVEY:
        {
          navigationService.navigateTo(SurveyScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isShowBack': true,
            'isQRScan': true,
            'inviteCode': inviteCode,
            'phoneNumber': phoneNumber,
            'isCheckOut': isCheckOut,
            'eventLog': eventLog,
            'isCapture' : isCapture
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.COVID:
        {
          navigationService.navigateTo(CovidScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isShowBack': true,
            'isQRScan': true,
            'inviteCode': inviteCode,
            'phoneNumber': phoneNumber,
            'isCheckOut': isCheckOut,
            'eventLog': eventLog,
            'isCapture' : isCapture
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.FACE_CAP:
        {
          navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isShowBack': false,
            'isQRScan': true,
            'inviteCode': inviteCode,
            'phoneNumber': phoneNumber,
            'isCheckOut': isCheckOut,
            'eventLog': eventLog
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.THANK_YOU:
        {
          assetsAudioPlayer.play();
          locator<SyncService>().syncEventNow(context, eventLog);
          Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LESS,
              appLocalizations.hi, visitorCheckIn.fullName, null);
          btnController.stop();
          this.isScanned = false;
          this.qrCodeStr = '';
          notifyListeners();
//          navigationService.pushNamedAndRemoveUntil(
//              ThankYouScreen.route_name, WaitingScreen.route_name, false,
//              arguments: {
//                'visitor': visitorCheckIn,
//              });
          break;
        }
      case HomeNextScreen.CHECK_IN:
        {
          navigationService.navigateTo(InputPhoneScreen.route_name, 1, arguments: {
            'visitor': VisitorCheckIn.inital(),
            'phoneNumber': phoneNumber,
            'isDelivery': false,
            'isQRScan': true,
          }).then((_) {
            handlerBack();
          });
          break;
        }
      case HomeNextScreen.FEED_BACK:
        {
          navigationService.pushNamedAndRemoveUntil(FeedBackScreen.route_name, WaitingScreen.route_name, arguments: {
            'visitorCheckIn': visitorCheckIn,
            'visitorLog': null,
            'inviteCode': inviteCode,
            'phoneNumber': phoneNumber,
            'isSyncNow': false,
            'isEvent': true,
            'isCheckOut': isCheckOut,
            'eventLog': eventLog
          });
          break;
        }
      default:
        {
          break;
        }
    }
    isDoneAnyWay = false;
  }

  Future<void> handlerBack() async {
    btnController.stop();
    reloadCamera();
  }

  Future<bool> getDefaultLang(BuildContext context) async {
    return memCache.runOnce(() async {
      isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
      eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
      eventTicketId = preferences.getDouble(Constants.KEY_EVENT_TICKET_ID);
      isEventTicket = utilities.getUserInforNew(preferences).isEventTicket;
      if (isEventMode) {
        if (isEventTicket) {
          eventTicket = await db.eventTicketDAO.getEventTicketById(eventTicketId);
        } else {
          eventDetail = await this.db.eventDetailDAO.getEventDetail();
        }
      }
      printer = await Utilities().getPrinter();
      isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
      if (visitorDetail != null) {
        visitorType = await Utilities().getTypeInDb(context, visitorDetail.visitorType);
      }
      if (arguments != null) {
        isRestoreLang = arguments["isRestoreLang"] as bool ?? false;
        isCheckOut = arguments["isCheckOut"] as bool ?? false;
        if (isRestoreLang) {
          await Utilities().getDefaultLang(context);
        }
      }
      langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      assetsAudioPlayer.open(Audio("assets/audios/ding.mp3"), showNotification: false, autoStart: false);
      assetsAudioPlayer.setVolume(1.0);
      ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) {
        if (result) {
          locator<SyncService>().syncEventFail(context);
        }
      });
      return true;
    });
  }


  Future checkInEventTicket(String inviteCode, BuildContext context) async {
    if (utilities.checkExpiredEventTicket(isEventMode, eventTicket)) {
      utilities.actionAfterExpired(context, () => navigationService.navigateTo(WaitingScreen.route_name, 3));
    } else {
      Utilities().moveToWaiting();
      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
        assetsAudioPlayer.play();
//        locator<SyncService>().syncEventNow(context, eventLog);
        Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LESS,
            appLocalizations.hi, baseResponse.data["fullName"], null);
        btnController.stop();
        this.isScanned = false;
        this.qrCodeStr = '';
        notifyListeners();
      }, (Errors message) async {
        isLoading = false;
        btnController.stop();
        if (message.code != -2) {
          if (message.description == appLocalizations.translate(AppString.MESSAGE_COMMON_ERROR)) {
            message.description = appLocalizations.inviteCodeError;
          }
          Utilities().showErrorPop(context, message.description, Constants.AUTO_HIDE_LONG, () {
            this.isScanned = false;
            Utilities().moveToWaiting();
            this.qrCodeStr = '';
          }, callbackDismiss: () {
            this.isScanned = false;
            this.qrCodeStr = '';
          });
        }
      });
      cancelEventTicket = await ApiRequest()
          .requestCheckInEventTicket(context, inviteCode, eventTicketId, callBack);
      await cancelEventTicket.valueOrCancellation();
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer?.dispose();
    timerReset?.cancel();
    super.dispose();
  }
}
