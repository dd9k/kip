import 'dart:io';

import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/givePermission/GivePermissionNotifier.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';

class GivePermissionScreen extends MainScreen {
  static const String route_name = '/givePermission';

  @override
  _GivePermissionScreenState createState() => _GivePermissionScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _GivePermissionScreenState extends MainScreenState<GivePermissionNotifier> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: _buildPageContain(),
    );
  }

  Widget _buildPageContain() {
    return FutureBuilder<void>(
        future: provider.getDefaultValue(context),
        builder: (widget, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              // This makes each child fill the full width of the screen
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                middleSection(),
                _Footer(context),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget middleSection() {
    var percentBox = isPortrait ? 40 : 30;
    var title = (Platform.isAndroid)
        ? appLocalizations.permissionTitleAndroid
        : appLocalizations.permissionTitleIOS;
    var subTitle = (Platform.isAndroid)
        ? appLocalizations.permissionSubtitleAndroid
        : appLocalizations.permissionSubtitleIOS;
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
                  "assets/images/access_camera.png",
                  fit: BoxFit.contain,
                  cacheWidth: 388 * SizeConfig.devicePixelRatio,
                  cacheHeight: 291 * SizeConfig.devicePixelRatio,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      style: Styles.gpTextBold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      subTitle,
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
                  child: Selector<GivePermissionNotifier, bool>(
                    builder: (widget, data, child) => RaisedGradientButton(
                        height: 41.0,
                        disable: data,
                        btnText: appLocalizations.translate(AppString.BTN_GIVE_CAMERA_PERMISSION),
                        onPressed: () {
                          provider.acquiredPermission();
                        }),
                    selector: (buildContext, provider) => provider.isLoading,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: GestureDetector(
                  child: Text(
                    appLocalizations.btnSkip,
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
              appLocalizations.translate(AppString.MESSAGE_BOTTOM_MAIN),
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
