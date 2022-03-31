import 'package:flutter/material.dart';

import '../constants/AppColors.dart';
import '../constants/AppDestination.dart';

class BaseTheme {
  static final BaseTheme _singleton = BaseTheme._internal();

  factory BaseTheme() {
    return _singleton;
  }

  BaseTheme._internal();

  var baseTextField = InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.only(left: 23.0, top: 18, bottom: 18, right: 20),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(AppDestination.RADIUS_TEXT_INPUT),
        ),
        borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
    border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(AppDestination.RADIUS_TEXT_INPUT),
        ),
        borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        const Radius.circular(AppDestination.RADIUS_TEXT_INPUT),
      ),
      borderSide: new BorderSide(color: AppColor.RED_COLOR),
    ),
    hintStyle: TextStyle(fontSize: 20, color: AppColor.HINT_TEXT_COLOR),
    labelStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
    errorStyle: TextStyle(fontSize: 16),
  );
}
