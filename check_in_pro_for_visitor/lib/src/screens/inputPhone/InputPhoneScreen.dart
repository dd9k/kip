import 'dart:io';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ImageScannerAnimation.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'InputPhoneNotifier.dart';

class InputPhoneScreen extends MainScreen {
  static const String route_name = '/phoneCheckIn';

  @override
  _InputPhoneScreenState createState() => _InputPhoneScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _InputPhoneScreenState extends MainScreenState<InputPhoneNotifier> with TickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController _phoneController = TextEditingController();
  final TextEditingController controllerType = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  GlobalKey<FormState> _phoneNumberKey = new GlobalKey();

  bool isShowQRCode = false;
  AnimationController _animationController;
  bool _animationStopped = false;
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneFocusNode.addListener(() {
      provider.showClear(phoneFocusNode.hasFocus);
    });

    if (_animationController == null) {
      _animationController =
          new AnimationController(duration: new Duration(seconds: Constants.TIME_ANIMATION_SCAN), vsync: this);

      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animateScanAnimation(true);
        } else if (status == AnimationStatus.dismissed) {
          animateScanAnimation(false);
        }
      });
    }
    _phoneController.addListener(() {
      provider.qrCodeStr = _phoneController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    animateScanAnimation(false);
    var percentBox = isPortrait ? 60 : 60;
    provider = Provider.of<InputPhoneNotifier>(context, listen: false);
    var style = Constants.STYLE_1;
    if (!isInit) {
      isInit = true;
      var phoneNumber = provider.arguments["phoneNumber"] as String ?? "";
      _phoneController.text = phoneNumber;
    }

    if (provider.arguments != null) {
      style = provider.arguments["style"] as String ?? "";
    }
    provider.isDelivery = provider.arguments["isDelivery"] as bool ?? false;
    return FutureBuilder<List<CheckInFlow>>(
      future: provider.getInitValue(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Selector<InputPhoneNotifier, bool>(
            builder: (context, data, child) => Background(
              isShowBack: true,
              isAnimation: true,
              isShowClock: true,
              isOpeningKeyboard: !provider.isShowLogo,
              isShowLogo: provider.isShowLogo,
              messSnapBar: appLocalizations.messOffline,
              isShowChatBox: false,
              contentChat: AppLocalizations.of(context).translate(AppString.MESSAGE_NO_PHONE),
              type: BackgroundType.MAIN,
              child: Container(
                  width: SizeConfig.screenWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (provider.isShowVisitorType()) buildVisitorType(),
                      if (provider.isShowVisitorType()) SizedBox(
                        height: 30,
                      ),
                      Selector<InputPhoneNotifier, bool>(
                        builder: (context, data, child) => Visibility(
                          visible: (!provider.isShowVisitorType() || data),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(flex: 1, child: Container()),
                              Flexible(
                                flex: 6,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.only(
                                    right: !isShowQRCode ? 0 : 50,
                                  ),
                                  width: SizeConfig.blockSizeHorizontal * percentBox,
                                  child: _buildFormUI(),
                                ),
                              ),
//                            Visibility(
//                              child: firstWidget(),
//                              visible: !isShowQRCode,
//                            ),
//                            Visibility(
//                              child: secondWidget(isPortrait),
//                              visible: isShowQRCode,
//                            ),
                              Flexible(flex: 1, child: Container()),
                            ],
                          ),
                        ),
                        selector: (context, provider) => provider.isShowPhone,
                      ),
                      SizedBox(
                        height: 150,
                      ),
                    ],
                  )),
            ),
            selector: (context, provider) => provider.isLoading,
          );
        }
        return Background(
          isShowBack: true,
          isShowLogo: false,
          isShowChatBox: false,
          type: BackgroundType.MAIN,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowLogo = !visible;
  }

  Widget firstWidget() {
    return Flexible(
        flex: 0,
        child: IconButton(
          icon: Image.asset(
            'assets/images/scanQR.png',
            cacheWidth: 40 * SizeConfig.devicePixelRatio,
            cacheHeight: 40 * SizeConfig.devicePixelRatio,
          ),
          iconSize: 50,
          onPressed: () {
            setState(() {
              isShowQRCode = !isShowQRCode;
            });
          },
        ));
  }

  Widget secondWidget(bool isPortrait) {
    return Flexible(
      flex: 4,
      child: Stack(alignment: Alignment.center, children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Selector<InputPhoneNotifier, bool>(
            builder: (context, visible, child) {
              return QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.lightBlue,
                  borderRadius: 10,
                  borderLength: 40,
                  borderWidth: 10,
                  cutOutSize: 200,
                ),
              );
            },
            selector: (buildContext, provider) => provider.isLoadCamera,
          ),
        ),
        ImageScannerAnimation(
          _animationStopped,
          334,
          animation: _animationController,
        )
      ]),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    provider.controller = controller;
    provider.startStream(context);
  }

  void animateScanAnimation(bool reverse) {
    if (reverse) {
      _animationController.reverse(from: 1.0);
    } else {
      _animationController.forward(from: 0.0);
    }
  }

  Widget _buildFormUI() {
    return Form(
      key: _phoneNumberKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_buildPhoneNumberTxtField(), _buildBtnNext()],
      ),
    );
  }

  Widget buildVisitorType() {
    var visitorType = provider.listType;
    controllerType.value = TextEditingValue(
        text: (provider.visitorType == null) ? visitorType[0].description : provider.visitorType.description);
    return Column(
      children: <Widget>[
        Selector<InputPhoneNotifier, VisitorType>(
          builder: (context, data, child) {
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
            var textSize = isPortrait ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockVertical * 4;
            return AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 500),
                child: Text(
                  AppLocalizations.of(context).titleVisitorType,
                ),
                style: TextStyle(
                    fontSize: (provider.visitorType != null && !provider.isScanIdCard) ? textSize / 2 : textSize,
                    color: Colors.black));
          },
          selector: (context, provider) => provider.visitorType,
        ),
        SizedBox(
          height: 30,
        ),
        WrapSuper(
          spacing: 60.0,
          lineSpacing: 30.0,
          alignment: WrapSuperAlignment.center,
          children: visitorType.map((item) => visitorTypeItem(context, item.description, item)).toList().cast<Widget>(),
        ),
      ],
    );
  }

  Widget visitorTypeItem(BuildContext context, String text, VisitorType item) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var textInBox = isPortrait ? SizeConfig.safeBlockHorizontal * 4 : SizeConfig.safeBlockVertical * 4;
    var sizeBox = isPortrait ? SizeConfig.safeBlockHorizontal * 30 : SizeConfig.safeBlockVertical * 30;
    var container = GestureDetector(
      onTap: () => provider.updateType(context, item),
      child: Selector<InputPhoneNotifier, VisitorType>(
        builder: (context, data, child) {
          var isSelected = provider.visitorType == item;
          return AnimatedContainer(
            duration: Duration(milliseconds: (provider.isSelectedType < 2) ? 500 : 200),
            width: (data != null && !provider.isScanIdCard) ? sizeBox / 2 : sizeBox,
            height: (data != null && !provider.isScanIdCard) ? sizeBox / 3 : sizeBox,
            alignment: Alignment.center,
            child: Text(text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (data != null && !provider.isScanIdCard) ? textInBox / 2 : textInBox,
                  color: isSelected ? Colors.white : Colors.black,
                )),
            decoration: BoxDecoration(
                color: isSelected ? AppColor.MAIN_TEXT_COLOR : Colors.white,
                border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          );
        },
        selector: (context, provider) => provider.visitorType,
      ),
    );
    return container;
  }

  Widget _buildPhoneNumberTxtField() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Selector<InputPhoneNotifier, bool>(
                    builder: (context, isShowClear, child) => TextFormField(
                        controller: _phoneController,
                        validator: Validator(context).validatePhoneNumber,
                        focusNode: phoneFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(30),
                        ],
                        decoration: InputDecoration(
                          suffixIcon: isShowClear
                              ? GestureDetector(
                                  onTap: () {
                                    _phoneController.clear();
                                    provider.qrCodeStr = '';
                                  },
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    child: Icon(
                                      Icons.cancel,
                                      size: 24,
                                      color: AppColor.HINT_TEXT_COLOR,
                                    ),
                                  ),
                                )
                              : null,
                          labelText: AppLocalizations.of(context).phoneText,
                        ),
                        onChanged: (_) => Utilities().moveToWaiting(),
                        onEditingComplete: () {
                          Utilities().hideKeyBoard(context);
                          if (_phoneNumberKey.currentState.validate()) {
                            Utilities().tryActionLoadingBtn(provider?.btnController, BtnLoadingAction.START);
                          } else {
                            Utilities().tryActionLoadingBtn(provider?.btnController, BtnLoadingAction.STOP);
                          }
                        },
                        style: Styles.formFieldText),
                    selector: (buildContext, provider) => provider.isShowClear),
              ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBtnNext() {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: RaisedGradientButton(
        isLoading: true,
        btnController: provider.btnController,
        disable: provider.isLoading,
        btnText: AppLocalizations.of(context).translate(AppString.BTN_CONTINUE),
        onPressed: () {
          Utilities().hideKeyBoard(context);
          _phoneController.text = provider.qrCodeStr;
          provider.phone = _phoneController.text;
          if (_phoneNumberKey.currentState.validate()) {
            provider.searchVisitor(context, _phoneController.text);
          } else {
            Utilities().tryActionLoadingBtn(provider?.btnController, BtnLoadingAction.STOP);
            provider.isScanned = false;
          }
        },
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
