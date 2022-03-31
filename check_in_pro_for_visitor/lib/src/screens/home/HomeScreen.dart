import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/screens/home/HomeScreenNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String route_name = '/home';

  @override
  Widget build(BuildContext context) {
    Utilities().printLog("build HomeScreen......................................");
    SizeConfig().init(context);
    var provider = Provider.of<HomeScreenNotifier>(context, listen: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? SizeConfig.safeBlockHorizontal * 30 : SizeConfig.safeBlockVertical * 30;
    provider.db = Provider.of<Database>(context, listen: false);
    return FutureBuilder<bool>(
        future: provider.getDefaultLang(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var isHaveDelivery = provider.arguments["isHaveDelivery"] as bool ?? false;
            return Background(
                isRestoreLang: provider.isRestoreLang,
                isShowBack: true,
                isShowLogo: true,
                isShowClock: true,
                isShowChatBox: !isHaveDelivery,
                type: BackgroundType.MAIN,
                contentChat: AppLocalizations.of(context).translate(AppString.MESSAGE_CHECK_INOUT_CHATBOX),
                child: WrapSuper(
                  spacing: 120.0,
                  lineSpacing: 30.0,
                  alignment: WrapSuperAlignment.center,
                  children: <Widget>[
                    activityContainer(
                        context,
                        percentBox,
                        AppLocalizations.of(context).titleCheckIn,
                        'assets/images/checkin.png',
                        () => provider.moveToNextScreen(context, HomeNextScreen.CHECK_IN, false)),
                    activityContainer(
                        context,
                        percentBox,
                        AppLocalizations.of(context).titleCheckOut,
                        'assets/images/checkout.png',
                        () => provider.moveToNextScreen(context, HomeNextScreen.CHECK_OUT, false)),
                    activityContainer(
                        context,
                        percentBox,
                        AppLocalizations.of(context).titleScanQR,
                        'assets/images/scanQR.png',
                        () => provider.moveToNextScreen(context, HomeNextScreen.SCAN_QR, false)),
                    if (isHaveDelivery)
                      activityContainer(
                          context,
                          percentBox,
                          AppLocalizations.of(context).titleDelivery,
                          'assets/images/delivery.png',
                          () => provider.moveToNextScreen(context, HomeNextScreen.CHECK_IN, true))
                  ],
                ));
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

  Widget activityContainer(BuildContext context, double sizeBox, String text, String path, Function onClick) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var textInBox = isPortrait ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockVertical * 4;
    var container = GestureDetector(
      onTap: onClick,
      child: Container(
        width: sizeBox,
        height: sizeBox,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 40, bottom: 20),
                      child: Image.asset(
                        path,
                        cacheWidth: 35 * SizeConfig.devicePixelRatio,
                        cacheHeight: 41 * SizeConfig.devicePixelRatio,
                      )),
                ),
                flex: 2),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 40), child: Text(text, style: TextStyle(fontSize: textInBox))),
                flex: 1)
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
    return container;
  }
}
