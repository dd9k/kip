import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashNotifier.dart';
import 'package:flutter/material.dart';

import '../../constants/SizeConfig.dart';

class SplashScreen extends MainScreen {
  static const String route_name = '/';

  @override
  SplashScreenState createState() => SplashScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class SplashScreenState extends MainScreenState<SplashNotifier> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    provider.countDownToNext(context);
    provider.refreshToken(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/logo_company.png',
          cacheWidth: 456 * SizeConfig.devicePixelRatio,
          cacheHeight: 90 * SizeConfig.devicePixelRatio,
        ),
      ),
    );
  }
}
