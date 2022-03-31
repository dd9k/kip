import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraNotifier extends MainNotifier {
  bool reloadSwitch = false;

  Future<List<ItemSwitch>> getSaveItems(BuildContext context) async {
    await Utilities().settingCameraPermission();
    var faceCapture = (preferences.getBool(Constants.KEY_FACE_CAPTURE) ?? true);
    var faceDetect = (preferences.getBool(Constants.KEY_FACE_DETECT) ?? false);
    var frontCamera = (preferences.getBool(Constants.KEY_FRONT_CAMERA) ?? true);
    var lockMode = await Utilities().getKioskMode();
    List<ItemSwitch> items = <ItemSwitch>[
      ItemSwitch(
          title: AppLocalizations.of(context).faceCapture,
          subtitle: AppLocalizations.of(context).faceCaptureSub,
          icon: Icons.camera_alt,
          isSelect: faceCapture,
          switchType: SwitchType.FACE_CAPTURE),
      ItemSwitch(
          title: AppLocalizations.of(context).faceDetection,
          subtitle: AppLocalizations.of(context).faceDetectionSub,
          icon: Icons.camera_enhance,
          isSelect: faceDetect,
          switchType: SwitchType.FACE_DETECT),
      ItemSwitch(
          title: AppLocalizations.of(context).fontCamera,
          subtitle: AppLocalizations.of(context).fontCameraSub,
          icon: Icons.camera_front,
          isSelect: frontCamera,
          switchType: SwitchType.FRONT_CAMERA),
    ];
    if (Platform.isAndroid) {
      items.add(ItemSwitch(
          title: AppLocalizations.of(context).lockMode,
          subtitle: AppLocalizations.of(context).lockModeSub,
          icon: Icons.lock,
          isSelect: lockMode,
          switchType: SwitchType.LOCK_MODE));
    }
    return items;
  }

  Future<void> switchItem(BuildContext context, Function animation, ItemSwitch item) async {
    switch (item.switchType) {
      case SwitchType.FACE_CAPTURE:
        {
          bool checkPermission = await Utilities().settingCameraPermission();
          if (!checkPermission) {
            var mess = (Platform.isAndroid)
                ? AppLocalizations.of(context).noPermissionAndroid
                : AppLocalizations.of(context).noPermissionIOS;
            Utilities().showTwoButtonDialog(
                context,
                DialogType.INFO,
                null,
                AppLocalizations.of(context).noPermissionTitle,
                mess,
                AppLocalizations.of(context).btnSkip,
                AppLocalizations.of(context).btnOpenSetting,
                () async {}, () {
              AppSettings.openAppSettings();
            });
          } else {
            item.isSelect = !item.isSelect;
            preferences.setBool(Constants.KEY_FACE_CAPTURE, item.isSelect);
            animation();
          }
          break;
        }
      case SwitchType.FACE_DETECT:
        {
          var canDetect = await Utilities().checkFaceDetect();
          if (!item.isSelect && canDetect != true) {
            Utilities().showNoButtonDialog(context, false, DialogType.INFO, Constants.AUTO_HIDE_LONGER,
                AppLocalizations.of(context).noDetectTitle, AppLocalizations.of(context).noDetectContent, null);
          } else {
            item.isSelect = !item.isSelect;
            preferences.setBool(Constants.KEY_FACE_DETECT, item.isSelect);
            animation();
          }
          break;
        }
      case SwitchType.FRONT_CAMERA:
        {
          item.isSelect = !item.isSelect;
          preferences.setBool(Constants.KEY_FRONT_CAMERA, item.isSelect);
          animation();
          break;
        }
      case SwitchType.LOCK_MODE:
        {
          if (!item.isSelect && !(await Utilities().isLauncher())) {
            preferences.setBool(Constants.KEY_ON_LOCK, true);
            await Utilities().goHome();
          } else {
            await Utilities().setKioskMode(!item.isSelect);
            item.isSelect = !item.isSelect;
            animation();
          }
          break;
        }
      default:
        {}
    }
    reloadSwitch = !reloadSwitch;
    notifyListeners();
  }
}
