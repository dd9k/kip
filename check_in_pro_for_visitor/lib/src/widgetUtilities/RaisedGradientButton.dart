import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RaisedGradientButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final double height;
  final bool isLoading;
  final bool styleEmpty;
  final double btnTextSize;
  final RoundedLoadingButtonController btnController;

  final disable;

  RaisedGradientButton(
      {this.btnText,
      this.btnTextSize,
      @required this.onPressed,
      this.height,
      @required this.disable,
      this.isLoading,
      this.styleEmpty,
      this.btnController});

  @override
  Widget build(BuildContext context) {
    var isLoadingButton = isLoading ?? false;
    if (isLoadingButton) {
      return AbsorbPointer(
        absorbing: disable,
        child: RoundedLoadingButton(
          onPressed: onPressed,
          controller: btnController,
          child: buildContent(context),
        ),
      );
    }
    return AbsorbPointer(
      absorbing: disable,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
        child: buildContent(context),
      ),
    );
  }

  Ink buildContent(BuildContext context) {
    if (styleEmpty != null && styleEmpty) {
      return buildEmpty(context);
    }
    return buildFull(context);
  }

  Ink buildFull(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          gradient: disable ? AppColor.linearGradientDisabled : AppColor.linearGradient,
          borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
      child: Container(
        constraints: BoxConstraints(minHeight: this.height ?? Constants.HEIGHT_BUTTON),
        alignment: Alignment.center,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.title.fontSize,
          ),
        ),
      ),
    );
  }

  Ink buildEmpty(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
          borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
      child: Container(
        constraints: BoxConstraints(minHeight: this.height ?? Constants.HEIGHT_BUTTON),
        alignment: Alignment.center,
        child: Text(
          btnText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: Theme.of(context).textTheme.title.fontSize,
          ),
        ),
      ),
    );
  }
}
