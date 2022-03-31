import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/companyBuilding/CompanyBuildScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/home/HomeScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const List<String> timeOutRoute = [
    CheckOutScreen.route_name,
    CompanyBuildingScreen.route_name,
    ContactScreen.route_name,
    HomeScreen.route_name,
    InputInformationScreen.route_name,
    InputPhoneScreen.route_name,
    ReviewCheckInScreen.route_name,
    ScanQRScreen.route_name,
    ScanVisionScreen.route_name,
    SurveyScreen.route_name,
    TakePhotoScreen.route_name
  ];

  Future<dynamic> navigateTo<T extends ChangeNotifier>(String routeName, int type, {Object arguments}) {
    if (routeName == WaitingScreen.route_name) {
      Utilities().clearStep();
      Utilities().cancelWaiting();
    } else if (timeOutRoute.contains(routeName)) {
      Utilities().moveToWaiting();
      Utilities().cancelMoveToSaver();
    } else {
      Utilities().cancelWaiting();
      Utilities().cancelMoveToSaver();
    }
    Utilities().nextStep();
    switch (type) {
      case 1:
        {
          return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
        }
      case 2:
        {
          return navigatorKey.currentState.pushReplacementNamed(routeName, arguments: arguments);
        }
      case 3:
        {
          return navigatorKey.currentState
              .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false, arguments: arguments);
        }
    }
    return navigatorKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil<T extends ChangeNotifier>(String routeName, String endRoute,
      {Object arguments}) {
    if (routeName == WaitingScreen.route_name) {
      Utilities().clearStep();
      Utilities().cancelWaiting();
    } else if (timeOutRoute.contains(routeName)) {
      Utilities().moveToWaiting();
    } else {
      Utilities().cancelWaiting();
    }
    Utilities().nextStep();
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(endRoute), arguments: arguments);
  }

  void navigatePop(BuildContext context, {Object arguments}) {
    String currentRoute = ModalRoute.of(context).settings.name;
    if (timeOutRoute.contains(currentRoute)) {
      Utilities().moveToWaiting();
    } else {
      Utilities().cancelWaiting();
    }
    Utilities().previousStep();
    return navigatorKey.currentState.pop(arguments);
  }
}
