import 'package:flutter/material.dart';

import 'BaseTheme.dart';

final ThemeData blueDarkTheme = _blueDarkTheme().copyWith(
  inputDecorationTheme: BaseTheme().baseTextField,
);

ThemeData _blueDarkTheme() {
  return ThemeData(brightness: Brightness.dark, primaryColor: Colors.blue[700], fontFamily: "Helvetica");
}
