import 'dart:io';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/kioskMode/KioskModeScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/PermissionCallBack.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../MainNotifier.dart';

class GivePermissionNotifier extends MainNotifier {
  bool isLoading = false;
  String lang;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> acquiredPermission() async {
    isLoading = true;
    notifyListeners();
    if (Platform.isIOS) {
      await iOS_Permission(context);
    } else {
      await platformPermission(context, true);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> firebaseCloudMessaging_Listeners() async {
    await _firebaseMessaging.getToken().then((token) async {
      preferences.setString(Constants.KEY_FIREBASE_TOKEN, token);
      Utilities().printLog("firebaseId: $token");
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
  }

  Future<void> iOS_Permission(BuildContext context) async {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) async {
      await platformPermission(context, settings.alert);
    });
  }

  Future platformPermission(BuildContext context, bool iOSPermission) async {
    var permissionCallBack = PermissionCallBack(() async {
      doNextFlow();
    }, () {}, () {});
    List<PermissionGroup> permissions = List();
    if (Platform.isAndroid) {
      permissions = Constants.PERMISSION_LIST_ANDROID;
    } else {
      permissions = Constants.PERMISSION_LIST_IOS;
    }
    await Utilities.requestPermission(context, permissions, permissionCallBack, false, iOSPermission);
  }

  Future doNextFlow() async {
    if (Platform.isAndroid) {
      navigationService.navigateTo(KioskModeScreen.route_name, 3, arguments: {
        "lang": lang
      });
    } else {
      navigationService.navigateTo(DomainScreen.route_name, 3);
    }
    preferences.setBool(Constants.KEY_IS_LAUNCH, false);
  }

  Future<void> getDefaultValue(BuildContext context) async {
    var isConnection = await Utilities().isConnectInternet(isChangeState: false);
    if (isConnection) {
      await firebaseCloudMessaging_Listeners();
    } else {
      showNoInternet();
    }
    lang = preferences.getString(Constants.KEY_LANGUAGE);
    if (lang == null) {
      Locale myLocale = Localizations.localeOf(context);
      lang = myLocale.languageCode;
    }
    if (lang.isEmpty || !Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    preferences.setString(Constants.KEY_LANGUAGE, lang);
    await AppLocalizations.of(context).load(Locale(lang));
  }

  void showNoInternet() {
    Utilities().showOneButtonDialog(
        context,
        DialogType.ERROR,
        null,
        appLocalizations.translate(AppString.TITLE_NOTIFICATION),
        appLocalizations.translate(AppString.NO_INTERNET),
        appLocalizations.translate(AppString.BUTTON_TRY_AGAIN), () async {
      var isConnection = await Utilities().isConnectInternet(isChangeState: false);
      if (isConnection) {
        await firebaseCloudMessaging_Listeners();
      } else {
        showNoInternet();
      }
    });
  }
}
