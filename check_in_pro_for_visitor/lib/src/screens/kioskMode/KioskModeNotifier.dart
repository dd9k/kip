import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:flutter/material.dart';

class KioskModeNotifier extends MainNotifier {
  bool isLoading = false;

  Future<void> turnOnKioskMode(BuildContext context) async {
    if (await utilities.isLauncher()) {
      await utilities.setKioskMode(true);
    } else {
      preferences.setBool(Constants.KEY_ON_LOCK, true);
      await utilities.goHome();
    }
    doNextFlow();
  }

  Future doNextFlow() async {
    navigationService.navigateTo(DomainScreen.route_name, 3);
  }
}
