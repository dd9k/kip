import 'dart:async';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/companyBuilding/CompanyBuildScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';

import '../../../main.dart';

class HomeScreenNotifier extends ChangeNotifier {
  VisitorCheckIn visitor;
  var isRestoreLang = false;
  Database db;
  var arguments;

  Future<void> moveToNextScreen(BuildContext context, HomeNextScreen type, bool isDelivery) async {
    var isScanIdCard;
    var listType = await db.visitorTypeDAO.getAlls();
    if (listType == null || listType.isEmpty) {
      isScanIdCard = false;
    } else {
      isScanIdCard = await Utilities().checkIsScanId(context, listType[0].settingKey);
    }
    var isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));
    switch (type) {
      case HomeNextScreen.CHECK_IN:
        {
          if (isBuilding) {
            locator<NavigationService>()
                .navigateTo(CompanyBuildingScreen.route_name, 1, arguments: {'isDelivery': isDelivery});
          } else if (isScanIdCard && !isDelivery) {
            locator<NavigationService>().navigateTo(ScanVisionScreen.route_name, 1,
                arguments: {'visitor': VisitorCheckIn.inital(), 'isCheckIn': true, 'isDelivery': isDelivery});
          } else {
            locator<NavigationService>().navigateTo(InputPhoneScreen.route_name, 1,
                arguments: {'visitor': VisitorCheckIn.inital(), 'isDelivery': isDelivery});
          }
          break;
        }
      case HomeNextScreen.CHECK_OUT:
        {
          if (isScanIdCard) {
            locator<NavigationService>().navigateTo(ScanVisionScreen.route_name, 1,
                arguments: {'visitor': VisitorCheckIn.inital(), 'isCheckIn': false, 'isDelivery': isDelivery});
          } else {
            locator<NavigationService>()
                .navigateTo(CheckOutScreen.route_name, 1, arguments: {'isDelivery': isDelivery});
          }
          break;
        }
      case HomeNextScreen.SCAN_QR:
        {
          locator<NavigationService>().navigateTo(ScanQRScreen.route_name, 1);
          break;
        }
      default:
        {
          break;
        }
    }
  }

  Future<bool> getDefaultLang(BuildContext context) async {
    arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    if (arguments != null) {
      isRestoreLang = arguments["isRestoreLang"] as bool ?? false;
      if (isRestoreLang) {
        await Utilities().getDefaultLang(context);
      }
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
