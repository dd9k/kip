
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingNotifier.dart';
import 'package:check_in_pro_for_visitor/src/services/ConnectionStatusSingleton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/DotWidget.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ImageScannerAnimation.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ProcessWaiting.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../constants/SizeConfig.dart';

class WaitingScreen extends MainScreen {
  static const String route_name = '/waitingPage';

  @override
  WaitingScreenState createState() => WaitingScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class WaitingScreenState extends MainScreenState<WaitingNotifier>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AnimationController _animationController;
  bool isPause = false;
  bool isInit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

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
    ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) {
      if (!result) {
        provider.isConnection = false;
      } else if (!provider.isConnection && !isPause) {
        provider.isConnection = true;
        provider.refreshToken(_scaffoldKey.currentContext);
      }
    });
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    animateScanAnimation(false);
    var percentBox = isPortrait ? 70 : 50;
    var waitingText = isPortrait ? widthScreen * 6 : heightScreen * 6;
//    provider.doneJobAnyWay(context);
    return Selector<WaitingNotifier, bool>(
      key: _scaffoldKey,
      builder: (context, data, child) => FutureBuilder<void>(
        future: provider.getConfiguration(),
        builder: (context, snapshot) {
          if (provider.checkIsDone()) {
            if (!isInit) {
              isInit = true;
              provider.firebaseCloudMessaging_Listeners();
            }
            provider.runClock();
            var badgeTemplate = provider.preferences.getString(Constants.KEY_BADGE_PRINTER);
            return Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.transparent,
                  body: RepaintBoundary(
                      key: provider.repaintBoundary,
                      child: Container(
                        height: AppDestination.CARD_HEIGHT,
                        width: AppDestination.CARD_WIGHT,
                        color: Colors.white,
                        child: new Center(child: cardTemplate(badgeTemplate)),
                      )),
                ),
                Background(
                  isShowBack: false,
                  isShowLogout: true,
                  type: provider.type,
                  isShowLogo: true,
                  isUseProvider: true,
                  isShowFloatingButton: provider.isShowFAB,
                  provider: provider,
                  messSnapBar: appLocalizations.messOffline,
                  child: (provider.type == BackgroundType.WAITING_NEW)
                      ? buildNewWaiting(percentBox, _scaffoldKey.currentContext)
                      : buildTouchLess(percentBox, waitingText, _scaffoldKey.currentContext),
                ),
                _buildProcessWaiting()
              ],
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      selector: (buildContext, provider) => provider.isLoading,
    );
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowFAB = !visible;
  }

  Widget cardTemplate(String badgeIndex) {
    return Selector<WaitingNotifier, VisitorCheckIn>(
      builder: (context, data, child) => TemplatePrint(
        visitorName: provider.visitorCheckIn?.fullName ?? "",
        phoneNumber: provider.visitorCheckIn?.phoneNumber ?? "",
        fromCompany: provider.visitorCheckIn?.fromCompany ?? "",
        toCompany: provider.visitorCheckIn?.toCompany ?? "",
        visitorType: provider.visitorType,
        idCard: provider.visitorCheckIn?.idCard ?? "",
        indexTemplate: badgeIndex,
        printerModel: provider.printer,
        inviteCode: provider.visitorCheckIn?.inviteCode ?? "",
        isBuilding: provider.isBuilding,
        floor: provider.visitorCheckIn?.floor ?? "",
      ),
      selector: (buildContext, provider) => provider.visitorCheckIn,
    );
  }

  Widget buildTouchLess(int percentBox, double waitingText, BuildContext context) {
    var sizeQR = isPortrait ? heightScreen * 20 : widthScreen * 20;
    var sizeTitle = isPortrait ? heightScreen * 2.5 : widthScreen * 2.5;
    var sizeMainTitle = isPortrait ? heightScreen * 3 : widthScreen * 3;
    var sizeSubTitle = isPortrait ? heightScreen * 2 : widthScreen * 2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: isPortrait ? sizeQR / 4 : 0,
        ),
        Selector<WaitingNotifier, String>(
          builder: (context, data, child) {
            return RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: appLocalizations.titleTouchless0,
                    style: TextStyle(
                      fontSize: sizeMainTitle,
                      height: 2,
                      color: AppColor.MAIN_TEXT_COLOR,
                      fontFamily: Styles.Montserrat,
                    )),
                TextSpan(
                    text: appLocalizations.titleTouchless1,
                    style: TextStyle(
                      fontSize: sizeMainTitle,
                      height: 2,
                      color: AppColor.MAIN_TEXT_COLOR,
                      fontWeight: FontWeight.bold,
                      fontFamily: Styles.Montserrat,
                    )),
                TextSpan(
                    text: appLocalizations.titleTouchless2,
                    style: TextStyle(
                      fontSize: sizeMainTitle,
                      height: 2,
                      color: AppColor.MAIN_TEXT_COLOR,
                      fontFamily: Styles.Montserrat,
                    ))
              ],
            ));
          },
          selector: (buildContext, provider) => provider.textWaiting,
        ),
        SizedBox(
          height: sizeQR / 4,
        ),
        isPortrait
            ? Column(
                children: <Widget>[
                  buildQR(sizeTitle, sizeSubTitle, sizeQR),
                  buildSpace(),
//            SizedBox(
//              child: isPortrait ? Divider(height: 1, thickness: 1, color: AppColor.LINE_COLOR) : VerticalDivider(width: 1, thickness: 1, color: AppColor.LINE_COLOR),
//              width: isPortrait ? sizeQR : 0,
//              height: isPortrait ? 0 : sizeQR,
//            ),
                  buildSpace(),
                  buildScan(sizeTitle, sizeSubTitle, sizeQR)
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildQR(sizeTitle, sizeSubTitle, sizeQR),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
//            SizedBox(
//              child: isPortrait ? Divider(height: 1, thickness: 1, color: AppColor.LINE_COLOR) : VerticalDivider(width: 1, thickness: 1, color: AppColor.LINE_COLOR),
//              width: isPortrait ? sizeQR : 0,
//              height: isPortrait ? 0 : sizeQR,
//            ),
                  buildScan(sizeTitle, sizeSubTitle, sizeQR)
                ],
              ),
        SizedBox(
          height: 50,
        ),
        DotWidget(
          dashColor: AppColor.MAIN_TEXT_COLOR,
          dashHeight: 2,
          dashWidth: 10,
          totalWidth: 100,
        ),
        SizedBox(
          height: 20,
        ),
        buildAction(sizeTitle),
      ],
    );
  }

  Container buildSpace() {
    return Container(
      width: isPortrait ? 0 : widthScreen * 9.5,
      height: isPortrait ? heightScreen * 6.5 : 0,
    );
  }

  Widget buildAction(double sizeTitle) {
    provider.getList();
    return Selector<WaitingNotifier, String>(
      builder: (context, data, child) {
        return Selector<WaitingNotifier, bool>(
          builder: (context, data, child) {
            return Wrap(
              direction: Axis.horizontal,
              children: provider.items.map((item) {
                return RaisedButton(
                  onPressed: item.action,
                  color: Colors.transparent,
                  elevation: 0,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        item.imageString,
                        color: AppColor.MAIN_TEXT_COLOR,
                        scale: 1.75,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        item.title,
                        style: TextStyle(fontSize: sizeTitle, color: AppColor.MAIN_TEXT_COLOR),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          selector: (buildContext, provider) => provider.isHaveDelivery,
        );
      },
      selector: (buildContext, provider) => provider.textWaiting,
    );
  }

  Widget buildQR(double sizeTitle, double sizeSubTitle, double sizeQR) {
    var content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
                      borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                  child: QrImage(
                    size: sizeQR,
                    data: provider.touchlessLink ?? "",
                  ),
                ),
                Selector<WaitingNotifier, bool>(
                  builder: (context, visible, child) {
                    return Visibility(
                      visible: visible,
                      child: Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Selector<WaitingNotifier, String>(
                              builder: (context, data, child) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColor.RED_COLOR,
                                      border: Border.all(color: AppColor.RED_COLOR, width: 1),
                                      borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                                  child: Text(
                                    appLocalizations.touchlessExpired,
                                    style: TextStyle(color: Colors.white, fontSize: sizeSubTitle),
                                  ),
                                );
                              },
                              selector: (buildContext, provider) => provider.textWaiting,
                            )),
                      ),
                    );
                  },
                  selector: (buildContext, provider) => provider.isExpired,
                )
              ],
            ),
            if (!isPortrait)
              Container(
//                color: Colors.red,
                width: 100,
                height: sizeQR / 4,
              ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Selector<WaitingNotifier, String>(
              builder: (context, data, child) {
                return Text(
                  appLocalizations.titleQRTouchLess,
                  style: TextStyle(fontSize: sizeTitle, color: Colors.black, fontWeight: FontWeight.bold),
                );
              },
              selector: (buildContext, provider) => provider.textWaiting,
            ),
            SizedBox(
              height: 5,
            ),
            Selector<WaitingNotifier, String>(
              builder: (context, data, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(appLocalizations.subTitleQRTouchLess0,
                        style: TextStyle(
                          fontSize: sizeSubTitle,
                          color: Colors.black,
                        )),
//                    SizedBox(
//                      width: sizeQR,
//                      child: AutoSizeText(provider.touchlessLink ?? "",
//                          minFontSize: 9,
//                          style: TextStyle(
//                            fontSize: sizeSubTitle - 2,
//                            color: Colors.black,
//                            fontWeight: FontWeight.bold,
//                          )),
//                    ),
//                    Text(appLocalizations.subTitleQRTouchLess1,
//                        style: TextStyle(
//                          fontSize: sizeSubTitle,
//                          color: Colors.black,
//                        ))
                  ],
                );
              },
              selector: (buildContext, provider) => provider.textWaiting,
            ),
          ],
        ),
      ],
    );
    return isPortrait
        ? Container(
            padding: EdgeInsets.only(left: AppDestination.PADDING_WAITING_HORIZONTAL),
            width: widthScreen * 100,
            child: content)
        : Container(padding: EdgeInsets.only(left: AppDestination.PADDING_WAITING_HORIZONTAL), child: content);
  }

  Widget buildScan(double sizeTitle, double sizeSubTitle, double sizeQR) {
    var content = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Selector<WaitingNotifier, String>(
              builder: (context, data, child) {
                return Text(
                  appLocalizations.titleScanTouchLess,
                  style: TextStyle(fontSize: sizeTitle, color: Colors.black, fontWeight: FontWeight.bold),
                );
              },
              selector: (buildContext, provider) => provider.textWaiting,
            ),
            SizedBox(
              height: 5,
            ),
            Selector<WaitingNotifier, String>(
              builder: (context, data, child) {
                return Text(
                  appLocalizations.subTitleScanTouchLess,
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: sizeSubTitle),
                );
              },
              selector: (buildContext, provider) => provider.textWaiting,
            ),
          ],
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          children: [
            if (!isPortrait)
              Container(
//                color: Colors.red,
                width: 100,
                height: sizeQR / 4,
              ),
            SizedBox(
              width: sizeQR,
              height: sizeQR,
              child: Stack(alignment: Alignment.center, children: [
                AspectRatio(
                  aspectRatio: 1.0,
                  child: Selector<WaitingNotifier, bool>(
                    builder: (context, data, child) {
                      return data
                          ? QRView(
                              key: provider.qrKey,
                              onQRViewCreated: _onQRViewCreated,
                              overlay: QrScannerOverlayShape(
                                borderColor: Colors.lightBlue,
                                borderRadius: 10,
                                borderLength: 40,
                                borderWidth: 10,
                                cutOutSize: sizeQR / 1.25,
                              ),
                            )
                          : Container(
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  appLocalizations.loadingCamera,
                                  style:
                                      TextStyle(color: AppColor.HINT_TEXT_COLOR, fontSize: AppDestination.TEXT_NORMAL),
                                ),
                              ),
                            );
                    },
                    selector: (buildContext, provider) => provider.isLoadCamera,
                  ),
                ),
                ImageScannerAnimation(
                  false,
                  334,
                  animation: _animationController,
                )
              ]),
            ),
          ],
        ),
      ],
    );
    return isPortrait
        ? Container(
            padding: EdgeInsets.only(right: AppDestination.PADDING_WAITING_HORIZONTAL),
            width: widthScreen * 100,
//            color: Colors.red,
            alignment: Alignment.centerRight,
            child: content)
        : Container(padding: EdgeInsets.only(right: AppDestination.PADDING_WAITING_HORIZONTAL), child: content);
  }

  void _onQRViewCreated(QRViewController controller) {
    provider.controller = controller;
    provider.startStream();
  }

  Widget buildNewWaiting(int percentBox, BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var welcomeSize = isPortrait ? widthScreen * provider.textSize : widthScreen * (provider.textSize - 2);
    var companyNameSize = isPortrait ? widthScreen * (provider.textSize + 2) : widthScreen * provider.textSize;
    var btnText = isPortrait ? heightScreen * 3 : widthScreen * 3;

    return Selector<WaitingNotifier, bool>(
      builder: (context, data, child) {
        return Padding(
          padding: EdgeInsets.only(left: 25),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: <Widget>[
              Selector<WaitingNotifier, String>(
                builder: (context, data, child) {
                  var textCheckIn = (provider.textCheckIn?.isNotEmpty == true)
                      ? provider.textCheckIn
                      : appLocalizations.titleCheckIn;
                  var textCheckOut = (provider.textCheckOut?.isNotEmpty == true)
                      ? provider.textCheckOut
                      : appLocalizations.titleCheckOut;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        child: Text(
                          appLocalizations.welcomeText,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: (provider.companyNameColor == null || provider.companyNameColor.isEmpty)
                                  ? AppColor.TEXT_IN_BLUE_NAME
                                  : Color(int.parse(provider.companyNameColor)),
                              fontSize: welcomeSize,
                              fontWeight: FontWeight.w300),
                        ),
                        width: MediaQuery.of(context).size.width - AppDestination.PADDING_WAITING * 2,
                      ),
                      SizedBox(
                        child: Text(provider.companyName,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: companyNameSize,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: (provider.companyNameColor == null || provider.companyNameColor.isEmpty)
                                    ? AppColor.TEXT_IN_BLUE_NAME
                                    : Color(int.parse(provider.companyNameColor)),
                                decoration: TextDecoration.none)),
                        width: MediaQuery.of(context).size.width - AppDestination.PADDING_WAITING * 2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
// SizedBox(
// child:
// Divider(height: 1, thickness: 1, color: AppColor.LINE2_COLOR),
// width: MediaQuery.of(context).size.width - AppDestination.PADDING_WAITING * 2,
// ),
                      SizedBox(
                        height: 10,
                      ),
                      WrapSuper(
                        spacing: 0.0,
                        lineSpacing: 0.0,
                        alignment: WrapSuperAlignment.left,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => provider.moveToNextScreen(HomeNextScreen.CHECK_IN, false),
                            color: Colors.transparent,
                            elevation: 0,
                            padding: const EdgeInsets.all(0.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                            child: buildContentTransMain(
                                context, true, textCheckIn, 'assets/images/checkin.png', 30, 36),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          if (!provider.isEventMode || (provider.isEventMode && !provider.isEventTicket))
                            RaisedButton(
                              onPressed: () => provider.moveToNextScreen(HomeNextScreen.CHECK_OUT, false),
                              color: Colors.transparent,
                              elevation: 0,
                              padding: const EdgeInsets.all(0.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                              child: buildContentTransMain(
                                  context, false, textCheckOut, 'assets/images/checkout.png', 30, 36),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: !provider.isEventMode,
                        child: Wrap(
                          spacing: 0.0,
                          runSpacing: 0.0,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            if (provider.isHaveEvent  && !provider.isBuilding)
                              RaisedButton(
                                onPressed: () => provider.moveToNextScreen(HomeNextScreen.SCAN_QR, false),
                                color: Colors.transparent,
                                elevation: 0,
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                                child: buildContentTrans(context, false, false, appLocalizations.titleScanQR,
                                    'assets/images/scanQR.png', 36, 36),
                              ),
                            Selector<WaitingNotifier, bool>(
                              builder: (context, data, child) {
                                return Visibility(
                                  visible: data,
                                  child: RaisedButton(
                                    onPressed: () => provider.moveToNextScreen(HomeNextScreen.CHECK_IN, true),
                                    color: Colors.transparent,
                                    elevation: 0,
                                    padding: const EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
                                    child: buildContentTrans(context, false, false, appLocalizations.titleDelivery,
                                        'assets/images/delivery.png', 36, 36),
                                  ),
                                );
                              },
                              selector: (buildContext, provider) => provider.isHaveDelivery,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
                selector: (buildContext, provider) => provider.textWaiting,
              ),
            ],
          ),
        );
      },
      selector: (buildContext, provider) => provider.isEventMode,
    );
  }

  Ink buildContentTrans(BuildContext context, bool isMain, bool subLeft, String btnText, String imageString,
      int cacheWidth, int cacheHeight) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var btnTextSize = isPortrait ? heightScreen * 3 : widthScreen * 3;
    double padding = isMain ? widthScreen * 5 : 20.0;
    var provider = Provider.of<WaitingNotifier>(this.context, listen: false);

    var haveColor = provider.companyNameColor != null && provider.companyNameColor.isNotEmpty;
    var haveBackground = provider.backgroundColor != null && provider.backgroundColor.isNotEmpty;

    var colorMainBorder = haveColor ? Color(int.parse(provider.companyNameColor)) : Colors.white;
    var colorMainBg =
        haveColor ? Color(int.parse(provider.companyNameColor)) : (haveBackground ? Colors.white : Colors.transparent);

    var colorTextSub = haveColor ? Color(int.parse(provider.companyNameColor)) : Colors.white;

    var colorTextMain =
        haveBackground ? Color(int.parse(provider.backgroundColor)) : (haveColor ? Colors.white : Colors.white);

    return Ink(
      decoration: BoxDecoration(
          color: isMain ? colorMainBg : Colors.transparent,
          border: Border.all(width: 3.0, color: isMain ? colorMainBorder : Colors.transparent),
          borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
      child: Padding(
        padding: EdgeInsets.only(left: isMain ? padding : 0, right: padding, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: isMain ? MainAxisAlignment.center : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Image.asset(
                  imageString,
                  color: isMain ? colorTextMain : colorTextSub,
                  cacheWidth: cacheWidth * SizeConfig.devicePixelRatio,
                  cacheHeight: cacheHeight * SizeConfig.devicePixelRatio,
                )),
            Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isMain ? colorTextMain : colorTextSub,
                fontFamily: 'Montserrat',
                fontWeight: isMain ? FontWeight.w400 : FontWeight.w300,
                fontSize: btnTextSize,
              ),
            )
          ],
        ),
      ),
    );
  }

  Ink buildContentTransMain(
      BuildContext context, bool subLeft, String btnText, String imageString, int cacheWidth, int cacheHeight) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var btnTextSize = isPortrait ? heightScreen * 3 : widthScreen * 3;
    var btnSize = isPortrait ? heightScreen * 15 : widthScreen * 15;
    double padding = widthScreen * 5;
    var provider = Provider.of<WaitingNotifier>(this.context, listen: false);
    var colorBtnLeft = (provider.chkInColor == null) ? AppColor.MAIN_CHECK_IN : Color(int.parse(provider.chkInColor));
    var colorBtnRight =
        (provider.chkOutColor == null) ? AppColor.MAIN_CHECK_OUT : Color(int.parse(provider.chkOutColor));
    var colorTextLeft = (provider.chkInTextColor == null) ? Colors.white : Color(int.parse(provider.chkInTextColor));
    var colorTextRight = (provider.chkOutTextColor == null) ? Colors.white : Color(int.parse(provider.chkOutTextColor));
    return Ink(
      decoration: BoxDecoration(
          color: subLeft ? colorBtnLeft : colorBtnRight,
          border: Border.all(width: 3.0, color: subLeft ? colorBtnLeft : colorBtnRight),
          borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding, top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 10),
                child: Image.asset(
                  imageString,
                  color: subLeft ? colorTextLeft : colorTextRight,
                  cacheWidth: cacheWidth * SizeConfig.devicePixelRatio,
                  cacheHeight: cacheHeight * SizeConfig.devicePixelRatio,
                )),
            Text(
              btnText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subLeft ? colorTextLeft : colorTextRight,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
                fontSize: btnTextSize,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          provider.utilities.startSaver();
          if (provider.parent.isConnection && isPause) {
//            if (Platform.isIOS) {
//              provider.reloadCamera();
//              provider.updateStatus(Constants.STATUS_ONLINE);
//              if (provider.messageBackground != null) {
//                await provider.handlerMSGFirebase(provider.messageBackground);
//                provider.messageBackground = null;
//              }
//              provider.getQRCreate(context);
//              provider.updateClock();
//            } else {
              await Future.delayed(Duration(milliseconds: 500));
              await provider.refreshToken(_scaffoldKey.currentContext);
//            }
          }
          isPause = false;
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          isPause = true;
          provider.utilities.stopSaver();
          provider.updateStatus(Constants.STATUS_OFFLINE);
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  Widget _buildProcessWaiting() {
    return Selector<WaitingNotifier, bool>(
        builder: (cx, data, child) {
          return Selector<WaitingNotifier, String>(
              builder: (cx, message, child) {
                return ProcessWaiting(
                  message: message,
                  isVisible: data,
                );
              },
              selector: (buildContext, provider) => provider.messagePopup);
        },
        selector: (buildContext, provider) => provider.isProcessing);
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
