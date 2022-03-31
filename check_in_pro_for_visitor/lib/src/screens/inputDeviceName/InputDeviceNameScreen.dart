import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/DeviceInfo.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputDeviceName/InputDeviceNameNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Loading.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class InputDeviceNameScreen extends MainScreen {
  static const String route_name = '/deviceName';

  @override
  _InputDeviceNameScreenState createState() => _InputDeviceNameScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _InputDeviceNameScreenState extends MainScreenState<InputDeviceNameNotifier> {
  TextEditingController _deviceNameController = new TextEditingController();
  GlobalKey<FormState> _deviceNameKey = GlobalKey();
  bool isInit = false;

  @override
  void onKeyboardChange(bool visible) {
    provider.isOpeningKeyboard = visible;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Selector<InputDeviceNameNotifier, bool>(
      builder: (context, data, child) => Loading(
        child: FutureBuilder<DeviceInfo>(
            future: provider.getDeviceInfor(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (!isInit && _deviceNameController.text.isEmpty) {
                  isInit = true;
                  _deviceNameController.text = snapshot.data.deviceName;
                }
                return Background(
                  isShowBack: provider.arguments["isShowBack"],
                  isShowLogo: false,
                  isShowChatBox: false,
                  type: BackgroundType.MAIN,
                  isOpeningKeyboard: provider.isOpeningKeyboard,
                  child: _buildPageContain(context, provider),
                );
              } else {
                return Background(
                  isShowBack: provider.arguments["isShowBack"],
                  isShowLogo: false,
                  isShowChatBox: false,
                  type: BackgroundType.MAIN,
                  child: CircularProgressIndicator(),
                );
              }
            }),
        visible: data,
      ),
      selector: (context, provider) => provider.isLoading,
    );
  }

  Widget _buildPageContain(BuildContext context, InputDeviceNameNotifier notifier) {
    var percentBox = isPortrait ? 60 : 40;
    return Container(
      child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            "assets/images/ipad_name.png",
            cacheWidth: 168 * SizeConfig.devicePixelRatio,
            cacheHeight: 186 * SizeConfig.devicePixelRatio,
            fit: BoxFit.contain,
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * percentBox,
            child: Form(
              key: _deviceNameKey,
              child: TextFormField(
                validator: Validator(context).validateDeviceName,
                controller: _deviceNameController,
                textCapitalization: TextCapitalization.sentences,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(30),
                ],
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate(AppString.HINT_IPAD_NAME),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 40),
            child: Text(
              AppLocalizations.of(context).translate(AppString.ENTER_IPAD_NAME),
              style: Styles.gpText,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * percentBox,
            child: RaisedGradientButton(
              disable: notifier.isLoading,
              btnText: AppLocalizations.of(context).translate(AppString.BTN_CONTINUE),
              onPressed: () {
                if (_deviceNameKey.currentState.validate()) {
                  Utilities().hideKeyBoard(context);
                  notifier.doSetupDevice(this.context, _deviceNameController.text);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _deviceNameController.dispose();
    super.dispose();
  }
}
