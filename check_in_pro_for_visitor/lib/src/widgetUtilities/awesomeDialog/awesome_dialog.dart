library awesome_dialog;

import 'dart:async';

import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';

import 'src/anims/anims.dart';
import 'src/animated_button.dart';
import 'src/anims/flare_header.dart';
import 'src/vertical_stack_header_dialog.dart';
import 'package:flutter/material.dart';

export 'src/animated_button.dart';
export 'src/anims/flare_header.dart';
export 'src/anims/anims.dart';

enum DialogType { INFO, WARNING, ERROR, SUCCES, NO_HEADER }
enum AnimType { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }

class AwesomeDialog {
  /// [@required]
  final BuildContext context;

  /// Dialog Type can be INFO, WARNING, ERROR, SUCCES, NO_HEADER
  final DialogType dialogType;

  /// Widget with priority over DialogType, for a custom header widget
  final Widget customHeader;

  /// Dialog Title
  final String title;

  /// Set the description text of the dialog.
  final String desc;

  /// Create your own Widget for body, if this property is set title and description will be ignored.
  final Widget body;

  /// Btn OK props
  final String btnOkText;
  final IconData btnOkIcon;
  final Function btnOkOnPress;
  final Color btnOkColor;

  /// Btn Cancel props
  final String btnCancelText;
  final IconData btnCancelIcon;
  final Function btnCancelOnPress;
  final Color btnCancelColor;

  /// Custom Btn OK
  final Widget btnOk;

  /// Custom Btn Cancel
  final Widget btnCancel;

  /// Barrier Dissmisable
  final bool dismissOnTouchOutside;

  /// Callback to execute after dialog get dissmised
  final Function onDissmissCallback;

  /// Anim Type can be { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }
  final AnimType animType;

  /// Aligment of the Dialog
  final AlignmentGeometry aligment;

  /// Padding off inner content of Dialog
  final EdgeInsetsGeometry padding;

  /// this Prop is usefull to Take advantage of screen dimensions
  final bool isDense;

  /// Whenever the animation Header loops or not.
  final bool headerAnimationLoop;

  /// To use the Rootnavigator
  final bool useRootNavigator;

  /// show image header
  final bool isShowImage;

  /// For Autho Hide Dialog after some Duration.
  final int autoHide;

  /// For callBackWhenHide after some Duration.
  final Function callBackWhenHide;

  Timer autoClose;

  AwesomeDialog(
      {@required this.context,
      this.dialogType,
      this.customHeader,
      this.title,
      this.desc,
      this.body,
      this.btnOk,
      this.btnCancel,
      this.btnOkText,
      this.btnOkIcon,
      this.btnOkOnPress,
      this.btnOkColor,
      this.btnCancelText,
      this.btnCancelIcon,
      this.btnCancelOnPress,
      this.btnCancelColor,
      this.onDissmissCallback,
      this.isDense = false,
      this.isShowImage,
      this.dismissOnTouchOutside = true,
      this.headerAnimationLoop = true,
      this.aligment = Alignment.center,
      this.animType = AnimType.SCALE,
      this.padding,
      this.useRootNavigator = false,
      this.autoHide,
      this.callBackWhenHide})
      : assert(
          (dialogType != null || customHeader != null),
          context != null,
        );

  bool isDissmisedBySystem = false;

  Future show() => showDialog(
          context: this.context,
          barrierDismissible: dismissOnTouchOutside,
          builder: (BuildContext context) {
            if (autoHide != null) {
              autoClose = Timer(Duration(seconds: autoHide), () {
                Navigator.of(context, rootNavigator: useRootNavigator).pop();
                if (callBackWhenHide != null) {
                  callBackWhenHide();
                }
              });
            }
            switch (animType) {
              case AnimType.SCALE:
                return ScaleFade(scale: 0.1, fade: true, curve: Curves.fastLinearToSlowEaseIn, child: _buildDialog);
                break;
              case AnimType.LEFTSLIDE:
                return FadeIn(from: SlideFrom.LEFT, child: _buildDialog);
                break;
              case AnimType.RIGHSLIDE:
                return FadeIn(from: SlideFrom.RIGHT, child: _buildDialog);
                break;
              case AnimType.BOTTOMSLIDE:
                return FadeIn(from: SlideFrom.BOTTOM, child: _buildDialog);
                break;
              case AnimType.TOPSLIDE:
                return FadeIn(from: SlideFrom.TOP, child: _buildDialog);
                break;
              default:
                return _buildDialog;
            }
          }).then((_) {
        isDissmisedBySystem = true;
        if (onDissmissCallback != null) onDissmissCallback();
      });

  Widget get _buildHeader {
    if (customHeader != null) return customHeader;
    if (dialogType == DialogType.NO_HEADER) return null;
    return FlareHeader(
      loop: headerAnimationLoop,
      dialogType: this.dialogType,
    );
  }

  Widget get _buildDialog => VerticalStackDialog(
        header: _buildHeader,
        title: this.title,
        desc: this.desc,
        body: this.body,
        isDense: isDense,
        aligment: aligment,
        isShowImage: isShowImage,
        padding: padding ?? EdgeInsets.only(left: 5, right: 5),
        btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk : Container()),
        btnCancel: btnCancel ?? (btnCancelOnPress != null ? _buildFancyButtonCancel : null),
      );

  Widget get _buildFancyButtonOk => AnimatedButton(
        isOk: true,
        isFixedHeight: false,
        pressEvent: () {
          Navigator.of(context, rootNavigator: useRootNavigator).pop();
          btnOkOnPress();
        },
        text: btnOkText ?? 'Ok',
        color: btnOkColor ?? AppColor.MAIN_TEXT_COLOR,
        icon: btnOkIcon,
      );

  Widget get _buildFancyButtonCancel => AnimatedButton(
        isOk: false,
        isFixedHeight: false,
        pressEvent: () {
          Navigator.of(context, rootNavigator: useRootNavigator).pop();
          btnCancelOnPress();
        },
        text: btnCancelText ?? 'Cancel',
        color: btnCancelColor ?? AppColor.MAIN_TEXT_COLOR,
        icon: btnCancelIcon,
      );

  dissmiss() {
    if (!isDissmisedBySystem) Navigator.of(context, rootNavigator: useRootNavigator).pop();
  }
}
