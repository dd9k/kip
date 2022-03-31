import 'dart:async';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyLanguage.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/UtilityNotifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/SizeConfig.dart';

class FancyFab<T extends UtilityNotifier> extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final T provider;

  const FancyFab({Key key, this.onPressed, this.tooltip, this.icon, this.provider}) : super(key:key);

  @override
  FancyFabState createState() => FancyFabState();
}

class FancyFabState extends State<FancyFab> with SingleTickerProviderStateMixin {
  String langCache;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 36.0;
  AsyncMemoizer<String> memCache = AsyncMemoizer();
  List<CompanyLanguage> listLang = List();
  bool isFabOpen = false;

  @override
  initState() {
    if (widget.provider.listLang == null || widget.provider.listLang.isEmpty) {
      listLang.add(CompanyLanguage(Constants.EN_CODE, ""));
      listLang.add(CompanyLanguage(Constants.VN_CODE, ""));
    } else {
      listLang.addAll(widget.provider.listLang);
    }
    listLang.add(CompanyLanguage("", ""));
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: AppColor.GRAY,
      end: AppColor.MAIN_TEXT_COLOR,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: 54,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isFabOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isFabOpen = !isFabOpen;
  }

  Widget toggle(String lang) {
    FabModel fabModel = FabModel(context, lang);
    return Container(
      child: FloatingActionButton(
        elevation: 0,
        focusElevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: animate,
        child: buildCircle(fabModel.flag),
      ),
    );
  }

  Container buildCircle(Image image) {
    return Container(
      height: _fabHeight,
      width: _fabHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [AppColor.GRAY_BOLD, AppColor.GRAY],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(width: 1.0, color: AppColor.GRAY_BOLD),
        borderRadius: BorderRadius.all(Radius.circular(360.0) //         <--- border radius here
            ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(360.0)),
        child: OverflowBox(
          alignment: Alignment.center,
          child: image,
        ),
      ),
    );
  }

  Future<String> getLanguage(BuildContext context) async {
    return memCache.runOnce(() async {
      var completer = Completer<String>();
      var prefer = await SharedPreferences.getInstance();
      var lang = prefer.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      completer.complete(lang);
      return completer.future;
    });
  }

  Widget floatingButt(BuildContext context, String lang) {
    FabModel fabModel = FabModel(context, lang);
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        elevation: 0,
        focusElevation: 0,
        backgroundColor: Colors.transparent,
        onPressed: fabPress(context, lang),
        child: buildCircle(fabModel.flag),
      ),
    );
  }

  Function fabPress(BuildContext context, String lang) => () {
        animate();
        setState(() {
          langCache = lang;
        });
        widget.provider.updateLang(lang);
      };

  List<Widget> _buildListFAB(BuildContext context) {
    List<Widget> list = List();
    langCache = widget.provider.currentLang;
    listLang.asMap().forEach((index, value) {
      if (index == (listLang.length - 1)) {
        list.add(toggle(langCache));
      } else {
        list.add(buildTransform(context, listLang.length - index - 1, value.languageCode));
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1, right: AppDestination.PADDING_WAITING / 2),
      child: Wrap(
        direction: Axis.vertical,
        children: _buildListFAB(context),
      ),
    );
  }

  Transform buildTransform(BuildContext context, int index, String lang) {
    return Transform(
      transform: Matrix4.translationValues(
        0.0,
        _translateButton.value * index + (index * 2),
        0.0,
      ),
      child: floatingButt(context, lang),
    );
  }
}

class FabModel {
  String title;
  Image flag;

  FabModel(BuildContext context, String lang) {
    title = getTitle(context, lang);
    flag = getImage(lang);
  }

  String getTitle(BuildContext context, String lang) {
    switch (lang) {
      case Constants.VN_CODE:
        {
          return AppLocalizations.of(context).langVi;
        }
      case Constants.EN_CODE:
        {
          return AppLocalizations.of(context).langEn;
        }
      default:
        {
          return AppLocalizations.of(context).langEn;
        }
    }
  }

  Image getImage(String lang) {
    switch (lang) {
      case Constants.VN_CODE:
        {
          return Image.asset(
            "assets/images/vi_flag.png",
            cacheWidth: 160 * SizeConfig.devicePixelRatio,
            cacheHeight: 160 * SizeConfig.devicePixelRatio,
          );
        }
      case Constants.EN_CODE:
        {
          return Image.asset(
            "assets/images/en_flag.png",
            cacheWidth: 160 * SizeConfig.devicePixelRatio,
            cacheHeight: 160 * SizeConfig.devicePixelRatio,
          );
        }
      default:
        {
          return Image.asset(
            "assets/images/en_flag.png",
            cacheWidth: 160 * SizeConfig.devicePixelRatio,
            cacheHeight: 160 * SizeConfig.devicePixelRatio,
          );
        }
    }
  }
}
