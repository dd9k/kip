import 'dart:ui';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:flutter/material.dart';

//Class define style
//danghld
class Style {
  Style._privateConstructor();

  static final Style _instance = Style._privateConstructor();

  static Style get instance => _instance;

  final styleTextButtonLogin = TextStyle(
    color: Colors.white,
    fontSize: AppDestination.TEXT_NORMAL,
    fontWeight: FontWeight.w600,
    fontFamily: "Helvetica-Light",
  );

  final styleTextButtonAll = TextStyle(
    color: Colors.white,
    fontSize: AppDestination.TEXT_SMALL,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTextGray = TextStyle(
    color: Colors.grey[500],
    //fontSize: AppDestination.TEXT_SMALL_15,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTetxGray15 = TextStyle(
    color: Colors.grey[500],
    fontSize: AppDestination.TEXT_SMALL_15,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTetxGray14 = TextStyle(
    color: Colors.grey[500],
    //fontSize: AppDestination.TEXT_SMALL_14,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTetxGray13 = TextStyle(
    color: Colors.grey[500],
    fontSize: AppDestination.TEXT_SMALL,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTextBack = TextStyle(
    color: Colors.black,
    //fontSize: AppDestination.TEXT_SMALL_15,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );
  final styleTextBack15 = TextStyle(
    color: Colors.black,
    fontSize: AppDestination.TEXT_SMALL_15,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTextNormal = TextStyle(
    color: Colors.black,
    fontSize: AppDestination.TEXT_SMALL_13,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTextNormalBold = TextStyle(
    color: Colors.black,
    fontSize: AppDestination.TEXT_SMALL_12,
    fontWeight: FontWeight.w400,
    fontFamily: "Helvetica-Light",
  );

  final styleTextName = TextStyle(
    color: Colors.black,
    fontSize: AppDestination.TEXT_SMALL_14,
    fontWeight: FontWeight.w600,
    fontFamily: "Helvetica-Light",
  );

  final styleTextBlackBold16 = TextStyle(
    color: Colors.black,
    fontSize: AppDestination.TEXT_SMALL_16,
    fontWeight: FontWeight.w500,
    fontFamily: "Helvetica-Light",
  );

  final styleTextDisable16 = TextStyle(
    color: AppColor.HINT_TEXT_COLOR,
    fontSize: AppDestination.TEXT_SMALL_16,
    fontWeight: FontWeight.w500,
    fontFamily: "Helvetica-Light",
  );

  final styleTextBlue = TextStyle(
    color: Colors.blue[900],
    //fontSize: AppDestination.TEXT_SMALL_15,
    fontWeight: FontWeight.w300,
    fontFamily: "Helvetica-Light",
  );

  final styleTextWhiteBig = TextStyle(
    color: Colors.white,
    fontSize: AppDestination.TEXT_BIG,
    fontWeight: FontWeight.w600,
    fontFamily: "Helvetica-Light",
  );

  final styleTextType = TextStyle(
    color: Colors.white,
    fontSize: AppDestination.TEXT_SMALL_14,
    fontWeight: FontWeight.w400,
    fontFamily: "Helvetica-Light",
  );
}
