import 'package:flutter/material.dart';

class AppColor {
  static const BASE_LOADING = Color(0xFFC7CAD1);
  static const HIGHLIGHT_LOADING = Color(0xFFAFB2BB);
  static const BACKGROUND_LOADING = Color(0xFFEDEEF0);
  static const MAIN_CHECK_OUT = Color(0xFFE7970D);
  static const WARNING_COLOR = Color(0xFFffc107);
  static const MAIN_CHECK_IN = Color(0xFF0359D4);
  static const MAIN_TEXT_COLOR = Color(0xFF0a75e5);
  static const MAIN_TEXT2_COLOR = Color(0xff0294B4);
  static const BLUE_MINT_COLOR = Color(0xFFdfeeff);
  static const TEXT_IN_BLUE_TIME = Color(0xFFA5BEE9);
  static const TEXT_IN_BLUE_NAME = Color(0xFF81B0E8);
  static const BLACK_TEXT_COLOR = Color(0xFF000000);
  static const RED_COLOR = Color(0xFFC32B2B);
  static const RED_SUB_COLOR = Color(0xFFFAE6E7);
  static const HINT_TEXT_COLOR = Color(0xFFB3B1B1);
  static const LINE_COLOR = Color(0xFFD8D8D8);
  static const TEXT_FOOTER = Color(0xFF2c2c2c);
  static const GRAY_BOLD = Color(0xFFD8D8D8);
  static const GRAY = Color(0xFFEEEEEE);
  static const LINE2_COLOR = Color(0xFF367FD3);
  static const MAIN_BACKGROUND = Color(0xFFFFF2F2);
  static const MAIN_COLOR_STRING = "0a75e5";
  static const GREEN = Color(0xFF52C41A);

  static const linearGradient = LinearGradient(
    colors: const [Color(0xff046FDA), Color(0xff0359D4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const linearGradientDisabled = LinearGradient(
    colors: const [Color(0xFFB4B4B4), Color(0xFF999999)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const linearQR = LinearGradient(
    colors: const [Color(0xFFEEEEEE), Color(0xFFEEEEEE), Color(0xFFEEEEEE), Color(0xFFEEEEEE), Color(0xFFB4B4B4)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
