import 'package:flutter/material.dart';

import 'SizeConfig.dart';

class AppDestination {
  static const TEXT_SMALL = 13.0;
  static const TEXT_NORMAL = 16.0;
  static const TEXT_BIG = 20.0;
  static const TEXT_MORE_BIG = 25.0;
  static const TEXT_BIG_WEL = 30.0;
  static const TEXT_BIGGER = 3.25;
  static const TEXT_BIGGER_HORIZONTAL = 2.25;
  static const TEXT_BIGGEST = 5.25;
  static const TEXT_BIGGEST_HORIZONTAL = 4.25;

  double getTextBigger(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    SizeConfig().init(context);
    return isPortrait
        ? SizeConfig.safeBlockHorizontal * AppDestination.TEXT_BIGGER
        : SizeConfig.safeBlockHorizontal * AppDestination.TEXT_BIGGER_HORIZONTAL;
  }

  double getTextBiggest(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    SizeConfig().init(context);
    return isPortrait
        ? SizeConfig.safeBlockHorizontal * AppDestination.TEXT_BIGGEST
        : SizeConfig.safeBlockHorizontal * AppDestination.TEXT_BIGGEST_HORIZONTAL;
  }

  static const RADIUS_TEXT_INPUT = 4.0;
  static const RADIUS_TEXT_INPUT_BIG = 4.0;

  static const PADDING_TINY = 0.5;
  static const PADDING_SMALL = 1.0;
  static const PADDING_NORMAL = 1.5;
  static const PADDING_BIG = 1.75;
  static const PADDING_BIGGER = 1.25;
  static const PADDING_EXTRAS_BIG = 3.3;

  static const PADDING_TINY_HORIZONTAL = 0.75;
  static const PADDING_SMALL_HORIZONTAL = 1.25;
  static const PADDING_NORMAL_HORIZONTAL = 1.5;
  static const PADDING_BIG_HORIZONTAL = 1.0;
  static const PADDING_BIGGER_HORIZONTAL = 1.5;
  static const PADDING_EXTRAS_BIG_HORIZONTAL = 3.3;

  static const TEXT_SMALL_16 = 16.0;
  static const TEXT_SMALL_15 = 15.0;
  static const TEXT_SMALL_14 = 14.0;
  static const TEXT_SMALL_13 = 13.0;
  static const TEXT_SMALL_12 = 12.0;
  static const TEXT_SMALL_10 = 10.0;

  static const CARD_HEIGHT = 167.25;
  static const CARD_WIGHT = 231.25;

  static const CARD_HEIGHT_ESC = 250.0;
  static const CARD_WIGHT_ESC = 234.25;

  double getPadding(BuildContext context, double destinationVertical, double destinationHorizontal, bool isVertical) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    SizeConfig().init(context);
    if (isVertical) {
      return isPortrait
          ? SizeConfig.safeBlockVertical * destinationVertical
          : SizeConfig.safeBlockVertical * destinationHorizontal;
    }
    return isPortrait
        ? SizeConfig.safeBlockHorizontal * destinationVertical
        : SizeConfig.safeBlockHorizontal * destinationHorizontal;
  }

  static const PADDING_WAITING = 25.0;
  static const PADDING_WAITING_HORIZONTAL = 50.0;
}
