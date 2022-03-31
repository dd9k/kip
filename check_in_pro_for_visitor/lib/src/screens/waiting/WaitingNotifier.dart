import 'dart:async';
import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/model/Authenticate.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'dart:typed_data';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlowObject.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/ConfigKiosk.dart';
import 'package:check_in_pro_for_visitor/src/model/EventDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicket.dart';
import 'package:check_in_pro_for_visitor/src/model/EventTicketDetail.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/model/FunctionGroup.dart';
import 'package:check_in_pro_for_visitor/src/model/ImageDownloaded.dart';
import 'package:check_in_pro_for_visitor/src/model/KickModel.dart';
import 'package:check_in_pro_for_visitor/src/model/ListCheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/ListQRCreate.dart';
import 'package:check_in_pro_for_visitor/src/model/TimekeepingQR.dart';
import 'package:check_in_pro_for_visitor/src/model/UserInfor.dart';
import 'package:check_in_pro_for_visitor/src/model/ValidateEvent.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/companyBuilding/CompanyBuildScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/SettingScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/UtilityNotifier.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseListResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Configuration.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../model/UserInfor.dart';
import '../../utilities/Utilities.dart';

class ButtonAction {
  ButtonAction({
    @required this.title,
    @required this.imageString,
    @required this.action,
  });

  final String title;
  final String imageString;
  final Function action;
}

class WaitingNotifier extends UtilityNotifier {
  final GlobalKey repaintBoundary = new GlobalKey();
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int isUpdatedStatus = 0;
  int remainder = 0;
  int timeReload = Constants.TIME_RELOAD_QR;
  bool isLoading = true;
  bool isHaveDelivery = false;
  bool isShowQR = false;
  bool isHaveQRError = false;
  bool isHaveQRAlready = false;
  bool isConnection = true;
  Timer timerClock;
  Timer timerReloadQR;
  Timer timerExpiredTouchless;
  List<TimekeepingQR> listQR = List();
  ListQRCreate qrCreate;
  int indexQR = 0;
  var textWaiting = "";
  bool isLoadCamera = true;

  bool isLoadWelcome = true;
  bool isDoneImage = false;
  bool isDoneLogo = false;
  bool isDoneSubLogo = false;
  bool isDoneConfig = false;
  bool isDoneFlows = false;
  bool isEventMode = false;
  bool isDoneCompany = false;
  bool isDoneFunction = false;
  bool isDoneSurvey = false;
  bool isBuilding = false;

  double branchId = 0.0;
  int countSaveCompany = 0;
  int countSaveWaiting = 0;
  int countBackground = 0;
  bool isHaveEvent = false;
  bool isShowFAB = true;
  String backgroundColor = "";
  List<Color> listColor = List();
  String companyName = "";
  String textCheckIn = "";
  String textCheckOut = "";
  Map<String, dynamic> mapLangName;
  Map<String, dynamic> mapLangCheckIn;
  Map<String, dynamic> mapLangCheckOut;
  int textSize = 6;
  String companyNameColor;
  String chkInColor;
  String chkInTextColor;
  String chkOutColor;
  String chkOutTextColor;
  List<String> image = List();
  List<String> imageLocalPath = List();
  List<CompanyBuilding> listCompanyBuilding = List();
  Timer timerSignalR;
  CancelableOperation cancelableOperation;
  CancelableOperation cancelEvent;
  AsyncMemoizer<void> memCache = AsyncMemoizer();
  AsyncMemoizer<void> memCacheQR = AsyncMemoizer();
  bool isNext = false;
  bool isWarning = false;
  List<VisitorType> listType = List();
  ConfigKiosk configKios;
  VisitorCheckIn visitorCheckIn;
  var touchlessLink = "";
  int touchlessExpired = 0;
  bool isExpired = false;
  bool isRefresh = false;
  bool isHaveSaver = false;
  bool isEventTicket = false;
  int countRefreshFail = 0;

  QRViewController controller;
  bool isScanned = false;
  bool isProcessing = false;
  double eventId;
  double eventTicketId;
  String qrCodeStr = "";
  String messagePopup = "";
  PrinterModel printer;
  bool isDoneAnyWay = false;
  Timer timerDoneAnyWay;
  Timer timerReset;
  var type = BackgroundType.WAITING_NEW;
  List<ButtonAction> items = List();
  String visitorType = Constants.VT_VISITORS;
  String lastQR = "";
  final assetsAudioPlayer = AssetsAudioPlayer();
  EventDetail eventDetail;
  EventTicket eventTicket = EventTicket.init();

  List<ButtonAction> getList() {
    items = <ButtonAction>[
      ButtonAction(
          title: textCheckIn,
          imageString: 'assets/images/checkin.png',
          action: () => moveToNextScreen(HomeNextScreen.CHECK_IN, false)),
      ButtonAction(
          title: textCheckOut,
          imageString: 'assets/images/checkout.png',
          action: () => moveToNextScreen(HomeNextScreen.CHECK_OUT, false)),
      if (isHaveDelivery)
        ButtonAction(
            title: appLocalizations.titleDelivery,
            imageString: 'assets/images/delivery.png',
            action: () => moveToNextScreen(HomeNextScreen.CHECK_IN, true)),
    ];
    return items;
  }

  void doneJobAnyWay() {
    Timer(Duration(seconds: 4), () {
      navigationService.navigateTo(SplashScreen.route_name, 3);
    });
  }

  Future<void> startStream() async {
    controller.scannedDataStream.listen((scanData) async {
      if (this.controller != null && !isScanned && scanData.code != lastQR) {
        lastQR = scanData.code;
        resetLastQR();
        this.isScanned = true;
        qrCodeStr = scanData.code;
        _showPopupWaiting(appLocalizations.waitingTitle);
        getDataFromQR();
      }
    });
  }

  Future refreshToken(BuildContext context) async {
    if (!isRefresh) {
      isRefresh = true;
      var firebaseId = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
      ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
        countRefreshFail = 0;
        var authenticationString = JsonEncoder().convert(baseResponse.data);
        preferences.setString(Constants.KEY_AUTHENTICATE, authenticationString);
        reloadWaiting(isReloadAll: true);
        locator<SyncService>().syncEventFail(context);
        updateClock();
      }, (Errors message) async {
        if (countRefreshFail < 6) {
          await Future.delayed(Duration(milliseconds: 1000));
          refreshToken(context);
        } else {
          countRefreshFail = 0;
          if (message.code != -2 && message.code == -401) {
            CancelableOperation cancelableLogout;
            Utilities().popupAndSignOut(context, cancelableLogout, appLocalizations.expiredToken);
          } else {
            await Future.delayed(Duration(milliseconds: 1000));
            refreshToken(context);
          }
        }
        updateClock();
        countRefreshFail++;
      });
      var authorization = await Utilities().getAuthorization();
      var token = (authorization as Authenticate).refreshToken;
      await ApiRequest().requestRefreshTokenApi(context, firebaseId, token, listCallBack);
      utilities.countDownToResetApp(0, context);
      isRefresh = false;
    }
  }

  void resetLastQR() {
    timerReset?.cancel();
    timerReset = Timer(Constants.TIMER_PREVENT_SCAN, () async {
      lastQR = "";
    });
  }

  void preventUpdateStatus() {
    if (isUpdatedStatus == 0) {
      Timer(Duration(minutes: 5), () {
        isUpdatedStatus = 0;
      });
    }
    isUpdatedStatus++;
  }

  void touchScreen() {
    if (isHaveSaver) {
      utilities.moveToSaver(context, configKios.saverModel, imageLocalPath, currentLang, companyNameColor, db, kickWhenBack);
    }
  }

  Future kickWhenBack({isCancel: true, Map<String, dynamic> saverMess}) async {
    isNext = false;
    if (isCancel) {
      reloadCamera();
      Timer(Duration(seconds: 1), () => utilities.cancelWaiting());
    }
    var isKick = preferences.getString(Constants.KEY_IS_KICK) ?? "";
    if (isKick.isNotEmpty) {
      var kickModel = KickModel.fromJson(jsonDecode(isKick));
      kickBySignalR(kickModel.title, kickModel.content);
      preferences.setString(Constants.KEY_IS_KICK, "");
    }
    getQRCreate(context);
    firebaseCloudMessaging_Listeners();
    if (saverMess != null) {
      handlerMSGFirebase(saverMess);
    } else {
      touchScreen();
    }
  }

  Future<void> reloadCamera() async {
    if (type == BackgroundType.TOUCH_LESS) {
      qrKey = GlobalKey(debugLabel: 'QR');
      isLoadCamera = false;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 700));
      isLoadCamera = true;
      notifyListeners();
    }
  }

  Future<void> moveToNextScreen(HomeNextScreen type, bool isDelivery) async {
    isNext = true;
    var isScanIdCard;
    if (listType == null || listType.isEmpty) {
      isScanIdCard = false;
    } else {
      isScanIdCard = await Utilities().checkIsScanId(context, listType[0].settingKey);
    }
    switch (type) {
      case HomeNextScreen.CHECK_IN:
        {
          if (isEventMode) {
            navigationService
                .navigateTo(ScanQRScreen.route_name, 1, arguments: {'isCheckOut': false}).then((value) async {
              await kickWhenBack();
            });
          } else if (isBuilding) {
            navigationService.navigateTo(CompanyBuildingScreen.route_name, 1,
                arguments: {'isDelivery': isDelivery}).then((value) async {
              await kickWhenBack();
            });
          } else if (isScanIdCard && !isDelivery && (listType == null || listType.length < 2)) {
            navigationService.navigateTo(ScanVisionScreen.route_name, 1, arguments: {
              'isCheckIn': true,
              'isDelivery': isDelivery,
              'visitor': VisitorCheckIn.inital()
            }).then((value) async {
              await kickWhenBack();
            });
          } else {
            navigationService.navigateTo(InputPhoneScreen.route_name, 1, arguments: {
              'isDelivery': isDelivery,
              'visitor': VisitorCheckIn.inital()
            }).then((value) async {
              await kickWhenBack();
            });
          }
          break;
        }
      case HomeNextScreen.CHECK_OUT:
        {
          if (isEventMode) {
            navigationService
                .navigateTo(ScanQRScreen.route_name, 1, arguments: {'isCheckOut': true}).then((value) async {
              await kickWhenBack();
            });
          } else if (isScanIdCard) {
            navigationService.navigateTo(ScanVisionScreen.route_name, 1, arguments: {
              'isCheckIn': false,
              'isDelivery': isDelivery,
              'visitor': VisitorCheckIn.inital()
            }).then((value) async {
              await kickWhenBack();
            });
          } else {
            navigationService.navigateTo(CheckOutScreen.route_name, 1,
                arguments: {'isDelivery': isDelivery}).then((value) async {
              await kickWhenBack();
            });
          }
          break;
        }
      case HomeNextScreen.SCAN_QR:
        {
          navigationService.navigateTo(ScanQRScreen.route_name, 1).then((value) async {
            await kickWhenBack();
          });
          break;
        }
      default:
        {
          isNext = false;
          break;
        }
    }
  }

  Future<void> moveToTouchless(
      VisitorCheckIn visitorCheckIn, String inviteCode, String phoneNumber, HomeNextScreen type) async {
    _dissmissPopupWaiting();
    isDoneAnyWay = false;
    switch (type) {
      case HomeNextScreen.FACE_CAP:
        {
          resumeScan();
          navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: {
            'visitor': visitorCheckIn,
            'isReplace': false,
            'isShowBack': false,
            'isQRScan': true,
            'inviteCode': inviteCode,
            'phoneNumber': phoneNumber
          }).then((value) => kickWhenBack());
          break;
        }
      case HomeNextScreen.THANK_YOU:
        {
          assetsAudioPlayer.play();
          Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LESS,
              appLocalizations.hi, visitorCheckIn.fullName, null);
          resumeScan();
//          navigationService.pushNamedAndRemoveUntil(
//              ThankYouScreen.route_name, WaitingScreen.route_name, false,
//              arguments: {
//                'visitor': visitorCheckIn,
//              });
          break;
        }
      case HomeNextScreen.FEED_BACK:
        {
          assetsAudioPlayer.play();
          Utilities().showNoButtonDialog(context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LESS,
              appLocalizations.translate(AppString.MESSAGE_THANK_YOU_CHATBOX), visitorCheckIn.fullName, null);
          resumeScan();
//          navigationService
//              .pushNamedAndRemoveUntil(FeedBackScreen.route_name, WaitingScreen.route_name, arguments: {
//            'visitorCheckIn': visitorCheckIn,
//            'visitorLog': null,
//            'inviteCode': inviteCode,
//            'phoneNumber': phoneNumber,
//            'isSyncNow': false,
//            'isEvent': true,
//          });
          break;
        }
      default:
        {
          isNext = false;
          break;
        }
    }
  }

  Future<void> getConfiguration() async {
    return memCache.runOnce(() async {
      isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
      eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
      eventTicketId = preferences.getDouble(Constants.KEY_EVENT_TICKET_ID);
      isEventTicket = utilities.getUserInforNew(preferences).isEventTicket;
      notifyListeners();
      await Utilities().getDefaultLang(context);
      var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      if (isEventMode) {
        if (isEventTicket) {
          eventTicket = await db.eventTicketDAO.getEventTicketById(eventTicketId);
        } else {
          eventDetail = await this.db.eventDetailDAO.getEventDetail();
        }
      }
      var userInfor = await Utilities().getUserInfor();
      listLang = userInfor.companyLanguage;
      textWaiting = appLocalizations.translate(AppString.MESSAGE_TOUCH_START);
      branchId = userInfor?.deviceInfo?.branchId ?? 0.0;
      isWarning = userInfor?.companyInfo?.isWarning() ?? false;
      isLoadWelcome = preferences.getBool(Constants.KEY_LOAD_WELCOME) ?? true;
      printer = await Utilities().getPrinter();
      configKios = await utilities.getConfigKios();
      touchlessLink = configKios?.touchlessModel?.token ?? "";
      touchlessExpired = configKios?.touchlessModel?.expiredTimestamp ?? -1;
      type = (configKios?.touchlessModel?.status == true && !isEventMode)
          ? BackgroundType.TOUCH_LESS
          : BackgroundType.WAITING_NEW;
      textCheckIn = appLocalizations.titleCheckIn0;
      textCheckOut = appLocalizations.titleCheckOut;
      assetsAudioPlayer.open(Audio("assets/audios/ding.mp3"), showNotification: false, autoStart: false);
      assetsAudioPlayer.setVolume(1.0);
      isConnection = await Utilities().isConnectInternet(isChangeState: false);
      if (parent.isConnection && isLoadWelcome) {
        currentLang = langSaved;
        return loadDataOnline(userInfor);
      } else {
        currentLang = langSaved;
        return loadDataOffline(userInfor);
      }
    });
  }

  Future getUserInfor() async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var userInforString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_USER_INFOR, userInforString);
      var userInfor = UserInfor.fromJson(baseResponse.data);
      var lang = userInfor?.companyLanguage?.elementAt(0)?.languageCode ?? Constants.EN_CODE;
      if (!Constants.LIST_LANG.contains(lang)) {
        lang = Constants.EN_CODE;
      }
      preferences.setString(Constants.KEY_LANGUAGE, lang);
      await appLocalizations.load(Locale(lang));
      reloadWaiting();
    }, (Errors message) {});

    var deviceInfor = await Utilities().getDeviceInfo();
    await ApiRequest().requestUserInfor(context, deviceInfor.identifier, callBack);
  }

  getFlowOnline() async {
    ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
      //Callback SUCCESS
      var _resp = ListCheckInFlow.fromJson(baseResponse.data);
      List<CheckInFlowObject> flows = _resp.flows;
      var badgeTemplate = _resp.badgeTemplateCode;
      preferences.setString(Constants.KEY_BADGE_PRINTER, badgeTemplate);
      await db.checkInFlowDAO.deleteAlls();
      await Future.forEach(flows, (CheckInFlowObject element) async {
        await db.checkInFlowDAO.insertAlls(element.flow);
      });

      isDoneFlows = true;
      handlerDone();
    }, (Errors message) async {
      //Callback ERROR
      isDoneFlows = true;
      handlerDone();
    });
    ApiRequest().requestGetFlow(context, branchId, listCallBack);
  }

  getFunctionOnline() async {
    var account = await Utilities().getUserInfor();
    ApiCallBack listCallBack = ApiCallBack((BaseListResponse baseListResponse) async {
      //Callback SUCCESS
      var listFunction = baseListResponse.data.map((Map model) => FunctionGroup.fromJson(model)).toList();
      preferences.setBool(Constants.FUNCTION_EVENT, false);
      listFunction.forEach((FunctionGroup element) {
        if (element.functionName == Constants.FUNCTION_EVENT &&
            element.permission != null &&
            element.permission.isNotEmpty) {
          preferences.setBool(Constants.FUNCTION_EVENT, true);
        }
      });

      isDoneFunction = true;
      handlerDone();
//      }
    }, (Errors message) async {
      //Callback ERROR
      isDoneFunction = true;
      handlerDone();
    });
    ApiRequest().requestFunctionGroup(context, account.accountId, listCallBack);
  }

  getQRCreate(BuildContext context) async {
    memCacheQR = AsyncMemoizer();
    memCacheQR.runOnce(() async {
      isShowQR = false;
      notifyListeners();
      ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
        //Callback SUCCESS
        if (baseResponse.data != null) {
          listQR.clear();
          indexQR = 0;
          qrCreate = ListQRCreate.fromJson(baseResponse.data);
          listQR = qrCreate?.qrCodes ?? List();
          if (listQR.isNotEmpty && qrCreate.status == true) {
            int now = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
            int expired = now - (listQR[0].expiredTime - qrCreate.refreshTime);
            timeReload = qrCreate?.refreshTime ?? Constants.TIME_RELOAD_QR;
            if (expired > timeReload) {
              int len = expired ~/ timeReload;
              int numberExpired = (len > 0) ? len - 1 : len;
              remainder = timeReload - (expired % timeReload);
              listQR.removeRange(0, numberExpired);
            } else {
              remainder = timeReload - expired;
            }
            utilities.printLog("timeReload $timeReload refreshTime ${qrCreate?.refreshTime} remainder $remainder");
            isShowQR = true;
            isHaveQRAlready = true;
            isHaveQRError = false;
            notifyListeners();
          } else {
            isHaveQRAlready = false;
            isHaveQRError = false;
            isShowQR = false;
            notifyListeners();
          }
        } else {
          isHaveQRError = true;
          isShowQR = false;
          notifyListeners();
        }
      }, (Errors message) async {
        //Callback ERROR
        isShowQR = false;
        isHaveQRError = true;
        notifyListeners();
      });
      ApiRequest().requestQRCreate(context, branchId, listCallBack);
    });
  }

  void reloadQR() {
    indexQR++;
    if (indexQR > ((2 * listQR.length) ~/ 3)) {
      getQRCreate(context);
    } else {
      notifyListeners();
    }
  }

//  getContactPerson(, double branchId) async {
//    ApiCallBack listCallBack = ApiCallBack((BaseListResponse baseListResponse) async {
//      //Callback SUCCESS
//      if (baseListResponse.data != null) {
//        contactPerson = baseListResponse.data
//            .map((Map model) => ContactPerson.fromJson(model))
//            .toList();
//        if (contactPerson.isNotEmpty) {
//          contactPerson.asMap().forEach((index, it) async {
//            if (it.avatarFileName == null || it.avatarFileName.isEmpty) {
//              try {
//                final byteData =
//                await rootBundle.load('assets/images/default_avatar.png');
//                var path = await Utilities().getLocalPathFile(
//                    Constants.FOLDER_TEMP,
//                    Constants.FILE_TYPE_CONTACT_PERSON,
//                    index.toString(),
//                    null);
//                await Utilities().writeToFile(byteData, path);
//
//                contactPerson[index].logoPathLocal = path;
//                contactPerson[index].index = index;
//                countContactPerson++;
//                if (countContactPerson >= contactPerson.length) {
//                  isDoneContact = true;
//                  if (contactPerson.length > 0) {
//                    await db.contactPersonDAO.deleteAlls();
//                    await db.contactPersonDAO.insertAlls(contactPerson);
//                  }
//                  handlerDone(context);
//                }
//              } catch (e) {
//                countContactPerson++;
//                if (countContactPerson >= contactPerson.length) {
//                  isDoneContact = true;
//                  if (contactPerson.length > 0) {
//                    await db.contactPersonDAO.deleteAlls();
//                    await db.contactPersonDAO.insertAlls(contactPerson);
//                  }
//                  handlerDone(context);
//                }
//              }
//            } else {
//              getImage(context, Constants.FILE_TYPE_CONTACT_PERSON,
//                  it.avatarFileName, index);
//            }
//          });
//        } else {
//          isDoneContact = true;
//          handlerDone(context);
//        }
//      } else {
//        isDoneContact = true;
//        handlerDone(context);
//      }
//    }, (Errors message) async {
//      //Callback ERROR
//      isDoneContact = true;
//      handlerDone(context);
//    });
//    ApiRequest().requestContactPerson(context, branchId, listCallBack);
//  }

  getConfigKios() async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      countSaveWaiting = 0;
      var configKiosString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_CONFIG_KIOS, configKiosString);
      configKios = ConfigKiosk.fromJson(baseResponse.data);
      var isTouchless = configKios?.touchlessModel?.status == true;
      touchlessLink = configKios?.touchlessModel?.token ?? "";
      touchlessExpired = configKios?.touchlessModel?.expiredTimestamp ?? -1;
      type = (isTouchless && !isEventMode) ? BackgroundType.TOUCH_LESS : BackgroundType.WAITING_NEW;
      await db.visitorTypeDAO.deleteAll();
      await Future.forEach(configKios.visitorType, (VisitorType element) async {
        await db.visitorTypeDAO.insert(element);
      });
      if (configKios?.saverModel != null && configKios?.saverModel?.status == true) {
        isHaveSaver = true;
      if (configKios?.saverModel?.images?.isNotEmpty == true) {
          var listImage = configKios?.saverModel?.images;
          for (var index = 0; index < listImage.length; index++) {
            ImageDownloaded image = await db.imageDownloadedDAO.getByLink(listImage[index]);
            if (image == null) {
              List<String> list = listImage[index].split("/");
              getImage(Constants.FILE_TYPE_IMAGE_SAVER, listImage[index], index, nameFile: list.last);
            } else {
              countSaveWaiting++;
            }
            if (countSaveWaiting == configKios.saverModel.images.length) {
              isDoneConfig = true;
              handlerDone();
            }
          }
        } else {
          isDoneConfig = true;
          handlerDone();
        }
      } else {
        isHaveSaver = false;
        isDoneConfig = true;
        handlerDone();
      }
    }, (Errors message) async {
      isDoneConfig = true;
      handlerDone();
    });

    await ApiRequest().requestConfigKios(context, branchId, callBack);
  }

  getSurvey() async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var surveyString = JsonEncoder().convert(baseResponse.data);
      preferences.setString(Constants.KEY_SURVEY, surveyString);
      isDoneSurvey = true;
      handlerDone();
    }, (Errors message) async {
      isDoneSurvey = true;
      handlerDone();
    });

    await ApiRequest().requestSurvey(context, branchId, callBack);
  }

  void updateStatus(String status) async {
    if (isUpdatedStatus <= 5) {
      preventUpdateStatus();
      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {}, (Errors message) async {});

      await ApiRequest().requestUpdateStatus(context, status, callBack);
    }
  }

  getCompanyOnline() async {
    await db.companyBuildingDAO.deleteAlls();
    countSaveCompany = 0;
    ApiCallBack callBack = ApiCallBack((BaseListResponse baseListResponse) async {
      if (baseListResponse.data != null) {
        listCompanyBuilding = baseListResponse.data.map((Map model) => CompanyBuilding.fromJson(model)).toList();
        if (listCompanyBuilding.isNotEmpty) {
          for (var index = 0; index < listCompanyBuilding.length; index++) {
            if (listCompanyBuilding[index].logoPath == null || listCompanyBuilding[index].logoPath.isEmpty) {
              try {
                final byteData = await rootBundle.load('assets/images/temp_company.png');
                var path = await Utilities().getLocalPathFile(
                    Constants.FOLDER_TEMP, Constants.FILE_TYPE_COMPANY_BUILDING, index.toString(), null);
                await Utilities().writeToFile(byteData, path);

                listCompanyBuilding[index].logoPathLocal = path;
                listCompanyBuilding[index].index = index;
                countSaveCompany++;
                if (countSaveCompany >= listCompanyBuilding.length) {
                  isDoneCompany = true;
                  if (listCompanyBuilding.length > 0) {
                    await db.companyBuildingDAO.deleteAlls();
                    await db.companyBuildingDAO.insertAlls(listCompanyBuilding);
                  }
                  handlerDone();
                }
              } catch (e) {
                countSaveCompany++;
                if (countSaveCompany >= listCompanyBuilding.length) {
                  isDoneCompany = true;
                  if (listCompanyBuilding.length > 0) {
                    await db.companyBuildingDAO.deleteAlls();
                    await db.companyBuildingDAO.insertAlls(listCompanyBuilding);
                  }
                  handlerDone();
                }
              }
            } else {
              getImage(Constants.FILE_TYPE_COMPANY_BUILDING, listCompanyBuilding[index].logoPath, index);
            }
          }
        } else {
          isDoneCompany = true;
          handlerDone();
        }
      } else {
        isDoneCompany = true;
        handlerDone();
      }
    }, (Errors message) async {
      isDoneCompany = true;
      handlerDone();
    });

    await ApiRequest().requestAllCompanyBuilding(context, callBack);
  }

  Future loadDataOffline(UserInfor userInfor) async {
    isLoading = true;
    notifyListeners();
    isDoneImage = false;
    isDoneLogo = false;
    isDoneSubLogo = false;
    isDoneFlows = true;
    isDoneFunction = true;
    isDoneSurvey = true;
    isDoneConfig = true;
    isDoneCompany = true;

    if (configKios?.saverModel != null && configKios?.saverModel?.status == true) {
      isHaveSaver = true;
    } else {
      isHaveSaver = false;
    }
    List<Configuration> configuration = await db.configurationDAO.getAllConfigurations();
    if (configuration != null && configuration.isNotEmpty) {
      await renderToUI(configuration, userInfor);

      handlerDone();
    } else {
      if (companyName.isEmpty) {
        companyName = userInfor.companyInfo.name;
      }
      isDoneImage = true;
      isDoneLogo = true;
      isDoneSubLogo = true;
      handlerDone();
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> firebaseCloudMessaging_Listeners() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        utilities.printLog("_firebaseMessaging: $message");
        await handlerMSGFirebase(message);
      },
      onResume: (Map<String, dynamic> message) async {
      },
      onLaunch: (Map<String, dynamic> message) async {
//        await handlerMSGFirebase(message, context);
      },
    );
  }

  Future handlerMSGFirebase(Map<String, dynamic> message) async {
    var data = message['data'] ?? message;
    String mess = data['value'];
    if (mess == Constants.TYPE_BRANDING) {
      reloadWaiting();
    } else if (mess.contains(Constants.TYPE_DEVICE_CONFIGURATION)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.deletedDevice);
    } else if (mess.contains(Constants.TYPE_PASSWORD_CONFIGURATION)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.changedAccount);
    } else if (mess.contains(Constants.TYPE_ACCOUNT_CONFIGURATION)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.deletedAccount);
    } else if (mess.contains(Constants.TYPE_CHANGE_LANGUAGE)) {
      isDoneFlows = false;
      getFlowOnline();
      getUserInfor();
    } else if (mess.contains(Constants.TYPE_DELETE_BRANCH)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.deletedBranch);
    } else if (mess.contains(Constants.TYPE_LOCK_ACCOUNT)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.accountLocked);
    } else if (mess.contains(Constants.TYPE_TEMPLATE)) {
      isLoading = true;
      isDoneFlows = false;
      notifyListeners();
      await getFlowOnline();
    } else if (mess.contains(Constants.TYPE_DEACTIVATE_ACCOUNT)) {
      await kickBySignalR(appLocalizations.changedConfiguration, appLocalizations.accountDeactivated);
    } else if (mess.contains(Constants.TYPE_BRANCH_CONFIG)) {
      isDoneConfig = false;
      isDoneSurvey = false;
      getConfigKios();
      getSurvey();
    } else if (mess.contains(Constants.TYPE_TOUCH_LESS)) {
      isDoneConfig = false;
      isLoading = true;
      notifyListeners();
      getConfigKios();
    } else if (mess.contains(Constants.TYPE_HR)) {
      getQRCreate(context);
    } else if (mess.contains(Constants.TYPE_WAITING)) {
      isDoneConfig = false;
      getConfigKios();
    } else if (mess.contains(Constants.TYPE_SURVEY_HEALTH_DECLARATION)) {
      isDoneSurvey = false;
      getSurvey();
    }
  }

  bool checkIsDone() {
    return isDoneImage &&
        isDoneLogo &&
        isDoneFlows &&
        isDoneCompany &&
        isDoneConfig &&
        isDoneFunction &&
        isDoneSubLogo &&
        isDoneSurvey;
  }

  Future loadDataOnline(UserInfor userInfor) async {
    isLoading = true;
    notifyListeners();
    isDoneImage = false;
    isDoneLogo = false;
    isDoneSubLogo = false;
    preferences.setBool(Constants.KEY_LOAD_WELCOME, false);
    updateStatus(Constants.STATUS_ONLINE);
    ApiCallBack callBack = ApiCallBack((BaseListResponse baseListResponse) async {
      List<Configuration> configuration =
          baseListResponse.data.map((Map model) => Configuration.fromJson(model)).toList();
      await db.configurationDAO.deleteAll();
      await Future.forEach(configuration, (element) async {
        await db.configurationDAO.insert(element);
      });
      await renderToUI(configuration, userInfor);
      var firstStart = preferences.getBool(Constants.KEY_FIRST_START) ?? true;
      if (firstStart) {
        isDoneSurvey = false;
        isDoneFunction = false;
        isDoneConfig = false;
        isDoneCompany = false;
        isDoneFlows = false;
        getFlowOnline();
        getConfigKios();
        getSurvey();
        getFunctionOnline();
        var printer = await Utilities().getPrinter();
        if (printer != null) {
          printer.connectPrinter();
        }
        if (userInfor.isBuilding) {
          getCompanyOnline();
        } else {
          isDoneCompany = true;
        }
        preferences.setBool(Constants.KEY_FIRST_START, false);
      } else {
        isDoneFlows = true;
        isDoneConfig = true;
        isDoneCompany = true;
        isDoneFunction = true;
        isDoneSurvey = true;
      }
      handlerDone();
    }, (Errors message) {
      loadDataOffline(userInfor);
    });

    return await ApiRequest().requestConfiguration(context, Constants.TYPE_BRANDING, callBack);
  }

  Future renderToUI(List<Configuration> configuration, UserInfor userInfor) async {
    await Future.forEach(configuration, (element) async {
      switch (element.code) {
        case Constants.CONFIGURATION_BACKGROUND_COLOR:
          {
            try {
              listColor.clear();
              backgroundColor = "";
              if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
                backgroundColor = Constants.PREFIX_COLOR + (element.value[0] as String).replaceAll('"', "");
                element.value.forEach((color) {
                  var colorValue = Constants.PREFIX_COLOR +
                      (color as String).replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
                  try {
                    listColor.add(Color(int.parse(colorValue)));
                  } catch (e) {
                    listColor.add(AppColor.MAIN_TEXT_COLOR);
                  }
                });
              }
            } catch (e) {
              listColor.add(AppColor.MAIN_TEXT_COLOR);
              backgroundColor = Constants.PREFIX_COLOR + "ffffff";
            }
            break;
          }
        case Constants.CONFIGURATION_LAYOUTS:
          {
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
//              layoutStyle = element.value[0] as String;
//              preferences.setString(Constants.KEY_STYLE_LAYOUT, layoutStyle);
            } else {
//              layoutStyle = Constants.STYLE_2;
//              preferences.setString(Constants.KEY_STYLE_LAYOUT, layoutStyle);
            }
            break;
          }
        case Constants.CONFIGURATION_COMPANY_LOGO:
          {
            if (element.value != null &&
                element.value.isNotEmpty &&
                element.value[0].isNotEmpty &&
                parent.isConnection &&
                isLoadWelcome) {
              var savedCompanyLogo = preferences.getString(Constants.KEY_COMPANY_LOGO) ?? "";
              if (savedCompanyLogo != element.value[0]) {
                preferences.setString(Constants.KEY_COMPANY_LOGO, element.value[0]);
                await getImage(Constants.FILE_TYPE_LOGO_COMPANY, element.value[0], 0);
              } else {
                isDoneLogo = true;
              }
            } else {
              if (parent.isConnection && isLoadWelcome) {
                var file =
                    await Utilities().getLocalFile(Constants.FOLDER_TEMP, Constants.FILE_TYPE_LOGO_COMPANY, "0", null);
                Utilities().deleteFile(file);
              }
              isDoneLogo = true;
            }
            break;
          }
        case Constants.CONFIGURATION_SUB_COMPANY_LOGO:
          {
            if (element.value != null &&
                element.value.isNotEmpty &&
                element.value[0].isNotEmpty &&
                parent.isConnection &&
                isLoadWelcome) {
              var savedCompanyLogo = preferences.getString(Constants.KEY_COMPANY_SUB_LOGO) ?? "";
              if (savedCompanyLogo != element.value[0]) {
                preferences.setString(Constants.KEY_COMPANY_SUB_LOGO, element.value[0]);
                await getImage(Constants.FILE_TYPE_LOGO_SUB_COMPANY, element.value[0], 0);
              } else {
                isDoneSubLogo = true;
              }
            } else {
              if (parent.isConnection && isLoadWelcome) {
                var file = await Utilities()
                    .getLocalFile(Constants.FOLDER_TEMP, Constants.FILE_TYPE_LOGO_SUB_COMPANY, "0", null);
                Utilities().deleteFile(file);
              }
              isDoneSubLogo = true;
            }
            break;
          }
        case Constants.CONFIGURATION_COMPANY_NAME:
          {
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
              mapLangName = json.decode(element.value[0]);
              if (!Constants.LIST_LANG.contains(langSaved)) {
                langSaved = Constants.EN_CODE;
              }
              companyName = mapLangName[langSaved];
            } else {
              companyName = userInfor.companyInfo.name;
            }
            break;
          }
        case Constants.CONFIGURATION_CHECKIN_BUTTON_TEXT:
          {
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
              mapLangCheckIn = json.decode(element.value[0]);
              if (!Constants.LIST_LANG.contains(langSaved)) {
                langSaved = Constants.EN_CODE;
              }
              textCheckIn = mapLangCheckIn[langSaved];
            } else {
              textCheckIn = appLocalizations.titleCheckIn;
            }
            break;
          }
        case Constants.CONFIGURATION_CHECKOUT_BUTTON_TEXT:
          {
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
              mapLangCheckOut = json.decode(element.value[0]);
              if (!Constants.LIST_LANG.contains(langSaved)) {
                langSaved = Constants.EN_CODE;
              }
              textCheckOut = mapLangCheckOut[langSaved];
            } else {
              textCheckOut = appLocalizations.titleCheckOut;
            }
            break;
          }
        case Constants.CONFIGURATION_IMAGES:
          {
            image.clear();
            imageLocalPath.clear();
            countBackground = 0;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              image = element.value;
              if (parent.isConnection && isLoadWelcome) {
                var savedImage = preferences.getString(Constants.KEY_IMAGE_WAITING) ?? "";
                if (savedImage != image.toString()) {
                  preferences.setString(Constants.KEY_IMAGE_WAITING, image.toString());
                  for (var index = 0; index < image.length; index++) {
                    getImage(Constants.FILE_TYPE_IMAGE_WAITING, image[index], index);
                  }
                } else {
                  for (var index = 0; index < image.length; index++) {
                    var fileSaved = await Utilities().getLocalPathFile(Constants.FOLDER_TEMP, Constants.FILE_TYPE_IMAGE_WAITING, index.toString(), null);
                    imageLocalPath.add(fileSaved);
                  }
                  isDoneImage = true;
                }
              } else {
                for (var index = 0; index < image.length; index++) {
                  var fileSaved = await Utilities().getLocalPathFile(Constants.FOLDER_TEMP, Constants.FILE_TYPE_IMAGE_WAITING, index.toString(), null);
                  imageLocalPath.add(fileSaved);
                }
                isDoneImage = true;
              }
            } else {
              isDoneImage = true;
            }
            break;
          }
        case Constants.CONFIGURATION_COMPANY_NAME_COLOR:
          {
            companyNameColor = null;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              companyNameColor =
                  Constants.PREFIX_COLOR + element.value[0].replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
            }
            break;
          }

        case Constants.CONFIGURATION_COMPANY_TEXT_SIZE:
          {
            textSize = 6;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              textSize = int.tryParse(element.value[0]) ?? 6;
            }
            break;
          }

        case Constants.CONFIGURATION_CHECKOUT_BUTTON_BG_COLOR:
          {
            chkOutColor = null;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              chkOutColor =
                  Constants.PREFIX_COLOR + element.value[0].replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
            }
            break;
          }
        case Constants.CONFIGURATION_CHECKIN_BUTTON_TEXT_COLOR:
          {
            chkInTextColor = null;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              chkInTextColor =
                  Constants.PREFIX_COLOR + element.value[0].replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
            }
            break;
          }
        case Constants.CONFIGURATION_CHECKIN_BUTTON_BG_COLOR:
          {
            chkInColor = null;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              chkInColor =
                  Constants.PREFIX_COLOR + element.value[0].replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
            }
            break;
          }
        case Constants.CONFIGURATION_CHECKOUT_BUTTON_TEXT_COLOR:
          {
            chkOutTextColor = null;
            if (element.value != null && element.value.isNotEmpty && element.value[0].isNotEmpty) {
              chkOutTextColor =
                  Constants.PREFIX_COLOR + element.value[0].replaceAll(RegExp("[^0-9a-zA-Z]+"), "").replaceAll('"', "");
            }
            break;
          }
      }
    });
  }

  Future<CancelableOperation<dynamic>> getImage(String type, String path, int index, {String nameFile}) async {
    ApiCallBack callBack = ApiCallBack((Uint8List file, String contentType) async {
      var nameSaved = index.toString();
      if (nameFile != null) {
        nameSaved= nameFile;
      }
      var fileSaved = await Utilities().saveLocalFile(Constants.FOLDER_TEMP, type, nameSaved, null, file);
      if (type == Constants.FILE_TYPE_COMPANY_BUILDING) {
        countSaveCompany++;
        var file = await Utilities().getLocalFile(Constants.FOLDER_TEMP, type, index.toString(), null);
        listCompanyBuilding[index].logoPathLocal = file.path;
        listCompanyBuilding[index].index = index;
        if (countSaveCompany >= listCompanyBuilding.length) {
          isDoneCompany = true;
          if (listCompanyBuilding.length > 0) {
            await db.companyBuildingDAO.deleteAlls();
            await db.companyBuildingDAO.insertAlls(listCompanyBuilding);
          }
        }
      }

      if (type == Constants.FILE_TYPE_LOGO_COMPANY) {
        isDoneLogo = true;
      }
      if (type == Constants.FILE_TYPE_LOGO_SUB_COMPANY) {
        isDoneSubLogo = true;
      }
      if (type == Constants.FILE_TYPE_IMAGE_WAITING) {
        countBackground++;
        if (countBackground == image.length) {
          isDoneImage = true;
        }
        imageLocalPath.add(fileSaved.path);
      }
      if (type == Constants.FILE_TYPE_IMAGE_SAVER) {
        List<String> paths = fileSaved.path.split(Constants.FILE_TYPE_IMAGE_SAVER);
        await db.imageDownloadedDAO.insert(ImageDownloaded(path, paths.last));
        countSaveWaiting++;
        if (countSaveWaiting == configKios.saverModel.images.length) {
          isDoneConfig = true;
        }
      }
      handlerDone();
    }, (Errors message) async {
      if (type == Constants.FILE_TYPE_IMAGE_SAVER) {
        countSaveWaiting++;
        if (countSaveWaiting == configKios.saverModel.images.length) {
          isDoneConfig = true;
        }
      }
      if (type == Constants.FILE_TYPE_LOGO_COMPANY) {
        isDoneLogo = true;
      }
      if (type == Constants.FILE_TYPE_LOGO_SUB_COMPANY) {
        isDoneSubLogo = true;
      }
      if (type == Constants.FILE_TYPE_IMAGE_WAITING) {
        countBackground++;
        if (countBackground == image.length) {
          isDoneImage = true;
        }
      }
      if (type == Constants.FILE_TYPE_COMPANY_BUILDING) {
        try {
          final byteData = await rootBundle.load('assets/images/temp_company.png');
          var path = await Utilities().getLocalPathFile(Constants.FOLDER_TEMP, type, index.toString(), null);
          await Utilities().writeToFile(byteData, path);

          listCompanyBuilding[index].logoPathLocal = path;
          listCompanyBuilding[index].index = index;
          countSaveCompany++;
          if (countSaveCompany >= listCompanyBuilding.length) {
            isDoneCompany = true;
            if (listCompanyBuilding.length > 0) {
              await db.companyBuildingDAO.deleteAlls();
              await db.companyBuildingDAO.insertAlls(listCompanyBuilding);
            }
          }
        } catch (e) {
          countSaveCompany++;
          if (countSaveCompany >= listCompanyBuilding.length) {
            isDoneCompany = true;
            if (listCompanyBuilding.length > 0) {
              await db.companyBuildingDAO.deleteAlls();
              await db.companyBuildingDAO.insertAlls(listCompanyBuilding);
            }
          }
        }
      }
      handlerDone();
    });

    return ApiRequest().requestImage(context, path, callBack);
  }

  Future<void> handlerDone() async {
    if (checkIsDone()) {
      isLoading = false;
      isHaveDelivery = false;
      listType = await db.visitorTypeDAO.getAlls();
      VisitorType tempItem;
      await Future.forEach(listType, (VisitorType element) async {
        if (element.settingKey == TypeVisitor.DELIVERY) {
          isHaveDelivery = true;
          tempItem = element;
        }
      });
      if (tempItem != null) listType.remove(tempItem);
      isHaveEvent = preferences.getBool(Constants.FUNCTION_EVENT) ?? false;
      isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
      getList();
      if (touchlessExpired < 0) {
        isExpired = false;
      } else {
        var now = DateTime.now().millisecondsSinceEpoch / 1000;
        var remain = touchlessExpired - now;
        if (remain <= 0) {
          isExpired = true;
        } else {
          isExpired = false;
          timerExpiredTouchless?.cancel();
          timerExpiredTouchless = Timer(Duration(seconds: remain.round()), () {
            isExpired = true;
            notifyListeners();
          });
        }
      }
      notifyListeners();
      kickWhenBack(isCancel: false);
    }
  }

  Future reloadWaiting({isReloadAll: false}) async {
    memCache = AsyncMemoizer();
    image.clear();
    imageLocalPath.clear();
    preferences.setBool(Constants.KEY_FIRST_START, isReloadAll);
    preferences.setBool(Constants.KEY_LOAD_WELCOME, true);
    await getConfiguration();
  }

  Future kickBySignalR(String title, String content) async {
    if (!isNext) {
      isLoading = true;
      notifyListeners();
      await doLogout();
      Utilities().showNoButtonDialog(context, false, DialogType.INFO, Constants.AUTO_HIDE_LESS, title, content, null);
      isLoading = false;
    } else {
      var kickModel = KickModel(title, content);
      preferences.setString(Constants.KEY_IS_KICK, jsonEncode(kickModel.toJson()));
    }
  }

  void runClock() {
    timerClock?.cancel();
    timerClock = Timer.periodic(Duration(minutes: 1), (Timer t) {
      Utilities().isConnectInternet(isChangeState: true);
      notifyListeners();
      if (isEventMode) {
        if (!isEventTicket) {
          if (utilities.checkExpiredEvent(isEventMode, eventDetail)) {
            isEventMode = false;
            utilities.actionAfterExpired(context, () => reloadWaiting());
          }
        } else {
          if (utilities.checkExpiredEventTicket(isEventMode, eventTicket)) {
            isEventMode = false;
            utilities.actionAfterExpired(context, () => reloadWaiting());
          }
        }
      }
      if (t.tick != 0 && ((t.tick % 10) == 0) && parent.isConnection) {
        updateStatus(Constants.STATUS_ONLINE);
      }
      if (isHaveQRAlready && isHaveQRError) {
        getQRCreate(context);
      }
    });
  }

  void updateClock() {
    notifyListeners();
  }

  Future<void> updateLang(String lang) async {
    if (currentLang == lang) {
      return;
    }
    if (!Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    await appLocalizations.load(Locale(lang));
    textWaiting = appLocalizations.translate(AppString.MESSAGE_TOUCH_START);
    currentLang = lang;
    preferences.setString(Constants.KEY_LANGUAGE, lang);
    var userInfor = await Utilities().getUserInfor();
    companyName = (mapLangName != null) ? mapLangName[lang] ?? userInfor.companyInfo.name : userInfor.companyInfo.name;
    textCheckIn = (mapLangCheckIn != null)
        ? mapLangCheckIn[lang] ?? appLocalizations.titleCheckIn
        : appLocalizations.titleCheckIn;
    textCheckOut = (mapLangCheckOut != null)
        ? mapLangCheckOut[lang] ?? appLocalizations.titleCheckOut
        : appLocalizations.titleCheckOut;
    getList();
    notifyListeners();
  }

  Future<void> moveToSetting(GlobalKey<FormState> passwordKey, RoundedLoadingButtonController btnController) async {
    touchScreen();
    if (passwordKey == null || passwordKey.currentState.validate()) {
      isNext = true;
      btnController.stop();
      navigationService.navigatePop(context);
      navigationService.navigateTo(SettingScreen.route_name, 1).then((value) async {
        await kickWhenBack(isCancel: false);
        isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
        eventTicketId = preferences.getDouble(Constants.KEY_EVENT_TICKET_ID);
        eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
        if (eventTicketId != null) {
          eventTicket = await db.eventTicketDAO.getEventTicketById(eventTicketId);
        }
        if (value == true) {
          isDoneFlows = false;
          isDoneConfig = false;
          isDoneSurvey = false;
          await reloadWaiting();
          await getFlowOnline();
          await getConfigKios();
          await getSurvey();
        } else if (touchlessLink.isNotEmpty) {
          if (isEventMode) {
            type = BackgroundType.WAITING_NEW;
          } else {
            type = BackgroundType.TOUCH_LESS;
          }
          await reloadWaiting();
        }
        notifyListeners();
//        if (isEventMode) {
//          navigationService.navigateTo<WaitingNotifier>(ScanQRScreen.route_name, 1).then((value) async {
//            await kickWhenBack();
//          });
//        }
      });
    } else {
      btnController.stop();
    }
  }

  Future<void> doLogout() async {
    var authorization = await Utilities().getAuthorization();
    var refreshToken = (authorization as Authenticate).refreshToken;
    var deviceInfor = await Utilities().getDeviceInfo();
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    ApiRequest().requestUpdateStatus(context, Constants.STATUS_OFFLINE, null);
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
//      await locator<SignalRService>().stopSignalR();
      await handlerLogout();
    }, (Errors message) async {
//      await locator<SignalRService>().stopSignalR();
      if (message.code != -2) {
        await handlerLogout();
      }
    });

    cancelableOperation =
        await ApiRequest().requestLogout(context, deviceInfor.identifier, refreshToken, firebase, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  void getDataFromQR() {
    try {
      FormatQRCode formatQRCode = FormatQRCode.fromJson(jsonDecode(qrCodeStr));
      switch (formatQRCode.type) {
        case FormatQRCode.CHECK_OUT_PHONE:
          {
            if (parent.isConnection) {
              searchOnline(formatQRCode.data, null);
            } else {
              searchOffline(formatQRCode.data);
            }
            break;
          }
        case FormatQRCode.CHECK_OUT_ID:
          {
            searchOnline(null, formatQRCode.data);
            break;
          }
        default:
          {
            validateEventOnl(formatQRCode.data, null);
          }
      }
    } catch (e) {
      errorJob(appLocalizations.invalidQR);
    }
  }

  void errorJob(String message) {
    _dissmissPopupWaiting();
    Utilities().showErrorPopNo(context, message, Constants.AUTO_HIDE_LESS, callbackDismiss: () {
      resumeScan();
    });
  }

  Future<bool> searchOffline(String phone) async {
    var dateCheckOut = DateTime.now().toUtc().millisecondsSinceEpoch;
    var result = await db.visitorLogDAO.checkExistCheckOut(phone, dateCheckOut);
    if (result is VisitorLog) {
      var userInfor = await Utilities().getUserInfor();
//      var visitorDetail = await db.visitorCheckInDAO.getByPhoneNumber(phone, userInfor.companyInfo.id);
      checkOutOffline(result);
      return true;
    } else if (result is String) {
      Errors errors;
      if (result == "GEN_DataNotFound") {
        errors = Errors(0, appLocalizations.noData, DialogType.ERROR);
      } else {
        errors = Errors(0, appLocalizations.noVisitor, DialogType.ERROR);
      }
      errorJob(errors.description);
      return false;
    }
  }

  Future checkOutOffline(VisitorLog visitorLog) async {
    visitorLog.rating = 5;
    visitorLog.feedback = "";
    var dateCheckOut = DateTime.now().toUtc().millisecondsSinceEpoch;
    await db.visitorLogDAO.insertVistorLogSignOut(visitorLog, dateCheckOut);
//    if (isSyncNow) {
//      locator<SyncService>().syncSingleLog(context, visitorLog.privateKey);
//    }
    _dissmissPopupWaiting();
    Utilities().showNoButtonDialog(
        context, true, DialogType.SUCCES, Constants.AUTO_HIDE_LESS, appLocalizations.successTitle, null, () {
      resumeScan();
    });
  }

  Future searchOnline(String phone, String idCard) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var visitorDetail = VisitorCheckIn.fromJson(baseResponse.data);
      checkOutOnline(visitorDetail);
    }, (Errors message) async {
      if (message.code < 0) {
        if (message.code != -2) {
          var mess = message.description;
          if (message.description.contains("field_name")) {
            mess = message.description.replaceAll("field_name", appLocalizations.inviteCode);
          }
          errorJob(mess);
        } else {
          _dissmissPopupWaiting();
          resumeScan();
        }
      } else {
        var errorText = message.description;
        if (message.description == appLocalizations.noData) {
          errorText = appLocalizations.noPhone;
        }
        errorJob(errorText);
      }
    });

    cancelableOperation = await ApiRequest().requestSearchVisitorCheckOut(context, phone, idCard, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future checkOutOnline(VisitorCheckIn visitorCheckIn) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      _dissmissPopupWaiting();
      moveToTouchless(visitorCheckIn, "", "", HomeNextScreen.FEED_BACK);
    }, (Errors message) async {
      if (message.code != -2) {
        errorJob(message.description);
      } else {
        _dissmissPopupWaiting();
        resumeScan();
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var signOutBy = userInfor?.deviceInfo?.id ?? 0;
    var branchId = userInfor?.deviceInfo?.branchId ?? 0;
    await ApiRequest().requestCheckOut(context, visitorCheckIn.id, "", 5, signOutBy, branchId, callBack);
  }

  Future validateEventOnl(String inviteCode, String phoneNumber) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      var validate = ValidateEvent.fromJson(baseResponse.data);
      var visitorCheckIn = validate.visitor;
      if (validate.status == Constants.VALIDATE_IN) {
        var isCapture = await Utilities().checkIsCapture(context, visitorCheckIn.visitorType);
        if (isCapture) {
          moveToTouchless(visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.FACE_CAP);
        } else {
          actionEventMode(inviteCode, phoneNumber);
        }
      } else if (validate.status == Constants.VALIDATE_OUT) {
        checkOutEvent(visitorCheckIn, inviteCode, phoneNumber);
      }
    }, (Errors message) async {
      if (message.code != -2) {
        var content;
        if (message.description == appLocalizations.errorInviteCode) {
          if (inviteCode != null) {
            content = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.inviteCode);
          } else {
            content = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.phoneNumber);
          }
        } else {
          content = message.description;
        }
        errorJob(content);
      } else {
        _dissmissPopupWaiting();
        resumeScan();
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var companyId = userInfor.companyInfo.id ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest()
        .requestValidateActionEvent(context, companyId, locationId, inviteCode, phoneNumber, eventId, callBack);
    await cancelEvent.valueOrCancellation();
  }

  void resumeScan() {
    this.isScanned = false;
    this.qrCodeStr = '';
  }

  Future actionEventMode(
    String inviteCode,
    String phoneNumber,
  ) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      visitorCheckIn = VisitorCheckIn.fromJson(baseResponse.data);
      notifyListeners();
      var isPrint = await Utilities().checkIsPrint(context, visitorCheckIn?.visitorType);
      if (isPrint) {
        changeMessagePopup(appLocalizations.waitPrinter);
        visitorType = await Utilities().getTypeInDb(context, visitorCheckIn.visitorType);
        await Future.delayed(new Duration(milliseconds: 500));
        printTemplate(visitorCheckIn, isPrint, inviteCode);
      } else {
        isDoneAnyWay = true;
        moveToTouchless(visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.THANK_YOU);
      }
    }, (Errors message) async {
      var contentError = message.description;
      if (message.description.contains("field_name")) {
        contentError = appLocalizations.errorInviteCode.replaceAll("field_name", appLocalizations.inviteCode);
      }
      if (message.code != -2) {
        errorJob(contentError);
      } else {
        _dissmissPopupWaiting();
        resumeScan();
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var locationId = userInfor.deviceInfo.branchId ?? 0;
    var eventId = preferences.getDouble(Constants.KEY_EVENT_ID);
    cancelEvent = await ApiRequest()
        .requestActionEvent(context, locationId, inviteCode, phoneNumber, null, null, eventId, null, null, callBack);
    await cancelEvent.valueOrCancellation();
  }

  Future checkOutEvent(VisitorCheckIn visitorCheckIn, String inviteCode, String phoneNumber) async {
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      Timer(Duration(milliseconds: Constants.DONE_BUTTON_LOADING), () {
        moveToTouchless(visitorCheckIn, inviteCode, phoneNumber, HomeNextScreen.FEED_BACK);
      });
    }, (Errors message) async {
      if (message.code != -2) {
        errorJob(message.description);
      } else {
        _dissmissPopupWaiting();
        resumeScan();
      }
    });
    var userInfor = await Utilities().getUserInfor();
    var signOutBy = userInfor?.deviceInfo?.id ?? 0;
    await ApiRequest().requestCheckOutEvent(context, inviteCode, phoneNumber, "", -1, signOutBy, branchId, callBack);
  }

  Future<void> printTemplate(VisitorCheckIn visitorCheckIn, bool isPrint, String inviteCode) async {
    timerDoneAnyWay = Timer(Duration(seconds: Constants.TIMEOUT_PRINTER), () {
      if (!isDoneAnyWay) {
        isDoneAnyWay = true;
        moveToTouchless(visitorCheckIn, inviteCode, null, HomeNextScreen.THANK_YOU);
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
          moveToTouchless(visitorCheckIn, inviteCode, null, HomeNextScreen.THANK_YOU);
        }
      }
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      Utilities().printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        isDoneAnyWay = true;
        moveToTouchless(visitorCheckIn, inviteCode, null, HomeNextScreen.THANK_YOU);
      }
    } catch (e) {
      response = "Failed to Invoke: '${e.toString()}'.";
      Utilities().printLog("$response ");
      if (!isDoneAnyWay) {
        timerDoneAnyWay?.cancel();
        isDoneAnyWay = true;
        moveToTouchless(visitorCheckIn, inviteCode, null, HomeNextScreen.THANK_YOU);
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

  Future handlerLogout() async {
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
    var savedIdentifier = preferences.getString(Constants.KEY_IDENTIFIER) ?? "";
    var savedCompanyId = preferences.getDouble(Constants.KEY_COMPANY_ID);
    var user = preferences.getString(Constants.KEY_USER) ?? "";
    var domain = preferences.getString(Constants.KEY_DOMAIN) ?? "";
    preferences.clear();
    preferences.setString(Constants.KEY_LANGUAGE, langSaved);
    preferences.setBool(Constants.KEY_IS_LAUNCH, false);
    preferences.setInt(Constants.KEY_DEV_MODE, index);
    preferences.setString(Constants.KEY_FIREBASE_TOKEN, firebase);
    preferences.setString(Constants.KEY_IDENTIFIER, savedIdentifier);
    preferences.setDouble(Constants.KEY_COMPANY_ID, savedCompanyId);
    preferences.setString(Constants.KEY_USER, user);
    preferences.setString(Constants.KEY_DOMAIN, domain);
    navigationService.navigateTo(DomainScreen.route_name, 3);
    Utilities().cancelWaiting();
  }

  @override
  void dispose() {
    assetsAudioPlayer?.dispose();
    timerReset?.cancel();
    timerReloadQR?.cancel();
    timerSignalR?.cancel();
    timerExpiredTouchless?.cancel();
    timerClock?.cancel();
    cancelableOperation?.cancel();
    cancelEvent?.cancel();
    super.dispose();
  }
}
