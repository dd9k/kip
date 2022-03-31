import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/Authenticate.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseListResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiServiceNoBase.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiService.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show MultipartFile;
import 'package:shared_preferences/shared_preferences.dart';

import 'MobileDataInterceptor.dart';

enum ApiServiceType {
  POST_API,
  POST_API_UPLOAD,
  POST_API_OCR,
  POST_API_SYNC,
  POST_API_NO_AUTHENTICATE,
  GET_API_NO_AUTHENTICATE,
  GET_API,
  GET_API_WITH_PATH,
  PUT_API,
  GET_IMAGE,
  TEMP_OCR
}

enum ResponseType {
  OBJECT,
  LIST,
  FILE,
}

class ApiRequest {
  static final ApiRequest _singleton = ApiRequest._internal();
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;

  factory ApiRequest() {
    return _singleton;
  }

  static const listNoneInternet = [
    Constants.PATH_REFRESH_TOKEN,
    Constants.PATH_LOGOUT,
    Constants.PATH_SYNC,
    Constants.PATH_CONFIGURATION,
    Constants.PATH_CHECK_IN_FLOW,
    Constants.PATH_VISITOR_TYPE,
    Constants.PATH_EVENT_VALIDATE_OFF,
    Constants.PATH_SYNC_EVENT,
    Constants.PATH_QR_CREATE,
    Constants.PATH_UPDATE_STATUS
  ];
  static const listNoneToken = [
    ApiServiceType.POST_API_NO_AUTHENTICATE,
    ApiServiceType.GET_IMAGE,
    ApiServiceType.GET_API_NO_AUTHENTICATE
  ];

  ApiRequest._internal();

  Future<CancelableOperation<dynamic>> createAPIService(
      BuildContext context,
      ApiServiceType apiServiceType,
      ResponseType responseType,
      String path,
      Map<String, dynamic> body,
      double visitorLogId,
      String jsonString,
      MultipartFile file,
      MultipartFile fileId,
      ApiCallBack apiCallBack,
      Function doAgain) async {
    var token = "";
    if (!listNoneToken.contains(apiServiceType)) {
      token = await Utilities().getToken();
    }
    Future<dynamic> apiService;
    switch (apiServiceType) {
      case ApiServiceType.POST_API:
        {
          apiService = ApiService.create().postApi(path, token, body);
          break;
        }
      case ApiServiceType.POST_API_UPLOAD:
        {
          apiService = ApiService.create().postApiUpload(path, token, file);
          break;
        }
      case ApiServiceType.POST_API_OCR:
        {
          apiService = ApiService.createOCR().postApiUpload(path, token, file);
          break;
        }
      case ApiServiceType.POST_API_SYNC:
        {
          apiService = ApiService.create().postApiSync(path, token, jsonString, file, fileId);
          break;
        }
      case ApiServiceType.POST_API_NO_AUTHENTICATE:
        {
          apiService = ApiService.create().postApiNoAuthenticate(path, body);
          break;
        }
      case ApiServiceType.GET_API_NO_AUTHENTICATE:
        {
          apiService = ApiService.create().getAPINoAuthenticate(path);
          break;
        }
      case ApiServiceType.GET_API:
        {
          apiService = ApiService.create().getAPI();
          break;
        }
      case ApiServiceType.GET_API_WITH_PATH:
        {
          apiService = ApiService.create().getAPIWithPath(path, token);
          break;
        }
      case ApiServiceType.PUT_API:
        {
          apiService = ApiService.create().putAPI(path, token, body);
          break;
        }
      case ApiServiceType.GET_IMAGE:
        {
          apiService = ApiServiceNoBase.create().getImage(path);
          break;
        }
      case ApiServiceType.TEMP_OCR:
        {
          apiService = ApiServiceNoBase.create().postApiTempOCR(path, token, file);
          break;
        }
    }

    var cancelable = CancelableOperation.fromFuture(
      apiService,
      onCancel: () => {},
    );
    return cancelable
      ..value.then((dynamic response) async {
        await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
      }, onError: (response) async {
        if (response is MobileException) {
          Utilities().writeLog("ko có internettttttttttttttt");
          var isContain = false;
          for (var pathNone in listNoneInternet) {
            if (path.contains(pathNone)) {
              isContain = true;
            }
          }
          if (!isContain) {
            showNoInternet(context, apiCallBack, doAgain);
          } else {
            var errors =
                Errors(-2, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
          }
        } else {
          Utilities().writeLog("lỗi gì đó nhaaaaaaaa");
          await handlerDoneApi(response, context, apiCallBack, responseType, doAgain, path);
        }
      }).catchError((error, stackTrace) {
        try {
          var message = error.toString();
          Utilities().writeLog(message);
          if (message.contains("MobileException")) {
            if (!listNoneInternet.contains(path)) {
              showNoInternet(context, apiCallBack, doAgain);
            } else {
              var errors =
              Errors(-2, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
              apiCallBack.onError(errors);
            }
          } else {
            handlerError(context, apiCallBack, message);
          }
        } catch (e) {
          Utilities().writeLog(e.toString());
          Utilities().printLog(e.toString());
          var errors =
              Errors(-1001, "Something when wrong! Please restart app or contact administrator", DialogType.ERROR);
          apiCallBack.onError(errors);
        }
      });
  }

  void showNoInternet(BuildContext context, ApiCallBack apiCallBack, Function doAgain) {
    Utilities().showTwoButtonDialog(
        context,
        DialogType.ERROR,
        null,
        AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
        AppLocalizations.of(context).translate(AppString.NO_INTERNET),
        AppLocalizations.of(context).translate(AppString.BUTTON_CLOSE),
        AppLocalizations.of(context).translate(AppString.BUTTON_TRY_AGAIN), () {
      if (apiCallBack != null) {
        var errors =
            Errors(-2, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
        apiCallBack?.onError(errors);
      }
    }, () {
      doAgain();
    });
  }

  Future handlerDoneApi(
      response, BuildContext context, ApiCallBack apiCallBack, ResponseType responseType, Function doAgain, String path) async {
    catchSocketException(response);
    if (response is SocketException) {
      if (!listNoneInternet.contains(path)) {
        showNoInternet(context, apiCallBack, doAgain);
      } else {
        var errors =
        Errors(-2, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
        apiCallBack.onError(errors);
      }
    } else if (response is Response) {
      if (!handlerCompleteFuture(context, apiCallBack, response, responseType)) {
        await refreshToken(context, doAgain);
      }
    } else {
      handlerError(context, apiCallBack, response.toString());
    }
  }

  Future<CancelableOperation<dynamic>> refreshToken(BuildContext context, Function callback) async {
    var preferences = await SharedPreferences.getInstance();
    var lastRefresh = preferences.getInt(Constants.KEY_LAST_REFRESH) ?? 0;
    var now = DateTime.now().millisecondsSinceEpoch;

    if (now - lastRefresh > 10000) {
      preferences.setInt(Constants.KEY_LAST_REFRESH, now);
      var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";

      ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
        var authenticationString = JsonEncoder().convert(baseResponse.data);
        preferences.setString(Constants.KEY_AUTHENTICATE, authenticationString);
        callback();
      }, (Errors message) {
        if (message.code != -2 && message.code == -401) {
          Utilities().popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).expiredToken);
        }
      });

      var authorization = await Utilities().getAuthorization();
      var token = (authorization as Authenticate).refreshToken;
      return ApiRequest().requestRefreshTokenApi(context, firebaseId, token, listCallBack);
    }
    return null;
  }

  Future<CancelableOperation<dynamic>> requestRefreshTokenApi(
      BuildContext context, String firebaseId, String refreshToken, ApiCallBack apiCallBack) async {
    var preferences = await SharedPreferences.getInstance();
    var lastRefresh = preferences.getInt(Constants.KEY_LAST_REFRESH) ?? 0;
    var now = DateTime.now().millisecondsSinceEpoch;

    if (now - lastRefresh > 10000) {
      preferences.setInt(Constants.KEY_LAST_REFRESH, now);
      Map<String, dynamic> body = Map<String, dynamic>();
      body[Constants.FIELD_FIREBASE_TOKEN] = firebaseId;
      body[Constants.FIELD_REFRESH_TOKEN] = refreshToken;
      return createAPIService(context, ApiServiceType.POST_API_NO_AUTHENTICATE, ResponseType.OBJECT,
          Constants.PATH_REFRESH_TOKEN, body, null, null, null, null, apiCallBack, null);
    }
    return null;
  }

  Future<CancelableOperation<dynamic>> requestLoginApi(
      BuildContext context,
      String username,
      String password,
      String type,
      String deviceToken,
      String language,
      String os,
      String appVersion,
      String domain,
      ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_USER_NAME] = username.trim();
    body[Constants.FIELD_PASSWORD] = password;
    body[Constants.FIELD_TYPE] = type;
    body[Constants.FIELD_FIREBASE_TOKEN] = deviceToken;
    body[Constants.FIELD_LANGUAGE] = language;
    body[Constants.FIELD_OS] = os;
    body[Constants.FIELD_APP_VERSION] = appVersion;
    body[Constants.FIELD_DOMAIN] = domain;

    var doAgain = () {
      requestLoginApi(context, username, password, type, deviceToken, language, os, appVersion, domain, apiCallBack);
    };
    return createAPIService(context, ApiServiceType.POST_API_NO_AUTHENTICATE, ResponseType.OBJECT,
        Constants.PATH_AUTHENTICATE, body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestUserInfor(
      BuildContext context, String deviceId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_DEVICE_ID] = deviceId;

    var doAgain = () {
      requestUserInfor(context, deviceId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_USER_INFOR, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestLocationInfor(BuildContext context, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestLocationInfor(context, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST, Constants.PATH_LOCATION_INFOR,
        null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestImage(BuildContext context, String path, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestImage(context, path, apiCallBack);
    };

    return createAPIService(
        context, ApiServiceType.GET_IMAGE, ResponseType.FILE, path, null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestLocation(BuildContext context, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestLocation(context, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST, Constants.PATH_LOCATION, null,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestAllCompanyBuilding(BuildContext context, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestAllCompanyBuilding(context, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST,
        Constants.PATH_BUILDING_ALL_COMPANY, null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestFunctionGroup(
      BuildContext context, int accountId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestFunctionGroup(context, accountId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST,
        Constants.PATH_FUNCTION_GROUP + accountId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestQRCreate(BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestQRCreate(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_QR_CREATE + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestValidateDomain(
      BuildContext context, String domain, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestValidateDomain(context, domain, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_NO_AUTHENTICATE, ResponseType.OBJECT,
        Constants.PATH_VALIDATE_DOMAIN + domain, null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestOCR(
      BuildContext context, String idCardFile, ApiCallBack apiCallBack) async {
    List<int> imageBytes = await Utilities().rotateAndResize(idCardFile);
    final file = MultipartFile.fromBytes(Constants.FIELD_CARD_FILE, imageBytes,
        filename: "${Constants.FIELD_CARD_FILE}.${Constants.PNG_ETX}");

    var doAgain = () {
      requestOCR(context, idCardFile, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API_OCR, ResponseType.OBJECT, Constants.PATH_OCR, null, null,
        null, file, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestOCRTemp(
      BuildContext context, String idCardFile, ApiCallBack apiCallBack) async {
    List<int> imageBytes = await Utilities().rotateAndResize(idCardFile);
    final file =
        MultipartFile.fromBytes("file", imageBytes, filename: "${Constants.FIELD_CARD_FILE}.${Constants.PNG_ETX}");

    var doAgain = () {
      requestOCR(context, idCardFile, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.TEMP_OCR, ResponseType.OBJECT, Constants.PATH_OCR_TEMP, null, null,
        null, file, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestContactPerson(
      BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestContactPerson(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST,
        Constants.PATH_CONTACT_PERSON + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSearchContact(
      BuildContext context, String keyword, int pageIndex, double branchId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_PAGE_SIZE] = 12;
    body[Constants.FIELD_PAGE_INDEX] = pageIndex;
    body[Constants.FIELD_KEYWORD] = keyword;
    var doAgain = () {
      requestSearchContact(context, keyword, pageIndex, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT,
        Constants.PATH_SEARCH_CONTACT + branchId.toString(), body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestAllEvent(BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestAllEvent(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST,
        Constants.PATH_ALL_EVENT + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestEventDetails(BuildContext context, double eventId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestEventDetails(context, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_EVENT_DETAILS + eventId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestEventTicketDetails(BuildContext context, double eventId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestEventTicketDetails(context, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_ALL_EVENT_TICKET_DETAIL + eventId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestGetFlow(BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestGetFlow(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_CHECK_IN_FLOW + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSetupDevice(
      BuildContext context,
      String name,
      String type,
      String deviceId,
      String osVersion,
      String appVersion,
      String ipAddress,
      String printIpAddress,
      double locationId,
      int timeout,
      String firebaseId,
      ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_NAME] = name;
    body[Constants.FIELD_TYPE] = type;
    body[Constants.FIELD_DEVICE_ID] = deviceId;
    body[Constants.FIELD_OS_VERSION] = osVersion;
    body[Constants.FIELD_APP_VERSION] = appVersion;
    body[Constants.FIELD_IP_ADDRESS] = ipAddress;
    body[Constants.FIELD_PRINT_IP_ADDRESS] = printIpAddress;
    body[Constants.FIELD_LOCATION_ID] = locationId;
    body[Constants.FIELD_TIMEOUT] = timeout;
    body[Constants.FIELD_FIREBASE_TOKEN] = firebaseId;

    var doAgain = () {
      requestSetupDevice(context, name, type, deviceId, osVersion, appVersion, ipAddress, printIpAddress, locationId,
          timeout, firebaseId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_SETUP_DEVICE, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestUpdateDevice(
      BuildContext context, DeviceInfor deviceInfor, String firebaseId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = deviceInfor.toJson();
    body[Constants.FIELD_FIREBASE_TOKEN] = firebaseId;
    body.removeWhere((key, value) => value == null);

    var doAgain = () {
      requestUpdateDevice(context, deviceInfor, firebaseId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_UPDATE_DEVICE, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestVisitorCheckIn(
      BuildContext context, Map<String, dynamic> body, ApiCallBack apiCallBack) async {
    var userInfor = await Utilities().getUserInfor();
    body[Constants.FIELD_LOCATION_ID] = userInfor?.deviceInfo?.branchId ?? 0;

    var doAgain = () {
      requestVisitorCheckIn(context, body, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_VISITOR_CHECK_IN,
        body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestInviteEvent(
      BuildContext context, Map<String, dynamic> body, double eventId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestInviteEvent(context, body, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT,
        Constants.PATH_INVITE_EVENT + eventId.toString(), body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestEventCheckIn(
      BuildContext context, double locationId, String inviteCode, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_LOCATION_ID] = locationId;
    body[Constants.FIELD_CHK_DATA] = inviteCode?.toUpperCase();

    var doAgain = () {
      requestEventCheckIn(context, locationId, inviteCode, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_CHECK_IN, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestActionEvent(BuildContext context, double locationId, String inviteCode,
      String phoneNumber, String faceCaptureFile, double faceCaptureRepoId, double eventId,
      double surveyId, String surveyAnswer, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_BRANCH_ID] = locationId;
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_VISITOR_PHONE] = phoneNumber;
    body[Constants.FIELD_FACE_REPO_FILE] = faceCaptureFile;
    body[Constants.FIELD_FACE_REPO_ID] = faceCaptureRepoId;
    body[Constants.FIELD_EVENT_ID] = eventId;
    body[Constants.FIELD_SURVEY_ID] = surveyId;
    body[Constants.FIELD_SURVEY_ANSWER] = surveyAnswer;

    var doAgain = () {
      requestActionEvent(
          context, locationId, inviteCode, phoneNumber, faceCaptureFile, faceCaptureRepoId, eventId, surveyId, surveyAnswer, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_ACTION, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestValidateActionEvent(BuildContext context, double companyId,
      double locationId, String inviteCode, String phoneNumber, double eventId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_BRANCH_ID] = locationId;
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_VISITOR_PHONE] = phoneNumber;
    body[Constants.FIELD_COMPANY_ID] = companyId;
    body[Constants.FIELD_EVENT_ID] = eventId;

    var doAgain = () {
      requestValidateActionEvent(context, companyId, locationId, inviteCode, phoneNumber, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_VALIDATE, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestCheckInEventTicket(
      BuildContext context, String inviteCode, double eventId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_QR_CODE] = inviteCode ?? "";
    body[Constants.FIELD_EVENT_ID] = eventId;

    var doAgain = () {
      requestCheckInEventTicket(context, inviteCode, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_TICKET_CHECK_IN, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestValidateOff(BuildContext context, double companyId,
      double locationId, String inviteCode, String phoneNumber, double eventId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_BRANCH_ID] = locationId;
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_VISITOR_PHONE] = phoneNumber;
    body[Constants.FIELD_COMPANY_ID] = companyId;
    body[Constants.FIELD_EVENT_ID] = eventId;

    var doAgain = () {
      requestValidateOff(context, companyId, locationId, inviteCode, phoneNumber, eventId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_VALIDATE_OFF, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSearchVisitor(
      BuildContext context, String visitorPhone, String visitorIdCard, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_VISITOR_PHONE] = visitorPhone;
    body[Constants.FIELD_ID_CARD] = visitorIdCard;

    var doAgain = () {
      requestSearchVisitor(context, visitorPhone, visitorIdCard, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_SEARCH_VISITOR, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSearchVisitorCheckOut(
      BuildContext context, String visitorPhone, String visitorIdCard, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_VISITOR_PHONE] = visitorPhone;
    body[Constants.FIELD_ID_CARD] = visitorIdCard;

    var doAgain = () {
      requestSearchVisitorCheckOut(context, visitorPhone, visitorIdCard, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT,
        Constants.PATH_SEARCH_VISITOR_CHECKOUT, body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestValidateCode(
      BuildContext context, String inviteCode, double branchId, double companyId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_BRANCH_ID] = branchId;
    body[Constants.FIELD_COMPANY_ID] = companyId;

    var doAgain = () {
      requestValidateCode(context, inviteCode, branchId, companyId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_VALIDATE_CODE,
        body, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestCheckOut(BuildContext context, double visitorLogId, String feedBack,
      double rating, int signOutBy, double branchId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_FEEDBACK] = feedBack;
    body[Constants.FIELD_RATING] = rating;
    body[Constants.FIELD_VISITOR_LOG_ID] = visitorLogId;
    body[Constants.FIELD_SIGN_OUT_BY] = signOutBy;
    body[Constants.FIELD_SIGN_OUT_TYPE] = Constants.TYPE_CHECK;
    body[Constants.FIELD_LOCATION_ID] = branchId;

    var doAgain = () {
      requestCheckOut(context, visitorLogId, feedBack, rating, signOutBy, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_CHECKOUT, body, null,
        null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestCheckOutEvent(BuildContext context, String inviteCode, String phoneNumber,
      String feedBack, double rating, int signOutBy, double branchId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_FEEDBACK] = feedBack;
    body[Constants.FIELD_RATING] = rating.toInt();
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_SIGN_OUT_BY] = signOutBy;
    body[Constants.FIELD_SIGN_OUT_TYPE] = Constants.TYPE_CHECK;
    body[Constants.FIELD_BRANCH_ID] = branchId;
    body[Constants.FIELD_VISITOR_PHONE] = phoneNumber;

    var doAgain = () {
      requestCheckOutEvent(context, inviteCode, phoneNumber, feedBack, rating, signOutBy, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_ACTION, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestCheckOutByCode(BuildContext context, String inviteCode, String feedBack,
      double rating, int signOutBy, double branchId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_FEEDBACK] = feedBack;
    body[Constants.FIELD_RATING] = rating.toInt();
    body[Constants.FIELD_INVITE_CODE] = inviteCode?.toUpperCase();
    body[Constants.FIELD_SIGN_OUT_BY] = signOutBy;
    body[Constants.FIELD_SIGN_OUT_TYPE] = Constants.TYPE_CHECK;
    body[Constants.FIELD_LOCATION_ID] = branchId;

    var doAgain = () {
      requestCheckOutByCode(context, inviteCode, feedBack, rating, signOutBy, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_EVENT_CHECK_OUT, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestLogout(
      BuildContext context, String deviceId, String refreshToken, String firebaseToken, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_DEVICE_ID] = deviceId;
    body[Constants.FIELD_REFRESH_TOKEN] = refreshToken;
    body[Constants.FIELD_FIREBASE_TOKEN] = firebaseToken;

    var doAgain = () {
      requestLogout(context, deviceId, refreshToken, firebaseToken, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_LOGOUT, body, null,
        null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestUploadFace(
      BuildContext context, String captureFaceFile, ApiCallBack apiCallBack) async {
    List<int> imageBytes = await Utilities().rotateAndResize(captureFaceFile);
    final file = MultipartFile.fromBytes(Constants.FIELD_FACE_FILE, imageBytes,
        filename: "${Constants.FIELD_FACE_FILE}.${Constants.PNG_ETX}");

    var doAgain = () {
      requestUploadFace(context, captureFaceFile, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API_UPLOAD, ResponseType.OBJECT,
        Constants.PATH_UPLOAD_FACE_CAPTURE, null, null, null, file, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestUploadIDCard(
      BuildContext context, String idCardFile, ApiCallBack apiCallBack) async {
    List<int> imageBytes = await Utilities().rotateAndResize(idCardFile);
    final file = MultipartFile.fromBytes(Constants.FIELD_ID_CARD_FILE, imageBytes,
        filename: "${Constants.FIELD_ID_CARD_FILE}.${Constants.PNG_ETX}");

    var doAgain = () {
      requestUploadIDCard(context, idCardFile, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API_UPLOAD, ResponseType.OBJECT, Constants.PATH_UPLOAD_ID_CARD,
        null, null, null, file, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSync(BuildContext context, VisitorLog visitorLog, List<int> imageBytes,
      List<int> imageIdBytes, ApiCallBack apiCallBack) {
    var jsonString = jsonEncode(visitorLog.toJson());
    MultipartFile file;
    MultipartFile fileId;
    if (imageBytes == null) {
      file = null;
    } else {
      file = MultipartFile.fromBytes(Constants.FIELD_FACE_OFFLINE, imageBytes,
          filename: "${Constants.FIELD_FACE_OFFLINE}.${Constants.PNG_ETX}");
    }

    if (imageIdBytes == null) {
      fileId = null;
    } else {
      fileId = MultipartFile.fromBytes(Constants.FIELD_ID_OFFLINE, imageIdBytes,
          filename: "${Constants.FIELD_ID_OFFLINE}.${Constants.PNG_ETX}");
    }

    var doAgain = () {
      requestSync(context, visitorLog, imageBytes, imageIdBytes, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API_SYNC, ResponseType.OBJECT, Constants.PATH_SYNC, null, null,
        jsonString, file, fileId, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSyncEvent(
      BuildContext context, EventLog eventLog, List<int> imageBytes, ApiCallBack apiCallBack) {
    var jsonString = jsonEncode(eventLog.toJson());
    MultipartFile file;
    if (imageBytes == null) {
      file = null;
    } else {
      file = MultipartFile.fromBytes(Constants.FIELD_FACE_OFFLINE, imageBytes,
          filename: "${Constants.FIELD_FACE_OFFLINE}.${Constants.PNG_ETX}");
    }

    var doAgain = () {
      requestSyncEvent(context, eventLog, imageBytes, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API_SYNC, ResponseType.OBJECT, Constants.PATH_SYNC_EVENT, null, null,
        jsonString, file, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestCheckDevice(
      BuildContext context, String deviceId, ApiCallBack apiCallBack) {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_DEVICE_ID] = deviceId;

    var doAgain = () {
      requestCheckDevice(context, deviceId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.OBJECT, Constants.PATH_CHECK_DEVICE, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestConfiguration(
      BuildContext context, String typeExtension, ApiCallBack apiCallBack) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_TYPE] = typeExtension;
    var userInfor = await Utilities().getUserInfor();
    body[Constants.FIELD_BRANCH_ID] = userInfor?.deviceInfo?.branchId ?? 0;

    var doAgain = () {
      requestConfiguration(context, typeExtension, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.POST_API, ResponseType.LIST, Constants.PATH_CONFIGURATION, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestVisitorType(BuildContext context, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestVisitorType(context, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST, Constants.PATH_VISITOR_TYPE,
        null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestGetAllEventTicket(BuildContext context, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestGetAllEventTicket(context, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.LIST, Constants.PATH_ALL_EVENT_TICKET,
        null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestConfigKios(
      BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestConfigKios(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_CONFIG_KIOS + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestSurvey(BuildContext context, double branchId, ApiCallBack apiCallBack) {
    var doAgain = () {
      requestSurvey(context, branchId, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.GET_API_WITH_PATH, ResponseType.OBJECT,
        Constants.PATH_SURVEY + branchId.toString(), null, null, null, null, null, apiCallBack, doAgain);
  }

  Future<CancelableOperation<dynamic>> requestUpdateStatus(
      BuildContext context, String status, ApiCallBack apiCallBack) async {
    var deviceInfor = await Utilities().getDeviceInfo();

    Map<String, dynamic> body = Map<String, dynamic>();
    body[Constants.FIELD_DEVICE_ID] = deviceInfor.identifier;
    body[Constants.FIELD_STATUS] = status;

    var doAgain = () {
      requestUpdateStatus(context, status, apiCallBack);
    };

    return createAPIService(context, ApiServiceType.PUT_API, ResponseType.OBJECT, Constants.PATH_UPDATE_STATUS, body,
        null, null, null, null, apiCallBack, doAgain);
  }

  bool handlerCompleteFuture(BuildContext context, ApiCallBack apiCallBack, Response response, ResponseType type) {
    String statusCode = getStatusCodeRequestAPI(response, type);
    if (statusCode == Constants.STATUS_SUCCESS) {
      switch (type) {
        case ResponseType.FILE:
          {
            apiCallBack.onSuccessFile(response.bodyBytes, response.headers["content-type"]);
            break;
          }
        case ResponseType.OBJECT:
          {
            var baseResponse = BaseResponse.fromJson(response.body);
            apiCallBack.onSuccess(baseResponse);
            break;
          }
        case ResponseType.LIST:
          {
            var baseListResponse = BaseListResponse.fromJson(response.body);
            apiCallBack.onSuccessList(baseListResponse);
            break;
          }
      }
    } else {
      Utilities().writeLog(statusCode);
      switch (statusCode) {
        case Constants.B500:
          {
            Errors errors =
                Errors(-1, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.B401:
          {
            if (response.base.request.url.path.contains(Constants.PATH_REFRESH_TOKEN)) {
              CancelableOperation cancelableLogout;
              Utilities().popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).expiredToken);
              break;
            } else if (response.base.request.url.path.contains(Constants.PATH_CONFIGURATION) || response.base.request.url.host.contains("hcm01.vstorage.vngcloud.vn")) {
              Errors errors =
                  Errors(-401, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
              apiCallBack.onError(errors);
              return true;
            }
            return false;
          }
        case Constants.B400:
          {
            Errors errors =
                Errors(-1, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.B403:
          {
            CancelableOperation cancelableLogout;
            Utilities().popupAndSignOut(context, cancelableLogout, AppLocalizations.of(context).noPermission);
            break;
          }
        //general
        case "GEN_DataNotFound":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).noData, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "VIS_NoVisitorInformation":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).noVisitor, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "GEN_InvalidParam":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "EVENT_InviteCodeNotFound":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).errorInviteCode, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "EVENT_AlreadyCheckout":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).alreadyCheckout, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "EVENT_NotYetCheckin":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).noVisitor, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "EVENT_EventExpired":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).eventExpired, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_CantFindOrderDetail":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).inviteCodeError, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_OrderNotPaid":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).orderNotPaid, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_OrderDetailUsed":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).inviteCodeUsed, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_CantFindEventInfo":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).inviteCodeError, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_EventExpired":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).eventExpired, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_EventInvalid":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).inviteCodeError, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "OrderDetailService_CantFindGuestInfo":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).inviteCodeError, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "GEN_InvalidId":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "GEN_CreateFailed":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "GEN_UpdateFailed":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        //account
        case "ACC_WrongUserNameOrPassWord":
          {
            Errors errors = Errors(
                -1, AppLocalizations.of(context).translate(AppString.ERROR_WRONG_USER_PASSWORD), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_MissingXAuth":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "DE_DeviceExisted":
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).existedDevice, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "COM_WrongDomain":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).emailNotExist, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.ERROR_LIMIT_UPLOAD:
          {
            Errors errors = Errors(0, Constants.ERROR_LIMIT_UPLOAD, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_MissingUsername":
          {
            Errors errors =
                Errors(0, AppLocalizations.of(context).translate(AppString.ERROR_NO_USERNAME), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_MissingPwd":
          {
            Errors errors =
                Errors(1, AppLocalizations.of(context).translate(AppString.ERROR_NO_PASSWORD), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_WrongUsername":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).emailNotExist, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_Locked":
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).accountLocked, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_Deactive":
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).accountDeactivated, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_AccountIsNotActive":
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).accountDeactivated, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_WrongPwd":
          {
            Errors errors = Errors(1, AppLocalizations.of(context).wrongPassword, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_InvalidToken":
          {
            Errors errors = Errors(-401, AppLocalizations.of(context).changedConfiguration, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.EVENT_ERROR:
          {
            Errors errors = Errors(0, Constants.EVENT_ERROR, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_ExpiredToken":
          {
            Errors errors = Errors(-401, AppLocalizations.of(context).expiredToken, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_InvalidRefreshToken":
          {
            Errors errors = Errors(-401, AppLocalizations.of(context).changedConfiguration, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_NotFoundRoles":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).noPermission, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_ExpiredRefreshToken":
          {
            Errors errors = Errors(-401, AppLocalizations.of(context).expiredToken, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_EmailNotFound":
          {
            Errors errors = Errors(0, AppLocalizations.of(context).emailNotExist, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "ACC_InvalidPwd":
          {
            Errors errors = Errors(
                0,
                "Must be at least 6 characters. Not contain user name or parts of the full name. Use different types of characters lower case/upper case/number/symbol",
                DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "CO_NumberOfDevicesExceedsLimit":
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).limitDevice, DialogType.INFO);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.VALIDATE_ALREADY:
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).alreadyCheckout, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case Constants.VALIDATE_WRONG:
          {
            Errors errors = Errors(-1, AppLocalizations.of(context).errorInviteCode, DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        //filefolder
        case "FOLDER_CreateFail":
          {
            Errors errors = Errors(0, "File upload failed. Cannot create folder", DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "FILE_NotFound":
          {
            Errors errors = Errors(0, "File not found", DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        //company
        case "CO_InvalidName":
          {
            Errors errors = Errors(0, "Invalid Name", DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        case "VIS_IsRequired_PhoneNumber":
          {
            Errors errors = Errors(0, "VIS_IsRequired_PhoneNumber", DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
        default:
          {
            Errors errors =
                Errors(-1, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
            apiCallBack.onError(errors);
            break;
          }
      }
    }
    return true;
  }

  String getStatusCodeRequestAPI(Response response, ResponseType type) {
    if (response.isSuccessful) {
      var baseResponse;
      switch (type) {
        case ResponseType.FILE:
          {
            return Constants.STATUS_SUCCESS;
          }
        case ResponseType.OBJECT:
          {
            baseResponse = BaseResponse.fromJson(response.body);
            break;
          }
        case ResponseType.LIST:
          {
            baseResponse = BaseListResponse.fromJson(response.body);
            break;
          }
      }
      if (baseResponse.success) {
        return Constants.STATUS_SUCCESS;
      }
      if (baseResponse.errors != null && baseResponse.errors.isNotEmpty) return baseResponse.errors[0];
      return Constants.B500;
    }
    return response.statusCode.toString();
  }

  handlerError(BuildContext context, ApiCallBack apiCallBack, String message) {
    Utilities().writeLog(message);
    Errors errors;
    try {
      errors = Errors(-1, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
      apiCallBack.onError(errors);
    } catch (e) {
      Utilities().printLog(e.toString());
      try {
        errors = Errors(-1, AppLocalizations.of(context).translate(AppString.MESSAGE_COMMON_ERROR), DialogType.ERROR);
        apiCallBack.onError(errors);
      } catch (e) {
        errors = Errors(-1001, "Something when wrong! Please restart app or contact administrator", DialogType.ERROR);
        apiCallBack.onError(errors);
      }
    }
  }

  void catchSocketException(dynamic socketException) {
    if (socketException is SocketException) {
      Utilities().writeLog(socketException.toString());
      var socket = socketException;
      Utilities().writeLog(socket.message);
      Utilities().writeLog(socket.port.toString());
      Utilities().writeLog(socket.address.toString());
      Utilities().writeLog(socket.osError.toString());
    }
    if (socketException is Response) {
      Utilities().writeLog(socketException.toString());
      Utilities().writeLog(socketException.bodyString);
      Utilities().writeLog(socketException.body.toString());
    }
    Utilities().writeLog(socketException.toString());
  }
}
