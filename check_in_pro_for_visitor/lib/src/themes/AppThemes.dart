import 'package:check_in_pro_for_visitor/src/themes/BlueDark.dart';
import 'package:check_in_pro_for_visitor/src/themes/BlueLight.dart';
import 'package:check_in_pro_for_visitor/src/themes/GreenDark.dart';
import 'package:check_in_pro_for_visitor/src/themes/GreenLight.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark,
}

final appThemeData = {
  AppTheme.GreenLight: greenLightTheme,
  AppTheme.GreenDark: greenDarkTheme,
  AppTheme.BlueLight: blueLightTheme,
  AppTheme.BlueDark: blueDarkTheme,
};
