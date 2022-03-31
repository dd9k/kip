import 'dart:async';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/Constants.dart';
import '../../model/VisitorType.dart';

class CompanyBuildingNotifier extends MainNotifier {
  List<CompanyBuilding> listCompanyBuilding;
  CheckInFlow companyBuildingItem;
  var isCapture = false;
  var isPrint = false;
  var isReloadCompany = false;
  VisitorType visitorType;
  CompanyBuilding companyBuilding;
  bool hideLoading = true;
  Map<String, dynamic> mapLang;
  AsyncMemoizer<List<CompanyBuilding>> memCacheCompany = AsyncMemoizer();
  bool isShowLogo = true;
  GlobalKey<FormState> formKey = new GlobalKey();
  FocusNode currentNodes;
  List<GlobalKey<FormState>> keyList = List();
  String initValueBuilding;
  bool isHaveCompany = false;


  Widget _searchBar;

  var number = 0;

  get createSearchBar => _searchBar;

  CancelableOperation cancelCheckIn;
  CancelableOperation cancellableOperation;

  bool isShowForChatBox(BuildContext context) {
    var heightScreen = SizeConfig.safeBlockVertical;
    var heightCheckIn = number * (Constants.HEIGHT_BUTTON + 20);
    if (heightCheckIn <= heightScreen * 80) return isShowLogo;
    return false;
  }

  Future<void> moveToNextScreen(BuildContext context, CompanyBuilding companyBuilding) async {
    var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var isDelivery = (arguments["isDelivery"] as bool) ?? false;
    var isScanIdCard;
    var listType = await db.visitorTypeDAO.getAlls();
    if (listType == null || listType.isEmpty) {
      isScanIdCard = false;
    } else {
      isScanIdCard = await Utilities().checkIsScanId(context, listType[0].settingKey);
    }
    var visitor = VisitorCheckIn.inital();
    visitor.toCompany = companyBuilding.companyName;
    visitor.toCompanyId = companyBuilding.id;
    visitor.contactPersonId = companyBuilding.representativeId;
    visitor.floor = companyBuilding.floor;
    if (isScanIdCard && !isDelivery && (listType == null || listType.length < 2)) {
      locator<NavigationService>().navigateTo(ScanVisionScreen.route_name, 1, arguments: {
        'isCheckIn': true,
        'isDelivery': isDelivery,
        'companyBuilding': companyBuilding,
        'visitor': visitor
      });
    } else {
      locator<NavigationService>().navigateTo(InputPhoneScreen.route_name, 1,
          arguments: {'isDelivery': isDelivery, 'companyBuilding': companyBuilding, 'visitor': visitor});
    }
  }

  Future<void> searchCompany(String query) async {
    memCacheCompany = AsyncMemoizer();
    await getCompanySearch(query);
    isReloadCompany = !isReloadCompany;
    notifyListeners();
  }

  Future<List<CompanyBuilding>> getCompanySearch(String query) async {
    return memCacheCompany.runOnce(() async {
      utilities.moveToWaiting();
      if (query == null || query.isEmpty) {
        return await db.companyBuildingDAO.getAlls();
      }
      return await db.companyBuildingDAO.getDataByCompanyName(query);
    });
  }

  @override
  void dispose() {
    currentNodes?.dispose();
    cancellableOperation?.cancel();
    super.dispose();
  }
}
