import 'dart:io';
import 'dart:math';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Style.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Loading.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import 'ReviewCheckInNotifier.dart';

class ReviewCheckInScreen extends MainScreen {
  static const String route_name = '/reviewCheckInScreen';

  @override
  _ReviewCheckInScreenState createState() => _ReviewCheckInScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _ReviewCheckInScreenState extends MainScreenState<ReviewCheckInNotifier> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    Utilities().printLog('build ReviewCheckInScreen............................');
    var visitor = provider.arguments["visitor"] as VisitorCheckIn;
    var inviteCode = provider.arguments["inviteCode"] as String;
    provider.isScanId = (provider.arguments["isScanId"] as bool) ?? false;
    SizeConfig().init(context);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var blockSizeHorizontal = SizeConfig.blockSizeHorizontal;
    var horizontalBtn = isPortrait ? blockSizeHorizontal * 45 : blockSizeHorizontal * 40;
    var widthCard = isPortrait ? blockSizeHorizontal * 75 : blockSizeHorizontal * 53;
    if (!provider.isInit) {
      provider.countDownToCheckIn(context);
    }
    return FutureBuilder<SharedPreferences>(
      future: provider.getType(context, visitor.visitorType),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          var badgeTemplate = snapshot.data.getString(Constants.KEY_BADGE_PRINTER);
          var border = BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
          );
          var borderScan = BorderRadius.only(
            bottomRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(0.0),
          );
          if (provider.isCapture || provider.isScanId) {
            border = BorderRadius.only(
              bottomRight: Radius.circular(20.0),
            );
          }
          if (!provider.isCapture) {
            borderScan = BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
            );
          }
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
              Loading(
                visible: provider.isLoading,
                child: Background(
                  timeOutInit: Constants.DONE_CHECK_IN,
                  isShowBack: false,
                  isShowStepper: true,
                  isShowLogo: true,
                  isShowChatBox: false,
                  initState: !provider.parent.isOnlineMode,
                  messSnapBar: AppLocalizations.of(context).messOffMode,
                  isShowClock: true,
                  contentChat: AppLocalizations.of(context).reviewMessage,
                  type: BackgroundType.MAIN,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColor.HINT_TEXT_COLOR,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Container(
                              width: widthCard,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Stack(
                                          children: <Widget>[
                                            Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: locator<AppDestination>().getPadding(
                                                            context,
                                                            AppDestination.PADDING_NORMAL,
                                                            AppDestination.PADDING_NORMAL_HORIZONTAL,
                                                            true)),
                                                    child: _buildPicturePreview(
                                                        150, provider.isCapture ? visitor.imagePath : null))),
                                          ],
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                buildRowMain(AppLocalizations.of(context).fullNameText,
                                                    visitor.fullName, context),
                                                buildRowSub(
                                                    AppLocalizations.of(context).idCardText, visitor.idCard, context),
                                                buildRowSub(AppLocalizations.of(context).phoneText, visitor.phoneNumber,
                                                    context),
                                                buildRowSub(AppLocalizations.of(context).birthDayText, visitor.birthDay,
                                                    context),
                                                buildRowSub(AppLocalizations.of(context).permanentAddressText,
                                                    visitor.permanentAddress, context),
                                                buildRowSub(AppLocalizations.of(context).fromText, visitor.fromCompany,
                                                    context),
                                                buildRowSub(
                                                    AppLocalizations.of(context).toText, visitor.toCompany, context),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      if (provider.isCapture)
                                        Selector<ReviewCheckInNotifier, bool>(
                                          builder: (context, data, child) => Expanded(
                                            flex: 1,
                                            child: AbsorbPointer(
                                              absorbing: data,
                                              child: Container(
                                                height: 55.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey[200],
                                                    width: 1.0,
                                                  ),
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(20.0),
                                                  ),
                                                ),
                                                child: InkWell(
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(20.0),
                                                  ),
                                                  onTap: () {
                                                    provider.moveToNext(context, HomeNextScreen.FACE_CAP, visitor);
                                                  },
                                                  child: Center(
                                                    child: new Text(AppLocalizations.of(context).takeNewPicture,
                                                        style: data
                                                            ? Style.instance.styleTextDisable16
                                                            : Style.instance.styleTextBlackBold16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          selector: (buildContext, provider) => provider.isDisable,
                                        ),
                                      if (provider.isScanId)
                                        Selector<ReviewCheckInNotifier, bool>(
                                          builder: (context, data, child) => Expanded(
                                            flex: 1,
                                            child: AbsorbPointer(
                                              absorbing: data,
                                              child: Container(
                                                height: 55.0,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey[200],
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: InkWell(
                                                  borderRadius: borderScan,
                                                  onTap: () {
                                                    provider.moveToNext(context, HomeNextScreen.SCAN_ID, visitor);
                                                  },
                                                  child: Center(
                                                    child: new Text(AppLocalizations.of(context).scanIdAgain,
                                                        style: data
                                                            ? Style.instance.styleTextDisable16
                                                            : Style.instance.styleTextBlackBold16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          selector: (buildContext, provider) => provider.isDisable,
                                        ),
//                                Expanded(flex: 1, child: RaisedButton( color: Colors.transparent,child: Text("Take new picture"), onPressed: () =>
//                                    provider.moveToNext(
//                                        context,
//                                        HomeNextScreen
//                                            .FACE_CAP,
//                                        visitor),),),
                                      Selector<ReviewCheckInNotifier, bool>(
                                        builder: (context, data, child) => Expanded(
                                          flex: 1,
                                          child: AbsorbPointer(
                                            absorbing: data,
                                            child: Container(
                                              height: 55.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey[200],
                                                  width: 1.0,
                                                ),
                                                borderRadius: border,
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.only(
                                                  bottomRight: Radius.circular(20.0),
                                                ),
                                                onTap: () {
                                                  provider.moveToNext(context, HomeNextScreen.CHECK_IN, visitor);
                                                },
                                                child: Center(
                                                  child: Text(AppLocalizations.of(context).editDetails,
                                                      style: data
                                                          ? Style.instance.styleTextDisable16
                                                          : Style.instance.styleTextBlackBold16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        selector: (buildContext, provider) => provider.isDisable,
                                      ),
//                                Expanded(flex: 1, child: RaisedButton(child: Text("Edit detail"), onPressed: () => provider.moveToNext(
//                                    context,
//                                    HomeNextScreen.CHECK_IN,
//                                    visitor),),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: locator<AppDestination>().getPadding(context, AppDestination.PADDING_BIGGER,
                                AppDestination.PADDING_BIGGER_HORIZONTAL, true)),
                        width: horizontalBtn,
                        child: RaisedGradientButton(
                          isLoading: true,
                          disable: false,
                          btnController: provider.btnController,
                          btnText: AppLocalizations.of(context).btnCheckIn,
                          onPressed: () {
                            provider.disableButton();
                            provider.timerNext?.cancel();
                            provider.checkIn(this.context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Selector<ReviewCheckInNotifier, bool>(
                        builder: (widget, data, child) => Visibility(
                          visible: provider.isShowPrinter,
                          child: Text(AppLocalizations.of(context).waitPrinter,
                              style: TextStyle(
                                fontSize: AppDestination.TEXT_NORMAL,
                              )),
                        ),
                        selector: (buildContext, provider) => provider.isShowPrinter,
                      ),
//                      SizedBox(
//                        height: 2 * Constants.HEIGHT_BUTTON,
//                      ),
                    ],
                  ),
                ),
              ),
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

  Widget buildRowSub(String title, String value, BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var blockSizeHorizontal = SizeConfig.blockSizeHorizontal;
    var widthText = (isPortrait ? blockSizeHorizontal * 75 : blockSizeHorizontal * 53) - 170;
    return Visibility(
      visible: (value != null && value.isNotEmpty),
      child: Container(
        padding: EdgeInsets.only(
            bottom: locator<AppDestination>()
                .getPadding(context, AppDestination.PADDING_NORMAL, AppDestination.PADDING_NORMAL_HORIZONTAL, true)),
        child: SizedBox(
          width: widthText,
          child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: "$title:",
                      style: TextStyle(fontSize: AppDestination.TEXT_NORMAL, color: AppColor.BLACK_TEXT_COLOR)),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: value,
                      style: TextStyle(fontSize: AppDestination.TEXT_NORMAL, color: AppColor.MAIN_TEXT_COLOR)),
                ],
              )),
        ),
      ),
    );
  }

  Widget buildRowMain(String title, String value, BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var blockSizeHorizontal = SizeConfig.blockSizeHorizontal;
    var widthText = (isPortrait ? blockSizeHorizontal * 75 : blockSizeHorizontal * 53) - 170;
    return Visibility(
      visible: (value != null && value.isNotEmpty),
      child: Container(
        padding: EdgeInsets.only(
            bottom: locator<AppDestination>()
                .getPadding(context, AppDestination.PADDING_NORMAL, AppDestination.PADDING_NORMAL_HORIZONTAL, true)),
        child: SizedBox(
          width: widthText,
          child: RichText(
              maxLines: 2,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: '$title:',
                      style: TextStyle(fontSize: AppDestination.TEXT_NORMAL, color: AppColor.BLACK_TEXT_COLOR)),
                  TextSpan(text: ' '),
                  TextSpan(
                      text: value,
                      style: TextStyle(
                          fontSize: locator<AppDestination>().getTextBigger(context),
                          fontFamily: 'Helvetica',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none)),
                ],
              )),
        ),
      ),
    );
  }

  Widget cardTemplate(String badgeIndex) {
    var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var visitor = arguments["visitor"] as VisitorCheckIn;
    var inviteCode = arguments["inviteCode"] as String;
    var provider = Provider.of<ReviewCheckInNotifier>(context, listen: false);
    return TemplatePrint(
      visitorName: visitor.fullName ?? "",
      phoneNumber: visitor.phoneNumber ?? "",
      fromCompany: visitor.fromCompany ?? "",
      toCompany: visitor.toCompany ?? "",
      visitorType: provider.visitorType ?? "",
      indexTemplate: badgeIndex,
      idCard: visitor.idCard ?? "",
      printerModel: provider.printer,
      inviteCode: inviteCode,
      isBuilding: provider.isBuilding,
      floor: visitor.floor,
    );
  }

  Widget _buildPicturePreview(double size, String path) {
    return buildCircleLayout(
        size,
        Container(
          width: size,
          height: size,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: (path != null)
                ? Image.file(
                    File(path),
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/default_avatar.png",
                  ),
          ), // this is my CameraPreview
        ));
  }

  Widget buildCircleLayout(double size, Widget child) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.HINT_TEXT_COLOR, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(360.0) //         <--- border radius here
              ),
          color: Colors.transparent,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(360.0)),
          child: OverflowBox(
            alignment: Alignment.center,
            child: child,
          ),
        ));
  }
}
