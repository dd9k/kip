import 'package:check_in_pro_for_visitor/src/themes/BaseTheme.dart';
import 'package:flutter/material.dart';

import '../constants/AppColors.dart';

final ThemeData blueLightTheme = _blueLightTheme().copyWith(inputDecorationTheme: BaseTheme().baseTextField);

ThemeData _blueLightTheme() {
  return ThemeData(brightness: Brightness.light, primaryColor: AppColor.MAIN_TEXT_COLOR, fontFamily: "Helvetica");
}
