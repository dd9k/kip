import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/login/LoginNotifier.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Loading.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../constants/AppDestination.dart';

class LoginScreen extends MainScreen {
  static const String route_name = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _LoginScreenState extends MainScreenState<LoginNotifier> with WidgetsBindingObserver {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  GlobalKey<FormState> emailKey = GlobalKey();
  GlobalKey<FormState> passwordKey = GlobalKey();
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Utilities().timeoutToResetApp?.cancel();
    WidgetsBinding.instance.addObserver(this);
    emailFocusNode.addListener(() {
      provider.showClear(emailFocusNode.hasFocus);
    });
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowKeyBoard = !visible;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
//    provider.setFaceDetect();
//    var type = isPortrait ? BackgroundType.LOGIN_PORTRAIT : BackgroundType.LOGIN_LANDSCAPE;
    int sizeRender = isPortrait ? 70 : 50;
    return FutureBuilder<String>(
        future: provider.initURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!isInit && (emailController.text.isEmpty == true)) {
              isInit = true;
              emailController.value = TextEditingValue(text: snapshot.data);
            }
            return Selector<LoginNotifier, bool>(
                builder: (context, data, child) {
                  return Loading(
                    child: Background<LoginNotifier>(
                      isShowLogo: false,
                      isUseProvider: false,
                      isShowLogout: false,
                      isShowBack: true,
                      isShowChatBox: false,
                      isShowFloatingButton: true,
                      provider: provider,
                      isOpeningKeyboard: !provider.isShowKeyBoard,
                      type: BackgroundType.MAIN,
                      child: Selector<LoginNotifier, bool>(
                          builder: (context, data, child) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  GestureDetector(
                                    onDoubleTap: () => provider.onTapLogo(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: locator<AppDestination>().getPadding(
                                              context,
                                              AppDestination.PADDING_NORMAL,
                                              AppDestination.PADDING_NORMAL_HORIZONTAL,
                                              true)),
                                      child: Image.asset(
                                        'assets/images/logo_company.png',
                                        cacheWidth: 342 * SizeConfig.devicePixelRatio,
                                        cacheHeight: 67 * SizeConfig.devicePixelRatio,
                                      ),
                                    ),
                                  ),
                                  _buildTextFiledRow(
                                      AppLocalizations.of(context).translate(AppString.EMAIL),
                                      AppLocalizations.of(context).translate(AppString.HINT_LOGIN_EMAIL),
                                      (provider.errorText == null || provider.errorText.isEmpty)
                                          ? null
                                          : provider.errorText[0],
                                      emailController,
                                      false,
                                      emailFocusNode,
                                      sizeRender, () {
                                    emailFocusNode.unfocus();
                                    FocusScope.of(context).requestFocus(passFocusNode);
                                    emailKey.currentState.validate();
                                  }),
                                  _buildTextFiledRow(
                                      AppLocalizations.of(context).translate(AppString.PASSWORD),
                                      AppLocalizations.of(context).translate(AppString.HINT_LOGIN_PASSWORD),
                                      (provider.errorText == null || provider.errorText.length < 2)
                                          ? null
                                          : provider.errorText[1],
                                      passwordController,
                                      true,
                                      passFocusNode,
                                      sizeRender, () {
                                    passFocusNode.unfocus();
                                    if (passwordKey.currentState.validate() && emailKey.currentState.validate()) {
                                      provider.doLogin(this.context, emailController.text, passwordController.text);
                                    }
                                  }),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 20,
                                      left: locator<AppDestination>().getPadding(context, AppDestination.PADDING_NORMAL,
                                          AppDestination.PADDING_NORMAL_HORIZONTAL, false),
                                      right: locator<AppDestination>().getPadding(
                                          context,
                                          AppDestination.PADDING_NORMAL,
                                          AppDestination.PADDING_NORMAL_HORIZONTAL,
                                          false),
                                    ),
                                    child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * sizeRender,
                                        child: RaisedGradientButton(
                                            disable: provider.isLoading,
                                            btnText:
                                                AppLocalizations.of(context).translate(AppString.BUTTON_LOGIN_TEXT),
                                            onPressed: () {
                                              if (emailKey.currentState.validate() &&
                                                  passwordKey.currentState.validate()) {
                                                Utilities().hideKeyBoard(context);
                                                provider.doLogin(
                                                    this.context, emailController.text, passwordController.text);
                                              } else {}
                                            })),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        top: locator<AppDestination>().getPadding(context, AppDestination.PADDING_BIG,
                                            AppDestination.PADDING_BIG_HORIZONTAL, true),
                                      ),
                                      child: Selector<LoginNotifier, bool>(
                                          builder: (context, data, child) => Visibility(
                                                visible: provider.isDevMode,
                                                child: ToggleButtons(
                                                  children: <Widget>[
                                                    Text(
                                                      "PRO",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppDestination.TEXT_BIG),
                                                    ),
                                                    Text(
                                                      "VNG",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppDestination.TEXT_BIG),
                                                    ),
                                                    Text(
                                                      "FPT",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppDestination.TEXT_BIG),
                                                    ),
//                                            Text("VNG", style: TextStyle(
//                                                fontWeight: FontWeight.bold,
//                                                fontSize: AppDestination
//                                                    .TEXT_BIG),),
                                                  ],
                                                  isSelected: provider.selections,
                                                  onPressed: (index) {
                                                    provider.onToggleSelected(index);
                                                  },
                                                ),
                                              ),
                                          selector: (buildContext, provider) => provider.updateToggle)),
                                  SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                          selector: (buildContext, provider) => provider.isUpdateLang),
                    ),
                    visible: data,
                  );
                },
                selector: (buildContext, provider) => provider.isLoading);
          } else {
            return Background(
              isShowBack: false,
              isShowLogo: false,
              isShowChatBox: false,
              type: BackgroundType.MAIN,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildTextFiledRow(String title, String hint, String errorText, TextEditingController controller,
      bool isPassword, FocusNode focusNode, int sizeRender, Function onComplete) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: locator<AppDestination>()
            .getPadding(context, AppDestination.PADDING_NORMAL, AppDestination.PADDING_NORMAL_HORIZONTAL, false),
        right: locator<AppDestination>()
            .getPadding(context, AppDestination.PADDING_NORMAL, AppDestination.PADDING_NORMAL_HORIZONTAL, false),
      ),
      child: Container(
        width: widthScreen * sizeRender,
        child: Form(
          key: isPassword ? passwordKey : emailKey,
          child: Selector<LoginNotifier, bool>(
              builder: (context, isShowClear, child) => TextFormField(
                  validator: isPassword ? Validator(context).validatePassword : Validator(context).validateEmail,
                  obscureText: (isPassword && !provider.isShowPass),
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
                  onEditingComplete: onComplete,
                  textInputAction: TextInputAction.next,
                  decoration: new InputDecoration(
                    suffixIcon: isPassword
                        ? IconButton(
                            icon: Icon(
                              provider.isShowPass ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () => provider.showPass(),
                          )
                        : (isShowClear
                            ? GestureDetector(
                                onTap: () => controller.clear(),
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
                            : null),
                    labelText: title,
                    errorText: errorText,
                  ),
                  onChanged: null,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(100),
                  ],
                  style: Styles.formFieldText),
              selector: (buildContext, provider) => provider.isShowClear),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
