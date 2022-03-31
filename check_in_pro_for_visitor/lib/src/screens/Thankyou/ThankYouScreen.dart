import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/image.dart' as WidgetsImages;

class ThankYouScreen extends MainScreen {
  static const String route_name = '/thankyou';

  @override
  ThankYouState createState() => ThankYouState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class ThankYouState extends MainScreenState<ThankYouNotifier> {
  VisitorCheckIn visitor;
  bool isInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      isInit = true;
      provider.countDownToDone(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    visitor = provider.arguments["visitor"] as VisitorCheckIn;
    return GestureDetector(
      onTap: () => provider.moveToWaitingScreen(context),
      child: Background(
        timeOutInit: Constants.DONE_THANK_YOU,
        isShowBack: false,
        isShowClock: true,
        type: BackgroundType.MAIN,
        initState: !provider.parent.isOnlineMode,
        messSnapBar: appLocalizations.messOffMode,
        isShowLogo: true,
        isShowChatBox: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(top: AppDestination.PADDING_SMALL),
                child: Text(
                  "${AppLocalizations.of(context).translate(AppString.TITLE_THANK_YOU)}, ${visitor?.fullName ?? ""}!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 45, height: 1.25),
                ),
              ),
              flex: 11,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppDestination.PADDING_SMALL),
                child: Text(
                  AppLocalizations.of(context).translate(AppString.MESSAGE_THANK_YOU),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              flex: 0,
            ),
            WidgetsImages.Image.asset('assets/images/logo_wait.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.height / 4,
                height: MediaQuery.of(context).size.height / 4),
          ],
        ),
        contentChat: AppLocalizations.of(context).translate(AppString.MESSAGE_THANK_YOU_CHATBOX),
      ),
    );
  }
}
