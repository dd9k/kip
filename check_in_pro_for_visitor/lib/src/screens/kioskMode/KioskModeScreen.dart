import 'dart:io';

import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/kioskMode/KioskModeNotifier.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KioskModeScreen extends MainScreen {
  static const String route_name = '/kioskMode';

  @override
  _GivePermissionScreenState createState() => _GivePermissionScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _GivePermissionScreenState extends MainScreenState<KioskModeNotifier> {

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _buildPageContain(),
    );
  }

  Widget _buildPageContain() {
    return new Column(
      // This makes each child fill the full width of the screen
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        middleSection(),
        _Footer(context),
      ],
    );
  }

  Widget middleSection() {
    var percentBox = isPortrait ? 40 : 30;
    var lang = provider.arguments["lang"] as String;
    return new Expanded(
      child: new Container(
        padding: new EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Image.asset(
                  (lang == Constants.VN_CODE) ? "assets/images/home_vi.jpg" : "assets/images/home_en.jpg",
                  fit: BoxFit.contain,
                  cacheWidth: 542 * SizeConfig.devicePixelRatio,
                  cacheHeight: 254 * SizeConfig.devicePixelRatio,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      appLocalizations.lockTitle,
                      style: Styles.gpTextBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      appLocalizations.lockSubtitle,
                      style: Styles.gpText,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * percentBox,
                  child: Selector<KioskModeNotifier, bool>(
                    builder: (widget, data, child) => RaisedGradientButton(
                        height: 41.0,
                        disable: data,
                        btnText: AppLocalizations.of(context).lockTitle,
                        onPressed: () {
                          provider.turnOnKioskMode(context);
                        }),
                    selector: (buildContext, provider) => provider.isLoading,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: GestureDetector(
                  child: Text(
                    AppLocalizations.of(context).btnSkip,
                    style: Styles.gpTextItalic,
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => provider.doNextFlow(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Footer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: locator<AppDestination>()
              .getPadding(context, AppDestination.PADDING_SMALL, AppDestination.PADDING_SMALL_HORIZONTAL, true)),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  bottom: 5,
                  right: locator<AppDestination>().getPadding(
                      context, AppDestination.PADDING_SMALL, AppDestination.PADDING_SMALL_HORIZONTAL, false)),
              child: Image.asset(
                'assets/images/logo_unitcorp.png',
                cacheWidth: 46,
                cacheHeight: 46,
                scale: 2,
              ),
            ),
            Text(
              AppLocalizations.of(context).translate(AppString.MESSAGE_BOTTOM_MAIN),
              style: Styles.descCompanyName,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
