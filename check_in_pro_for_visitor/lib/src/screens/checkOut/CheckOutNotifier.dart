import 'dart:async';
import 'dart:convert';

import 'package:app_settings/app_settings.dart';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../model/ValidateEvent.dart';
import '../MainNotifier.dart';
import '../waiting/WaitingScreen.dart';

class CheckOutNotifier extends MainNotifier {
  bool isLoading = false;
  bool isShowLogo = true;
  bool isSyncNow = false;
  String errorText;
  bool isShowQRCode = false;
  CancelableOperation cancelableOperation;
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelEvent;
  CancelableOperation cancelableLogout;
  RoundedLoadingButtonController btnController = new RoundedLoadingButtonController();
  String qrCodeStr = "";
  QRViewController controller;
  bool isScanned = false;
  bool isShowClear = false;
  bool isLoadCamera = false;

  void showClear(bool isShow) {
    isShowClear = isShow;
    notifyListeners();
  }

  Future<void> startStream(BuildContext context) async {
    controller.scannedDataStream.listen((scanData) async {
      if (this.controller != null && !isScanned) {
        this.isScanned = true;
        this.controller.pauseCamera();
        getDataFromQR(scanData.code);
        await Future.delayed(const Duration(milliseconds: 500));
        this.controller.resumeCamera();
      }
    });
  }

  void getDataFromQR(String scanData) {
    try {
      FormatQRCode formatQRCode = FormatQRCode.fromJson(jsonDecode(scanData));
      qrCodeStr = formatQRCode.data;
      notifyListeners();
      btnController.start();
    } catch (e) {
      isLoading = false;
      btnController.stop();
      Utilities().showErrorPopNo(context, appLocalizations.invalidQR, Constants.AUTO_HIDE_LESS, callbackDismiss: () {
        this.isScanned = false;
        this.qrCodeStr = '';
        utilities.moveToWaiting();
      });
    }
  }

  Future searchVisitor(BuildContext context, String phone) async {
    errorText = null;
    isLoading = true;
    notifyListeners();
    if (parent.isConnection) {
//      bool isHaveOff = await searchOffline(context, phone);
//      if (!isHaveOff) {
//        await searchOnline(context, phone);
//      }
      await searchOnline(context, phone);
    } else {
      await searchOffline(context, phone);
    }
  }

  Future validateActionEvent(String inviteCode, String phoneNumber, BuildContext context) async {
    Utilities().cancelWaiting();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var validate = ValidateEvent.fromJson(baseResponse.data);
      if (validate.status == Constants.VALIDATE_IN) {
        isScanned = false;
        btnController.stop();
        errorText = appLocalizations.noPhone;
        isLoading = false;
        notifyListeners();
      } else if (validate.status == Constants.VALIDATE_OUT) {
        var visitorDetail = validate.visitor;
        doNextStep(visitorDetail, null, inviteCode);
      }
    }, (Errors message) async {
      isLoading = false;
      btnController.stop();
      if (message.code != -2) {
        var mess = message.description;
        if (message.description.contains("field_name")) {
          mess = message.description.replaceAll("field_name", appLocalizations.inviteCode);
        }
        Utilities().showErrorPop(context, mess, Constants.AUTO_HIDE_LONG, () {
          this.isScanned = false;
          Utilities().moveToWaiting();
          this.qrCodeStr = '';
        }, callbackDismiss: () {
          this.isScanned = false;
          this.qrCodeStr = '';
        });
      } else {
        this.isScanned = false;
        this.qrCodeStr = '';
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var companyId = userInfor.companyInfo.id ?? 0;
    cancelEvent = await ApiRequest()
        .requestValidateActionEvent(context, companyId, locationId, inviteCode, phoneNumber, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future<bool> searchOffline(BuildContext context, String phone) async {
    var dateCheckOut = DateTime.now().toUtc().millisecondsSinceEpoch;
    var result = await db.visitorLogDAO.checkExistCheckOut(phone, dateCheckOut);
    if (result is VisitorLog) {
      var userInfor = await Utilities().getUserInfor();
      var visitorDetail = await db.visitorCheckInDAO.getByPhoneNumber(phone, userInfor.companyInfo.id);
      if (parent.isOnlineMode) {
        isSyncNow = true;
      }
      doNextStep(visitorDetail, result, null);
      return true;
    } else if (result is String) {
      if (parent.isOnlineMode) {
        return false;
      }
      Errors errors;
      if (result == "GEN_DataNotFound") {
        errors = Errors(0, appLocalizations.noData, DialogType.ERROR);
      } else {
        errors = Errors(0, appLocalizations.noVisitor, DialogType.ERROR);
      }
      isLoading = false;
      noVisitorAlert(errors, context);
      return false;
    }
  }

  Future searchOnline(BuildContext context, String phone) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var visitorDetail = VisitorCheckIn.fromJson(baseResponse.data);
      doNextStep(visitorDetail, null, null);
    }, (Errors message) async {
      isLoading = false;
      if (message.code < 0) {
        if (message.code != -2) {
          var mess = message.description;
          if (message.description.contains("field_name")) {
            mess = message.description.replaceAll("field_name", appLocalizations.inviteCode);
          }
          Utilities().showErrorPop(context, mess, null, () {
            this.isScanned = false;
          });
        } else {
          this.isScanned = false;
        }
      } else {
        noVisitorAlert(message, context);
      }
    });

    cancelableOperation = await ApiRequest().requestSearchVisitorCheckOut(context, phone, null, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future showScanQR(BuildContext context) async {
    bool checkPermission = await Utilities().checkCameraPermission();
    if (!checkPermission) {
      Utilities().showTwoButtonDialog(
          context,
          DialogType.INFO,
          null,
          appLocalizations.noPermissionTitle,
          appLocalizations.noPermissionCamera,
          appLocalizations.btnSkip,
          appLocalizations.btnOpenSetting,
          () async {}, () {
        AppSettings.openAppSettings();
      });
    } else {
      isShowQRCode = !isShowQRCode;
      notifyListeners();
    }
  }

  void doNextStep(VisitorCheckIn visitorDetail, VisitorLog visitorLog, String inviteCode) {
    isLoading = false;
    notifyListeners();
    btnController.success();
    Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () {
      moveToNextPage(visitorDetail, visitorLog, inviteCode);
    });
  }

  void noVisitorAlert(Errors message, BuildContext context) {
    isScanned = false;
    btnController.stop();
    errorText = message.description;
    if (message.description == appLocalizations.noData) {
      errorText = appLocalizations.noPhone;
    }
    isLoading = false;
    notifyListeners();
  }

  void moveToNextPage(VisitorCheckIn visitorId, VisitorLog visitorLog, String inviteCode) {
    parent.updateMode();
    navigationService.pushNamedAndRemoveUntil(FeedBackScreen.route_name, WaitingScreen.route_name, arguments: {
      'visitorCheckIn': visitorId,
      'visitorLog': visitorLog,
      'inviteCode': inviteCode,
      'isSyncNow': isSyncNow,
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    cancelEvent?.cancel();
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    cancelableOperation?.cancel();
    super.dispose();
  }
}
