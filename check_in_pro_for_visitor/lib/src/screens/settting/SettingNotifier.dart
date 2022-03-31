import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/Authenticate.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detailSetting/advanced/AdvancedPage.dart';
import 'detailSetting/camera/CameraPage.dart';
import 'detailSetting/location/LocationPage.dart';
import 'detailSetting/print/PrinterPage.dart';

class SettingNotifier extends MainNotifier {
  CancelableOperation cancelableOperation;
  bool isLoadingData = false;
  bool isSwitch = false;
  bool isClickEvent = false;
  bool isOpeningKeyboard = false;
  List<ItemSetting> items = List();
  AsyncMemoizer<void> memCache = AsyncMemoizer();

  Future<void> getDefaultValue() async {
    return memCache.runOnce(() async {
      items = <ItemSetting>[
        ItemSetting(
            title: AppLocalizations.of(context).settingLocation,
            widget: LocationPage(),
            icon: Icons.location_city,
            settingType: SettingType.LOCATION,
            isSelect: true),
        ItemSetting(
            title: AppLocalizations.of(context).settingPrint,
            widget: PrinterPage(),
            icon: Icons.print,
            settingType: SettingType.PRINTER,
            isSelect: false),
        ItemSetting(
            title: AppLocalizations.of(context).settingCamera,
            widget: CameraPage(),
            icon: Icons.settings_applications,
            settingType: SettingType.CAMERA,
            isSelect: false),
        ItemSetting(
            title: AppLocalizations.of(context).settingAdvanced,
            widget: AdvancedPage(showHideLoading),
            icon: Icons.event,
            settingType: SettingType.ADVANCED,
            isSelect: false),
        ItemSetting(
            title: AppLocalizations.of(context).settingLogout,
            widget: Container(),
            icon: Icons.directions_run,
            settingType: SettingType.LOGOUT,
            isSelect: false),
        ItemSetting(
            title: AppLocalizations.of(context).settingVersion,
            widget: Container(),
            icon: Icons.info,
            settingType: SettingType.VERSION,
            isSelect: false),
      ];
    });
  }

  Future<void> doLogout(BuildContext context) async {
    var authorization = await Utilities().getAuthorization();
    var refreshToken = (authorization as Authenticate).refreshToken;
    var deviceInfor = await Utilities().getDeviceInfo();
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    ApiRequest().requestUpdateStatus(context, Constants.STATUS_OFFLINE, null);

    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
//      await locator<SignalRService>().stopSignalR();
      await handlerLogout();
    }, (Errors message) async {
//      await locator<SignalRService>().stopSignalR();
      if (message.code != -2) {
        await handlerLogout();
      }
    });

    cancelableOperation =
        await ApiRequest().requestLogout(context, deviceInfor.identifier, refreshToken, firebase, callBack);
    await cancelableOperation.valueOrCancellation();
  }

  Future handlerLogout() async {
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
    var firebase = preferences.getString(Constants.KEY_FIREBASE_TOKEN) ?? "";
    var savedIdentifier = preferences.getString(Constants.KEY_IDENTIFIER) ?? "";
    var savedCompanyId = preferences.getDouble(Constants.KEY_COMPANY_ID);
    var user = preferences.getString(Constants.KEY_USER) ?? "";
    var domain = preferences.getString(Constants.KEY_DOMAIN) ?? "";
    preferences.clear();
    preferences.setString(Constants.KEY_LANGUAGE, langSaved);
    preferences.setString(Constants.KEY_FIREBASE_TOKEN, firebase);
    preferences.setInt(Constants.KEY_DEV_MODE, index);
    preferences.setBool(Constants.KEY_IS_LAUNCH, false);
    preferences.setString(Constants.KEY_IDENTIFIER, savedIdentifier);
    preferences.setDouble(Constants.KEY_COMPANY_ID, savedCompanyId);
    preferences.setString(Constants.KEY_USER, user);
    preferences.setString(Constants.KEY_DOMAIN, domain);
    locator<NavigationService>().navigateTo(DomainScreen.route_name, 3);
    Utilities().cancelWaiting();
  }

  void switchItem(BuildContext context, SettingType selectedType) {
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    var isSync = preferences.getBool(Constants.KEY_SYNC_EVENT) ?? false;
    if (isClickEvent && isEventMode && !isSync) {
      Utilities().showErrorPop(context, appLocalizations.needSyncEvent, null, null);
    } else {
      if (selectedType == SettingType.LOGOUT) {
        Utilities().showTwoButtonDialog(
            context,
            DialogType.WARNING,
            null,
            AppLocalizations.of(context).translate(AppString.TITLE_NOTIFICATION),
            AppLocalizations.of(context).logoutTitle,
            AppLocalizations.of(context).translate(AppString.BUTTON_NO),
            AppLocalizations.of(context).translate(AppString.BUTTON_YES),
                () {}, () {
          doLogout(context);
        });
        return;
      }
      items.forEach((element) {
        if (element.settingType == selectedType) {
          element.isSelect = true;
        } else {
          element.isSelect = false;
        }
      });
      isSwitch = !isSwitch;
      if (selectedType == SettingType.ADVANCED) {
        isClickEvent = true;
      }
      notifyListeners();
    }
  }

  ItemSetting getItemSelect() {
    return items.firstWhere((element) => element.isSelect);
  }

  void showHideLoading(bool isShowLoading) {
    this.isLoadingData = isShowLoading;
    notifyListeners();
  }
}
