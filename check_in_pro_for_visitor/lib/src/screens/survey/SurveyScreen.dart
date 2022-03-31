import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/SurveyItemWidget.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:provider/provider.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SurveyNotifier.dart';

class SurveyScreen extends MainScreen {
  static const String route_name = '/SurveyScreen';

  @override
  _SurveyScreenState createState() => _SurveyScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _SurveyScreenState extends MainScreenState<SurveyNotifier> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: provider.getSurvey(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var badgeTemplate = provider.preferences.getString(Constants.KEY_BADGE_PRINTER);
          return Stack(
            children: <Widget>[
              Scaffold(
                backgroundColor: Colors.transparent,
                body: RepaintBoundary(
                    key: provider.repaintBoundary,
                    child: Container(
                      height: AppDestination.CARD_HEIGHT,
                      width: AppDestination.CARD_WIGHT,
                      color: Colors.white,
                      child: new Center(child: cardTemplate(badgeTemplate)),
                    )),
              ),
              Background(
                isShowBack: true,
                isShowLogo: false,
                isAnimation: true,
                isShowClock: true,
                isShowChatBox: false,
                enableScroll: true,
                isShowStepper: true,
                scrollController: provider.scrollController,
                type: BackgroundType.MAIN,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 0),
                  child: Selector<SurveyNotifier, bool>(
                    builder: (context, data, child) => Column(children: buildChildren(),),
                    selector: (buildContext, provider) => provider.isReload,
                  ),
                ),
              )
            ],
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

  Widget cardTemplate(String badgeIndex) {
    return TemplatePrint(
      visitorName: provider.visitor.fullName ?? "",
      phoneNumber: provider.visitor.phoneNumber ?? "",
      fromCompany: provider.visitor.fromCompany ?? "",
      toCompany: provider.visitor.toCompany ?? "",
      visitorType: provider.visitorType,
      idCard: provider.visitor.idCard ?? "",
      indexTemplate: badgeIndex,
      printerModel: provider.printer,
      inviteCode: provider.inviteCode,
      badgeTemplate: null,
      isBuilding: provider.isBuilding,
      floor: provider.visitor.floor,
    );
  }

  List<Widget> buildChildren() {
    List<Widget> children = List();
    for (int index = 0;index<provider.listItem.length + 2;index++) {
      if (index == 0) {
        children.add(Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 20, bottom: 10),
          child: Text(
            provider.utilities.getStringByLang(provider?.surveyForm?.customFormData?.title, provider.langSaved),
            style: TextStyle(fontSize: 29, color: Colors.black, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ));
      } else if (index == provider.listItem.length + 1) {
        children.add(buildBtnNext(context));
      } else {
        var item = SurveyItemWidget(
          surveyModel: provider.listItem[index - 1],
          isValidate: provider.isValidate,
          lang: provider.langSaved,
          listOld: provider.listOld,
          onChangeValue: () {
            provider.checkingValidator(provider.listItem[index - 1]);
          },
        );
        children.add(item);
      }
    }
    return children;
  }

  Widget buildBtnNext(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 60 : 40;
    var provider = Provider.of<SurveyNotifier>(context, listen: false);
    return Container(
      padding: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: SizedBox(
        width: SizeConfig.blockSizeHorizontal * percentBox,
        child: RaisedGradientButton(
          isLoading: (provider.isQRScan && !provider.isCapture),
          btnController: provider.btnController,
          disable: false,
          btnText: provider.appLocalizations.translate(AppString.BTN_CONTINUE),
          onPressed: () {
            provider.moveToNext(context);
          },
        ),
      ),
    );
  }
}
