
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/CovidModel.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CovidScreen extends MainScreen {
  static const String route_name = '/CovidScreen';

  @override
  _CovidScreenState createState() => _CovidScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _CovidScreenState extends MainScreenState<CovidNotifier> {
  InAppWebViewController webView;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    provider.countDownToDone(context);

    return FutureBuilder<CovidModel>(
      future: provider.getConfig(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          CovidModel covidModel = snapshot.data;
          var badgeTemplate = provider.preferences.getString(Constants.KEY_BADGE_PRINTER);
            return Stack(
              children: <Widget>[
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
                Selector<CovidNotifier, bool>(
                  builder: (context, data, child) => Background(
                      isShowBack: false,
                      isShowLogo: false,
                      isShowChatBox: false,
                      enableScroll: false,
                      isShowClock: true,
                      isOpeningKeyboard: provider.isOpeningKeyboard,
                      timeOutInit: 120,
                      type: BackgroundType.MAIN,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: buildBody(data, covidModel),
                            ),
                            buildRowBtn(context),
                            SizedBox(
                              height: Constants.HEIGHT_BUTTON,
                            )
                          ],
                        ),
                      )),
                  selector: (buildContext, provider) => provider.isUsePhone,
                )
              ],
            );
        }
        return Background(
          isShowBack: true,
          isShowLogo: false,
          isShowChatBox: false,
          type: BackgroundType.MAIN,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget cardTemplate(String badgeIndex) {
    return TemplatePrint(
      visitorName: provider.visitor.fullName ?? "",
      phoneNumber: provider.visitor.phoneNumber ?? "",
      fromCompany: provider.visitor.fromCompany ?? "",
      toCompany: provider.visitor.toCompany ?? "",
      visitorType: provider.visitorType,
      idCard: provider.visitor.idCard ?? "",
      indexTemplate: badgeIndex,
      printerModel: provider.printer,
      inviteCode: provider.inviteCode,
      badgeTemplate: null,
      isBuilding: provider.isBuilding,
      floor: provider.visitor.floor,
    );
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isOpeningKeyboard = visible;
  }

  List<Widget> buildBody(bool isUsePhone, CovidModel covidModel) {
    if (isUsePhone || covidModel.url == null || covidModel.url.isEmpty) {
      return buildFormQR(covidModel);
    }
    return buildWebView(covidModel);
  }

  List<Widget> buildFormQR(CovidModel covidModel) {
    return <Widget>[
      if (covidModel?.title?.isNotEmpty == true)
        Padding(
          padding: EdgeInsets.only(top: 50, bottom: 10, left: 20, right: 20),
          child: Text(
            covidModel?.title?.toUpperCase() ?? AppLocalizations.of(context).titleNotification,
            style: TextStyle(fontSize: 36, color: provider.colorTitle),
            textAlign: TextAlign.center,
          ),
        ),
      if (covidModel?.description?.isNotEmpty == true)
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            covidModel.description.replaceAll("/n", " "),
            style: Styles.fbSubTitle,
            textAlign: TextAlign.justify,
          ),
        ),
      buildQR(covidModel.url),
    ];
  }

  List<Widget> buildWebView(CovidModel covidModel) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var height = isPortrait ? SizeConfig.safeBlockVertical * 80 : SizeConfig.safeBlockVertical * 75;
    var width = isPortrait ? SizeConfig.safeBlockHorizontal * 80 : SizeConfig.safeBlockHorizontal * 85;
    return <Widget>[
      SizedBox(
        height: Constants.HEIGHT_BUTTON,
      ),
      Container(
        height: height,
        width: width,
        color: AppColor.MAIN_TEXT_COLOR,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height),
            child: InAppWebView(
              initialUrl: covidModel.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: false,
                    useShouldOverrideUrlLoading: true,
                  ),
                  android: AndroidInAppWebViewOptions()),
              onWebViewCreated: (InAppWebViewController controller) {
//                Utilities().printLog("onWebViewCreated");
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
//                Utilities().printLog("onLoadStart ${url}");
              },
              gestureRecognizers: Set()
                ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
              shouldOverrideUrlLoading: (controller, shouldOverrideUrlLoadingRequest) async {
                return ShouldOverrideUrlLoadingAction.ALLOW;
              },
              onLoadStop: (InAppWebViewController controller, String url) async {
//                Utilities().printLog("onLoadStop ${url}");
//                if (url.endsWith("/formResponse")) {
//                  provider.moveToNextPage(context);
//                }
              },
//              onProgressChanged: (InAppWebViewController controller, int progress) {
//                Utilities().printLog("onProgressChanged ${progress.toString()}");
//              },
//              onUpdateVisitedHistory: (InAppWebViewController controller, String url, bool androidIsReload) {
//                Utilities().printLog("onUpdateVisitedHistory ${url}");
//              },
//              onConsoleMessage: (controller, consoleMessage) {
//                Utilities().printLog("onConsoleMessage ${consoleMessage.message}");
//              },
//              onLoadResource: (_,a){
//                Utilities().printLog("onLoadResource ${a.url}");
//              },
              onScrollChanged: (_, x, y) {
              },
            )),
      )
    ];
  }

  Widget buildQR(String url) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var size = isPortrait ? SizeConfig.safeBlockVertical * 20 : SizeConfig.safeBlockHorizontal * 20;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: QrImage(
        size: size,
        data: url,
      ),
    );
  }

  Widget buildRowBtn(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 30 : 25;
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          width: SizeConfig.blockSizeHorizontal * percentBox,
          child: RaisedGradientButton(
            disable: false,
            styleEmpty: true,
            btnText:
                provider.isUsePhone ? AppLocalizations.of(context).useKiosk : AppLocalizations.of(context).useMobile,
            onPressed: () {
              provider.countDownToDone(context);
              provider.updateForm();
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          padding: EdgeInsets.only(top: 20),
          width: SizeConfig.blockSizeHorizontal * percentBox,
          child: RaisedGradientButton(
            disable: false,
            isLoading: (provider.isQRScan && !provider.isCapture),
            btnController: provider.btnController,
            btnText: AppLocalizations.of(context).translate(AppString.BTN_CONTINUE),
            onPressed: () {
              provider.moveToNextPage(context);
            },
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
