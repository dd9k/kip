import 'dart:async';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/home/HomeScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThankYouNotifier extends MainNotifier {
  Timer timerNext;

  Future<void> moveToWaitingScreen(BuildContext context) async {
    timerNext?.cancel();
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    if (isEventMode) {
      locator<NavigationService>()
          .pushNamedAndRemoveUntil(ScanQRScreen.route_name, WaitingScreen.route_name, arguments: {
        'isRestoreLang': true,
        'isCheckOut' : arguments["isCheckOut"]
      });
    } else {
      locator<NavigationService>().navigateTo(WaitingScreen.route_name, 3);
    }
  }

  void countDownToDone(BuildContext context) {
    timerNext?.cancel();
    timerNext = Timer(Duration(seconds: Constants.DONE_THANK_YOU), () {
      moveToWaitingScreen(context);
    });
  }

  @override
  void dispose() {
    timerNext?.cancel();
    super.dispose();
  }
}
