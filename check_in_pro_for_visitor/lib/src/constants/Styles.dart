import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const formFieldText = TextStyle(fontSize: 20, height: 1.25);
  static const gpText = TextStyle(color: Color(0xff9a9a9a), fontWeight: FontWeight.w400, fontSize: 18);

  static const gpTextBold = TextStyle(color: Color(0xff9a9a9a), fontWeight: FontWeight.w600, fontSize: 18);

  static const gpTextItalic = TextStyle(
    color: Color(0xff9a9a9a),
    fontWeight: FontWeight.w400,
    fontSize: 18,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
  );

  static const gpInputText = TextStyle(fontSize: 18, color: Color(0xff0364ce));

  static const fbTitle = TextStyle(fontSize: 36, height: 1.25);
  static const fbSubTitle = TextStyle(fontSize: 20, height: 2);

  static const waitingText =
      TextStyle(fontSize: AppDestination.TEXT_BIG, color: AppColor.BLACK_TEXT_COLOR, decoration: TextDecoration.none);

  static const messageTxtBox =
      TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w400, decoration: TextDecoration.none);

  static const descCompanyName = TextStyle(
      fontSize: AppDestination.TEXT_NORMAL,
      fontWeight: FontWeight.w400,
      color: AppColor.TEXT_FOOTER,
      decoration: TextDecoration.none);

  static const btnShowMore = TextStyle(color: Color(0xff549cff), fontSize: AppDestination.TEXT_NORMAL);

  static const Helvetica = "Helvetica";
  static const Montserrat = "Montserrat";
}
