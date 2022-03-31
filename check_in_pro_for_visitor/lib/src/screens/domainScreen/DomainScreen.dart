import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Loading.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DomainScreen extends MainScreen {
  static const String route_name = '/DomainScreen';

  @override
  DomainScreenState createState() => DomainScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class DomainScreenState extends MainScreenState<DomainNotifier> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<String>(
        future: provider.initData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!isInit && (controller.text.isEmpty == true)) {
              isInit = true;
              controller.value = TextEditingValue(text: snapshot.data);
            }
            return Selector<DomainNotifier, bool>(
                builder: (context, data, child) => Loading(
                      visible: data,
                      child: Background(
                        isShowBack: false,
                        isShowLogo: false,
                        isShowChatBox: false,
                        isShowFloatingButton: true,
                        isOpeningKeyboard: !provider.isShowKeyBoard,
                        type: BackgroundType.MAIN,
                        provider: provider,
                        child: _buildPageContain(context),
                      ),
                    ),
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

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowKeyBoard = !visible;
  }

  Widget _buildPageContain(BuildContext context) {
    var percentBox = isPortrait ? 55 : 45;
    return Selector<DomainNotifier, bool>(
        builder: (context, data, child) => Container(
              child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onDoubleTap: () => provider.onTapLogo(),
                    child: Image.asset(
                      'assets/images/logo_company.png',
                      cacheWidth: 342 * SizeConfig.devicePixelRatio,
                      cacheHeight: 67 * SizeConfig.devicePixelRatio,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * percentBox,
                    child: Selector<DomainNotifier, String>(
                        builder: (context, error, child) => Form(
                              key: key,
                              child: TextFormField(
                                validator: Validator(context).validateDomain,
                                controller: controller,
                                textCapitalization: TextCapitalization.none,
                                textAlign: TextAlign.end,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(100),
                                ],
                                style: Styles.formFieldText,
                                decoration: InputDecoration(
                                  errorText: error,
                                  contentPadding: EdgeInsets.only(left: 20),
                                  labelText: provider.appLocalizations.domainHint,
                                  suffixIcon: Container(
                                    alignment: Alignment.centerLeft,
                                    color: AppColor.MAIN_TEXT_COLOR,
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      Constants.SUFFIX_URL,
                                      style: TextStyle(fontSize: 17, color: Colors.white),
                                    ),
                                  ),
                                  suffixIconConstraints: BoxConstraints(maxWidth: 150, minHeight: 60),
                                ),
                              ),
                            ),
                        selector: (buildContext, provider) => provider.error),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: widthScreen * percentBox,
                    child: RaisedGradientButton(
                      disable: provider.isLoading,
                      btnText: provider.appLocalizations.translate(AppString.BTN_CONTINUE),
                      onPressed: () {
                        if (key.currentState.validate()) {
                          provider.utilities.hideKeyBoard(context);
                          provider.validateDomain(context, controller.text.toLowerCase());
                        }
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: locator<AppDestination>().getPadding(context, AppDestination.PADDING_BIG,
                            AppDestination.PADDING_BIG_HORIZONTAL, true),
                      ),
                      child: Selector<DomainNotifier, bool>(
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
            ),
        selector: (buildContext, provider) => provider.isUpdateLang);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
