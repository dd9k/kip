import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ImageScannerAnimation.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends MainScreen {
  static const String route_name = '/scanQR';

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _ScanQRScreenState extends MainScreenState<ScanQRNotifier> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController controllerText = TextEditingController();
  GlobalKey<FormState> inputKey = GlobalKey();
  AnimationController _animationController;
  bool _animationStopped = false;
  bool scanning = false;
  FocusNode phoneFocusNode = FocusNode();
  bool isPause = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_animationController == null) {
      _animationController =
          new AnimationController(duration: new Duration(seconds: Constants.TIME_ANIMATION_SCAN), vsync: this);

      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animateScanAnimation(true);
        } else if (status == AnimationStatus.dismissed) {
          animateScanAnimation(false);
        }
      });
    }
    controllerText.addListener(() {
      provider.qrCodeStr = controllerText.text;
    });
    phoneFocusNode.addListener(() {
      provider.showClear(phoneFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    animateScanAnimation(false);
    return FutureBuilder<bool>(
        future: provider.getDefaultLang(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Selector<ScanQRNotifier, VisitorCheckIn>(
                    builder: (context, data, child) {
                      var badgeTemplate = provider.preferences.getString(Constants.KEY_BADGE_PRINTER);
                      return Scaffold(
                        backgroundColor: Colors.transparent,
                        body: RepaintBoundary(
                            key: provider.repaintBoundary,
                            child: Container(
                              height: AppDestination.CARD_HEIGHT,
                              width: AppDestination.CARD_WIGHT,
                              color: Colors.white,
                              child: Center(child: cardTemplate(badgeTemplate)),
                            )),
                      );
                    },
                    selector: (buildContext, provider) => provider.visitorDetail),
                Background(
                  isShowBack: true,
                  isAnimation: true,
                  isRestoreLang: provider.isRestoreLang,
                  isShowLogo: provider.isShowLogo,
                  isOpeningKeyboard: !provider.isShowLogo,
                  isShowChatBox: provider.isShowLogo,
                  isShowClock: true,
                  messSnapBar: appLocalizations.messOffline,
                  contentChat: appLocalizations.messageQRCodeOrPhoneNumber,
                  type: BackgroundType.MAIN,
                  isShowNext: (provider.eventId != null && provider.isEventMode && !provider.isEventTicket),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(flex: 2, child: Container()),
                        Flexible(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.only(right: 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Selector<ScanQRNotifier, String>(
                                    builder: (context, data, child) {
                                      return Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: buildForm(context, data),
                                      );
                                    },
                                    selector: (buildContext, provider) => provider.qrCodeStr,
                                  ),
                                  _buildBtnNext(context),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Selector<ScanQRNotifier, bool>(
                                    builder: (widget, data, child) => Visibility(
                                      visible: provider.isShowPrinter,
                                      child: Text(appLocalizations.waitPrinter,
                                          style: TextStyle(
                                            fontSize: AppDestination.TEXT_NORMAL,
                                          )),
                                    ),
                                    selector: (buildContext, provider) => provider.isShowPrinter,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  if (provider.isEventMode && provider.eventId != null && !provider.isCheckOut && !provider.isEventTicket)
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.only(right: 5, left: 5),
                                        child: Text(appLocalizations.noEventCode,
                                            style: TextStyle(
                                                fontSize: AppDestination.TEXT_BIG,
                                                color: Color(0xff0359D4),
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic)),
                                      ),
                                      onTap: () {
                                        provider.moveToNextScreen(context, null, null, null, HomeNextScreen.CHECK_IN);
                                      },
                                    )
                                ],
                              ),
                            )),
                        Flexible(
                          flex: 4,
                          child: Stack(alignment: Alignment.center, children: [
                            AspectRatio(
                              aspectRatio: 1.0,
                              child: Selector<ScanQRNotifier, bool>(
                                builder: (context, visible, child) {
                                  return visible ? QRView(
                                    key: provider.qrKey,
                                    onQRViewCreated: _onQRViewCreated,
                                    overlay: QrScannerOverlayShape(
                                      borderColor: Colors.lightBlue,
                                      borderRadius: 10,
                                      borderLength: 40,
                                      borderWidth: 10,
                                      cutOutSize: 200,
                                    ),
                                  ) : Container(
                                    color: Colors.black,
                                    child: Center(
                                      child: Text(
                                        appLocalizations.loadingCamera,
                                        style: TextStyle(color: AppColor.HINT_TEXT_COLOR, fontSize: AppDestination.TEXT_NORMAL),
                                      ),
                                    ),
                                  );
                                },
                                selector: (buildContext, provider) => provider.isLoadCamera,
                              ),
                            ),
                            ImageScannerAnimation(
                              _animationStopped,
                              334,
                              animation: _animationController,
                            )
                          ]),
                        ),
                        Flexible(flex: 2, child: Container(color: Colors.black,)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Background(
              isShowBack: true,
              isShowLogo: false,
              isShowChatBox: false,
              type: BackgroundType.MAIN,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowLogo = !visible;
  }

  Widget cardTemplate(String badgeIndex) {
    return Selector<ScanQRNotifier, VisitorCheckIn>(
      builder: (context, data, child) => TemplatePrint(
        visitorName: provider.visitorDetail?.fullName ?? "",
        phoneNumber: provider.visitorDetail?.phoneNumber ?? "",
        fromCompany: provider.visitorDetail?.fromCompany ?? "",
        toCompany: provider.visitorDetail?.toCompany ?? "",
        visitorType: provider.visitorType,
        idCard: provider.visitorDetail?.idCard ?? "",
        indexTemplate: badgeIndex,
        printerModel: provider.printer,
        inviteCode: provider.visitorDetail?.inviteCode ?? controllerText.text,
        badgeTemplate: provider.eventDetail?.getBadgeTemplate(provider.langSaved),
        isBuilding: provider.isBuilding,
        floor: provider.visitorDetail.floor,
      ),
      selector: (buildContext, provider) => provider.visitorDetail,
    );
  }

  Form buildForm(BuildContext context, String data) {
    return Form(
      key: inputKey,
      child: Selector<ScanQRNotifier, bool>(
          builder: (context, isShowClear, child) => TextFormField(
              validator: (provider.isEventTicket && provider.isEventMode) ? Validator(context).validateQR : Validator(context).validateQROrPhoneNumber,
              controller: controllerText..text = data,
              focusNode: phoneFocusNode,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                suffixIcon: isShowClear
                    ? GestureDetector(
                        onTap: () {
                          controllerText.clear();
                          provider.qrCodeStr = '';
                        },
                        child: Container(
                          height: 56,
                          width: 56,
                          child: Icon(
                            Icons.cancel,
                            size: 24,
                            color: AppColor.HINT_TEXT_COLOR,
                          ),
                        ),
                      )
                    : null,
                labelText:
                    (provider.isEventTicket && provider.isEventMode) ? appLocalizations.inviteCode : appLocalizations.qrOrPhoneNumber,
              ),
              onChanged: (_) => Utilities().moveToWaiting(),
              onEditingComplete: () {
                Utilities().hideKeyBoard(context);
                if (inputKey.currentState.validate()) {
                  provider.btnController.start();
                } else {
                  provider.btnController.stop();
                }
              },
              style: Styles.formFieldText),
          selector: (buildContext, provider) => provider.isShowClear),
    );
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  Widget _buildBtnNext(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: RaisedGradientButton(
        isLoading: true,
        btnController: provider.btnController,
        disable: provider.isLoading,
        btnText: appLocalizations.translate(AppString.BTN_CONTINUE),
        onPressed: () {
          Utilities().hideKeyBoard(context);
          provider.qrCodeStr = controllerText.text;
          if (inputKey.currentState.validate()) {
            String patternQR = ".*[a-zA-Z].*";
            RegExp regExpQR = new RegExp(patternQR);
            if (regExpQR.hasMatch(controllerText.text)) {
              provider.validate(controllerText.text, null, this.context);
            } else {
              provider.validate(null, controllerText.text, this.context);
            }
          } else {
            provider.btnController.stop();
            provider.isScanned = false;
            provider.qrCodeStr = "";
          }
        },
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          if (isPause) {
            isPause = false;
            provider.reloadCamera();
          }
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          isPause = true;
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    provider?.timerDoneAnyWay?.cancel();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    provider.controller = controller;
    provider.startStream(context);
  }
}
