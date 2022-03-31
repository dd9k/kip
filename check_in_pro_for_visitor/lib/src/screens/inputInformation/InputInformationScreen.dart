import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TypeHead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:provider/provider.dart';

import 'InputInformationNotifier.dart';

class InputInformationScreen extends MainScreen {
  static const String route_name = '/information';

  @override
  _InputInformationScreenState createState() => _InputInformationScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _InputInformationScreenState extends MainScreenState<InputInformationNotifier> {
  List<FocusNode> focusNodes = List();
  FocusNode currentNodes;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    provider.context = context;
    var percentBox = isPortrait ? 70 : 50;
    return FutureBuilder<List<CheckInFlow>>(
      future: provider.getCheckInFlow(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: () => Utilities().moveToWaiting(),
            child: Background(
              isShowStepper: !provider.isReplace,
              isShowBack: true,
              isShowClock: true,
              isOpeningKeyboard: !provider.isShowLogo,
              isShowFooter: provider.isShowFooter,
              isShowLogo: provider.isShowLogo,
              isShowChatBox: false,
              isAnimation: true,
              initState: !provider.parent.isOnlineMode,
              messSnapBar: appLocalizations.messOffMode,
              scrollController: provider.scrollController,
              contentChat: AppLocalizations.of(context).translate(AppString.MESSAGE_INPUT_INFORMATION_CHATBOX),
              type: BackgroundType.MAIN,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: provider.formKey,
                    child: Container(
                        width: SizeConfig.safeBlockHorizontal * percentBox,
                        child: Selector<InputInformationNotifier, VisitorType>(
                          builder: (context, data, child) {
                            return Column(
                              children: renderWidgetByType(provider.flows),
                            );
                          },
                          selector: (context, provider) => provider.visitorType,
                        )),
                  )
                ],
              ),
            ),
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
    provider.isShowFooter = !visible;
    provider.hideLoading = false;
  }

  List<Widget> renderWidgetByType(List<CheckInFlow> flows) {
    List<Widget> list = List();
    provider.visitorTypeItem?.isVisible = false;
    provider.noteItem?.isVisible = false;
    provider.genderItem?.isVisible = false;
    provider.fromCompanyItem?.isVisible = false;
    provider.companyBuildingItem?.isVisible = false;

    flows.asMap().forEach((index, CheckInFlow value) {
      CheckInFlow item = value;
      item.isVisible = true;
      var radius = item.stepType == StepType.MULTIPLE_TEXT
          ? AppDestination.RADIUS_TEXT_INPUT_BIG
          : AppDestination.RADIUS_TEXT_INPUT;
      var labelText = (item.isRequired != null &&
              (item.getRequestType() == RequestType.ALWAYS_NO || item.getRequestType() == RequestType.FIRST_NO))
          ? "${Utilities.titleCase(item.stepName)} (${AppLocalizations.of(context).optionalField})"
          : Utilities.titleCase(item.stepName);
      var widgetChild;
      switch (item.stepCode) {
        case StepCode.VISITOR_TYPE:
          {
            provider.initItemFlow(item, index, provider.controllerType, focusNodes);
            widgetChild = buildVisitorType(item, labelText, radius);
            break;
          }
        case StepCode.TO_COMPANY:
          {
            if (provider.isBuilding) {
              provider.initItemFlow(item, index, provider.controllerTo, focusNodes);
              widgetChild = buildCompanyBuilding(provider.flows, item, labelText, radius);
            } else {
              provider.initItemFlow(item, index, null, focusNodes);
              widgetChild = buildTextFormField(provider.flows, item, labelText, radius);
            }
            break;
          }
        case StepCode.FROM_COMPANY:
          {
            var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
            var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
            var percentSuggestHeight = isPortrait ? 50 : 30;
            if (item.initValue.isEmpty) {
              item.initValue = visitorCheckIn.fromCompany;
            }
            provider.initItemFlow(item, index, provider.controllerFrom, focusNodes);
            widgetChild = searchFromCompany(percentSuggestHeight, item, context, provider.flows, labelText);
            break;
          }
        case StepCode.PURPOSE:
          {
            var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
            var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
            var percentSuggestHeight = isPortrait ? 50 : 30;
            if (item.initValue.isEmpty) {
              item.initValue = visitorCheckIn.purpose;
            }
            provider.initItemFlow(item, index, provider.controllerNote, focusNodes);
            widgetChild = buildSuggestionNote(percentSuggestHeight, item, context, provider.flows, labelText);
            break;
          }
        case StepCode.GENDER:
          {
            var arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
            var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
            var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
            var percentSuggestHeight = isPortrait ? 50 : 30;
            if (item.initValue.isEmpty) {
              item.initValue = visitorCheckIn.getGender(context);
            }
            provider.initItemFlow(item, index, provider.controllerGender, focusNodes);
            widgetChild = buildSuggestionGender(percentSuggestHeight, item, context, provider.flows, labelText);
            break;
          }
        default:
          {
            provider.initItemFlow(item, index, null, focusNodes);
            widgetChild = buildTextFormField(provider.flows, item, labelText, radius);
            break;
          }
      }
      list.add(GestureDetector(
        onTap: () => Utilities().moveToWaiting(),
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Form(
            key: provider.keyList[item.index],
            child: widgetChild,
          ),
        ),
      ));
    });
    list.add(Visibility(
      visible: provider.isLoading == false,
      child: _buildBtnLogin(context),
    ));
    list.add(SizedBox(
      height: Constants.HEIGHT_BUTTON + 40,
    ));
    return list;
  }

  Widget searchFromCompany(
    int percentSuggestHeight,
    CheckInFlow item,
    BuildContext context,
    List<CheckInFlow> convertList,
    String labelText,
  ) {
    if (provider.controllerFrom.text == null || provider.controllerFrom.text.isEmpty) {
      provider.controllerFrom.value = TextEditingValue(text: (item.initValue != null) ? item.initValue : "");
    }
    provider.fromCompanyItem = item;
    return Selector<InputInformationNotifier, bool>(
      builder: (context, data, child) => Selector<InputInformationNotifier, String>(
        builder: (context, data, child) {
          return TypeAheadField<String>(
            hideSuggestionsOnKeyboardHide: false,
            hideOnLoading: true,
            noItemsFoundBuilder: (context) => itemNone(),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                    side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * percentSuggestHeight)),
            textFieldConfiguration: TextFieldConfiguration(
              textCapitalization: TextCapitalization.sentences,
              focusNode: focusNodes[item.index],
              inputFormatters: provider.inputFormat(item),
              onTap: () {
                Utilities().moveToWaiting();
                if (item.index > 0) {
                  provider.validateFieldBefore(item.index - 1);
                }
                scrollView(item, 500);
              },
              onSubmitted: (_) async {
                if ((item.index + 1) == provider.flows.length) {
                  Utilities().hideKeyBoard(context);
                  bool isValidate = true;
                  provider.keyList.forEach((key) {
                    if (!key.currentState.validate()) {
                      isValidate = false;
                      return;
                    }
                  });
                  await provider.checkIsNext(context, isValidate, true);
                } else {
                  nextFocus(context, item, convertList);
                }
              },
              controller: provider.controllerFrom,
              onChanged: (text) {
                item.initValue = text;
                Utilities().moveToWaiting();
              },
              style: Styles.formFieldText,
              decoration: InputDecoration(
                errorText: provider.errorFromCompany,
                suffixIcon: (provider.valueFocus == item.stepCode)
                    ? GestureDetector(
                        onTap: () {
                          provider.controllerFrom.text = "";
                          item.initValue = "";
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
                border: OutlineInputBorder(),
                labelText: labelText,
                hintStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
              ),
            ),
            suggestionsCallback: (String pattern) async {
              return await provider.getSuggestionFromCompany(pattern);
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, String suggestion) {
              return itemFromCompany(suggestion);
            },
            onSuggestionSelected: (String suggestion) async {
              Utilities().moveToWaiting();
              provider.controllerFrom.text = suggestion;
              item.initValue = suggestion;
              if ((item.index + 1) == provider.flows.length) {
                Utilities().hideKeyBoard(context);
                bool isValidate = true;
                provider.keyList.forEach((key) {
                  if (!key.currentState.validate()) {
                    isValidate = false;
                    return;
                  }
                });
                await provider.checkIsNext(context, isValidate, false);
              } else {
                nextFocus(context, item, convertList);
              }
            },
          );
        },
        selector: (buildContext, provider) => provider.valueFocus,
      ),
      selector: (buildContext, provider) => provider.isReloadFrom,
    );
  }

  Widget buildSuggestionGender(
    int percentSuggestHeight,
    CheckInFlow item,
    BuildContext context,
    List<CheckInFlow> convertList,
    String labelText,
  ) {
    if (provider.controllerGender.text == null || provider.controllerGender.text.isEmpty) {
      provider.controllerGender.value = TextEditingValue(text: (item.initValue != null) ? item.initValue : "");
    }
    provider.genderItem = item;
    return Selector<InputInformationNotifier, bool>(
      builder: (context, data, child) => Selector<InputInformationNotifier, String>(
        builder: (context, data, child) {
          return TypeAheadField<String>(
            hideSuggestionsOnKeyboardHide: false,
            hideOnLoading: true,
            noItemsFoundBuilder: (context) => itemNone(),
            getImmediateSuggestions: true,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                    side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * percentSuggestHeight)),
            textFieldConfiguration: TextFieldConfiguration(
              readOnly: true,
              showCursor: false,
              focusNode: focusNodes[item.index],
              onTap: () {
                if (item.index > 0) {
                  provider.validateFieldBefore(item.index - 1);
                }
                Utilities().moveToWaiting();
              },
              onSubmitted: (_) async {},
              controller: provider.controllerGender,
              onChanged: (text) {
                Utilities().moveToWaiting();
              },
              style: Styles.formFieldText,
              decoration: InputDecoration(
                errorText: provider.errorGender,
                suffixIcon: (provider.valueFocus == item.stepCode)
                    ? GestureDetector(
                        onTap: () {
                          provider.controllerGender.text = "";
                          item.initValue = "";
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
                border: OutlineInputBorder(),
                labelText: labelText,
                hintStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
              ),
            ),
            suggestionsCallback: (String pattern) async {
              return [AppLocalizations.of(context).male, AppLocalizations.of(context).female];
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, String suggestion) {
              return itemGender(suggestion);
            },
            onSuggestionSelected: (String suggestion) async {
              Utilities().moveToWaiting();
              provider.controllerGender.text = suggestion;
              await Future.delayed(const Duration(milliseconds: 250));
              if ((item.index + 1) == provider.flows.length) {
                Utilities().hideKeyBoard(context);
                bool isValidate = true;
                provider.keyList.forEach((key) {
                  if (!key.currentState.validate()) {
                    isValidate = false;
                    return;
                  }
                });
//                    if (isValidate) {
//                      moveToNextPage();
//                    }
              } else {
                FocusScope.of(context).requestFocus(focusNodes[item.index + 1]);
                currentNodes = focusNodes[item.index + 1];
                provider.validateFieldBefore(item.index);
              }
            },
          );
        },
        selector: (buildContext, provider) => provider.valueFocus,
      ),
      selector: (buildContext, provider) => provider.isReloadGender,
    );
  }

  Widget buildSuggestionNote(
    int percentSuggestHeight,
    CheckInFlow item,
    BuildContext context,
    List<CheckInFlow> convertList,
    String labelText,
  ) {
    if (provider.controllerNote.text == null || provider.controllerNote.text.isEmpty) {
      provider.controllerNote.value = TextEditingValue(text: (item.initValue != null) ? item.initValue : "");
    }
    provider.noteItem = item;
    return Selector<InputInformationNotifier, bool>(
      builder: (context, data, child) => Selector<InputInformationNotifier, String>(
        builder: (context, data, child) {
          return TypeAheadField<String>(
            hideSuggestionsOnKeyboardHide: false,
            hideOnLoading: true,
            noItemsFoundBuilder: (context) => itemNone(),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                    side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * percentSuggestHeight)),
            textFieldConfiguration: TextFieldConfiguration(
              textCapitalization: TextCapitalization.sentences,
              focusNode: focusNodes[item.index],
              inputFormatters: provider.inputFormat(item),
              onTap: () {
                Utilities().moveToWaiting();
                if (item.index > 0) {
                  provider.validateFieldBefore(item.index - 1);
                }
                scrollView(item, 500);
              },
              onSubmitted: (_) async {
                if ((item.index + 1) == provider.flows.length) {
                  Utilities().hideKeyBoard(context);
                  bool isValidate = true;
                  provider.keyList.forEach((key) {
                    if (!key.currentState.validate()) {
                      isValidate = false;
                      return;
                    }
                  });
                  await provider.checkIsNext(context, isValidate, true);
                } else {
                  nextFocus(context, item, convertList);
                }
              },
              controller: provider.controllerNote,
              onChanged: (text) {
                item.initValue = text;
                Utilities().moveToWaiting();
              },
              style: Styles.formFieldText,
              decoration: InputDecoration(
                errorText: provider.errorNote,
                suffixIcon: (provider.valueFocus == item.stepCode)
                    ? GestureDetector(
                        onTap: () {
                          provider.controllerNote.text = "";
                          item.initValue = "";
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
                border: OutlineInputBorder(),
                labelText: labelText,
                hintStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return provider.getSuggestionNote(pattern);
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, String suggestion) {
              return itemFromCompany(suggestion);
            },
            onSuggestionSelected: (String suggestion) async {
              Utilities().moveToWaiting();
              provider.controllerNote.text = suggestion;
              item.initValue = suggestion;
              if ((item.index + 1) == provider.flows.length) {
                Utilities().hideKeyBoard(context);
                bool isValidate = true;
                provider.keyList.forEach((key) {
                  if (!key.currentState.validate()) {
                    isValidate = false;
                    return;
                  }
                });
                await provider.checkIsNext(context, isValidate, false);
              } else {
                nextFocus(context, item, convertList);
              }
            },
          );
        },
        selector: (buildContext, provider) => provider.valueFocus,
      ),
      selector: (buildContext, provider) => provider.isReloadNote,
    );
  }

  Widget itemFromCompany(String fromCompany) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 50 : 30;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.public,
            size: 32,
            color: AppColor.HINT_TEXT_COLOR,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * percentBox,
              child: Text(fromCompany,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        )
      ],
    );
  }

  Widget itemCompanyBuilding(CompanyBuilding companyBuilding) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var widthText = isPortrait ? SizeConfig.safeBlockHorizontal * 70 : SizeConfig.safeBlockVertical * 50;
    return FutureBuilder<File>(
      future: Utilities().getLocalFile(
          Constants.FOLDER_TEMP, Constants.FILE_TYPE_COMPANY_BUILDING, companyBuilding.index.toString(), null),
      builder: (context, snapshot) {
        Image image;
        if (snapshot.hasData) {
          try {
            image = Image.memory(
              snapshot.data.readAsBytesSync(),
              width: 40,
              height: 40,
            );
          } catch (e) {
            image = Image.asset(
              "assets/images/waiting0.png",
              cacheWidth: 40,
              cacheHeight: 40,
            );
          }
        } else {
          image = null;
        }
        return Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: image ?? Container(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    width: widthText - 63,
                    padding: EdgeInsets.only(bottom: 10, top: 10),
                    child: AutoSizeText(companyBuilding.companyName,
                        maxLines: 3,
                        minFontSize: 8,
                        maxFontSize: 16,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5))),
              ],
            )
          ],
        );
      },
    );
  }

  Widget buildCompanyBuilding(List<CheckInFlow> dataSources, CheckInFlow item, String labelText, double radius) {
    var convertList = List<CheckInFlow>();
    convertList.addAll(dataSources);
    convertList.removeWhere((element) => element.stepCode == StepCode.CAPTURE_FACE);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentSuggestHeight = isPortrait ? 50 : 30;
    return Selector<InputInformationNotifier, bool>(
      builder: (context, data, child) => FutureBuilder<List<CompanyBuilding>>(
          future: provider.getCompanyBuilding(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              provider.buildInitValueTypeHead();
              var companyBuilding = snapshot.data;
              if (companyBuilding.isEmpty) {
                return buildTextFormField(dataSources, item, labelText, radius);
              }
              if (item.initValue.isEmpty) {
                item.initValue = provider.initValueBuilding;
              }
              provider.companyBuildingItem = item;
              return searchToCompany(percentSuggestHeight, item, context, convertList, labelText, companyBuilding);
            } else {
              if (snapshot.connectionState == ConnectionState.done) return Container();
              return CircularProgressIndicator();
            }
          }),
      selector: (buildContext, provider) => provider.isReloadCompany,
    );
  }

  Widget searchToCompany(int percentSuggestHeight, CheckInFlow item, BuildContext context,
      List<CheckInFlow> convertList, String labelText, List<CompanyBuilding> companyBuilding) {
    if (provider.controllerTo.text == null || provider.controllerTo.text.isEmpty) {
      provider.controllerTo.value = TextEditingValue(text: (item.initValue != null) ? item.initValue : "");
    }
    return Selector<InputInformationNotifier, String>(
      builder: (context, data, child) {
        return TypeAheadField<CompanyBuilding>(
          hideSuggestionsOnKeyboardHide: false,
          hideOnLoading: true,
          noItemsFoundBuilder: (context) => itemNone(),
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                  side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
              constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * percentSuggestHeight)),
          textFieldConfiguration: TextFieldConfiguration(
            textCapitalization: TextCapitalization.sentences,
            focusNode: focusNodes[item.index],
            inputFormatters: provider.inputFormat(item),
            onTap: () {
              Utilities().moveToWaiting();
              if (item.index > 0) {
                provider.validateFieldBefore(item.index - 1);
              }
              scrollView(item, 500);
            },
            onSubmitted: (_) async {
              if ((item.index + 1) == provider.flows.length) {
                Utilities().hideKeyBoard(context);
                bool isValidate = true;
                provider.keyList.forEach((key) {
                  if (!key.currentState.validate()) {
                    isValidate = false;
                    return;
                  }
                });
                await provider.checkIsNext(context, isValidate, false);
              } else {
                nextFocus(context, item, convertList);
              }
            },
            controller: provider.controllerTo,
            onChanged: (text) {
              item.initValue = text;
              Utilities().moveToWaiting();
              provider.companyBuilding = null;
            },
            style: Styles.formFieldText,
            decoration: InputDecoration(
              errorText: provider.errorToCompany,
              suffixIcon: (provider.valueFocus == item.stepCode)
                  ? GestureDetector(
                      onTap: () {
                        provider.controllerTo.text = "";
                        item.initValue = "";
                        provider.companyBuilding = null;
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
              border: OutlineInputBorder(),
              labelText: labelText,
              hintStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
            ),
          ),
          suggestionsCallback: (String pattern) async {
            return await provider.getSuggestionOffice(companyBuilding, pattern);
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          itemBuilder: (context, CompanyBuilding suggestion) {
            return itemCompanyBuilding(suggestion);
          },
          onSuggestionSelected: (CompanyBuilding suggestion) {
            Utilities().moveToWaiting();
            provider.controllerTo.text = suggestion.companyName;
            item.initValue = suggestion.companyName;
            provider.errorToCompany = null;
            provider.companyBuilding = suggestion;
            if ((item.index + 1) == provider.flows.length) {
              Utilities().hideKeyBoard(context);
              bool isValidate = true;
              provider.keyList.forEach((key) {
                if (!key.currentState.validate()) {
                  isValidate = false;
                  return;
                }
              });
//              if (isValidate) {
//                moveToNextPage();
//              }
            } else {
              nextFocus(context, item, convertList);
            }
          },
        );
      },
      selector: (buildContext, provider) => provider.valueFocus,
    );
  }

  Widget buildTextFormField(List<CheckInFlow> dataSources, CheckInFlow item, String labelText, double radius) {
    var convertList = List<CheckInFlow>();
    convertList.addAll(dataSources);
    convertList.removeWhere((element) => element.stepCode == StepCode.CAPTURE_FACE);

    return Selector<InputInformationNotifier, String>(
      builder: (context, data, child) {
        return TextFormField(
            controller: provider.textEditingControllers[item.stepCode],
            validator: provider.checkingValidator(item),
            textCapitalization: provider.checkingCapitalization(item),
            keyboardType: provider.getKeyBoardType(item.stepType),
            textInputAction: TextInputAction.done,
            inputFormatters: provider.inputFormat(item),
            maxLines: item.stepType == StepType.MULTIPLE_TEXT ? 3 : 1,
            focusNode: focusNodes[item.index],
            decoration: InputDecoration(
              suffixIcon: (provider.valueFocus == item.stepCode)
                  ? GestureDetector(
                      onTap: () {
                        provider.textEditingControllers[item.stepCode].text = "";
                        item.initValue = '';
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
              labelText: labelText,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radius),
                  ),
                  borderSide: new BorderSide(color: AppColor.MAIN_TEXT_COLOR)),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius),
                ),
                borderSide: new BorderSide(color: AppColor.RED_COLOR),
              ),
            ),
            onEditingComplete: () async {
              //Condition hide keyboard
              if ((item.index + 1) == provider.flows.length) {
                Utilities().hideKeyBoard(context);
                bool isValidate = true;
                provider.keyList.forEach((key) {
                  if (key.currentState?.validate() == false) {
                    isValidate = false;
                    return;
                  }
                });
                await provider.checkIsNext(context, isValidate, true);
              } else {
                nextFocus(context, item, convertList);
              }
            },
            onTap: () {
              if (item.index > 0) {
                provider.validateFieldBefore(item.index - 1);
              }
            },
            onChanged: (text) {
              item.initValue = text;
              Utilities().moveToWaiting();
            },
            style: Styles.formFieldText);
      },
      selector: (buildContext, provider) => provider.valueFocus,
    );
  }

  void nextFocus(BuildContext context, CheckInFlow item, List<CheckInFlow> convertList) {
    FocusScope.of(context).requestFocus(focusNodes[item.index + 1]);
    currentNodes = focusNodes[item.index + 1];
    provider.validateFieldBefore(item.index);
    provider.keyList[item.index].currentState.validate();
    var stepCode = convertList[item.index + 1].stepCode;
    if (stepCode == StepCode.TO_COMPANY || stepCode == StepCode.FROM_COMPANY || stepCode == StepCode.PURPOSE) {
      scrollView(convertList[item.index + 1], 500);
    }
  }

  void scrollView(CheckInFlow item, int duration) {
    if ((item.index > 1 || focusNodes.length < 3) &&
        (!focusNodes[item.index].hasFocus || (focusNodes[item.index].hasFocus && provider.isShowLogo))) {
      Future.delayed(Duration(milliseconds: duration), () {
        provider.scrollController.animateTo(
          (Constants.HEIGHT_BUTTON + 20) * item.index,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }

  Widget buildVisitorType(CheckInFlow item, String labelText, double radius) {
    return Selector<InputInformationNotifier, bool>(
      builder: (context, data, child) {
        provider.visitorTypeItem = item;
        var visitorType = provider.listType;
        if (provider.visitorBackup != null && provider.visitorType == null) {
          provider.indexInitType = provider.getTypeInit(visitorType);
          provider.visitorType =
              (provider.indexInitType != null) ? visitorType[provider.indexInitType] : provider.indexInitType;
        }
        var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
        var percentSuggestHeight = isPortrait ? 50 : 30;
        if (provider.controllerType.text == null || provider.controllerType.text.isEmpty) {
          provider.controllerType.value = TextEditingValue(
              text: (provider.indexInitType != null)
                  ? visitorType[provider.indexInitType].description
                  : visitorType[0].description);
        }
        return TypeAheadField<VisitorType>(
          hideSuggestionsOnKeyboardHide: false,
          hideOnLoading: true,
          noItemsFoundBuilder: (context) => itemNone(),
          getImmediateSuggestions: true,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                  side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
              constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * percentSuggestHeight)),
          textFieldConfiguration: TextFieldConfiguration(
            readOnly: true,
            showCursor: false,
            focusNode: focusNodes[item.index],
            onTap: () {
              if (item.index > 0) {
                provider.validateFieldBefore(item.index - 1);
              }
              Utilities().moveToWaiting();
            },
            onSubmitted: (_) async {},
            controller: provider.controllerType,
            onChanged: (text) {
              Utilities().moveToWaiting();
            },
            style: Styles.formFieldText,
            decoration: InputDecoration(
              errorText: provider.errorVisitorType,
              suffixIcon: (provider.valueFocus == item.stepCode)
                  ? GestureDetector(
                      onTap: () {
                        provider.controllerType.text = "";
                        item.initValue = "";
                        provider.visitorType = null;
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
              border: OutlineInputBorder(),
              labelText: labelText,
              hintStyle: TextStyle(fontSize: 20, color: AppColor.MAIN_TEXT_COLOR),
            ),
          ),
          suggestionsCallback: (String pattern) async {
            return await provider.getVisitorType(context);
          },
          transitionBuilder: (context, suggestionsBox, controller) {
            return suggestionsBox;
          },
          itemBuilder: (context, VisitorType suggestion) {
            return itemVisitorType(suggestion);
          },
          onSuggestionSelected: (VisitorType suggestion) async {
            Utilities().moveToWaiting();
            provider.reloadFlow(suggestion);
            await Future.delayed(const Duration(milliseconds: 250));
            if ((item.index + 1) == provider.flows.length) {
              Utilities().hideKeyBoard(context);
              bool isValidate = true;
              provider.keyList.forEach((key) {
                if (!key.currentState.validate()) {
                  isValidate = false;
                  return;
                }
              });
//                    if (isValidate) {
//                      moveToNextPage();
//                    }
            } else {
              FocusScope.of(context).requestFocus(focusNodes[item.index + 1]);
              currentNodes = focusNodes[item.index + 1];
              provider.validateFieldBefore(item.index);
            }
          },
        );
      },
      selector: (buildContext, provider) => provider.isReloadType,
    );
  }

  Widget itemVisitorType(VisitorType visitorType) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 50 : 30;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.person,
            size: 32,
            color: AppColor.HINT_TEXT_COLOR,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * percentBox,
              child: Text(visitorType.description,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        )
      ],
    );
  }

  Widget itemGender(String gender) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 50 : 30;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.person,
            size: 32,
            color: AppColor.HINT_TEXT_COLOR,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * percentBox,
              child:
                  Text(gender, style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        )
      ],
    );
  }

  Widget itemNone() {
    return Visibility(
      child: Container(),
      visible: false,
    );
  }

  Widget _buildBtnLogin(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedGradientButton(
        disable: false,
        btnText: AppLocalizations.of(context).translate(AppString.BTN_NEXT),
        onPressed: () async {
          bool isValidate = true;
          Utilities().hideKeyBoard(context);
          provider.keyList.forEach((key) {
            if (key.currentState?.validate() == false) {
              isValidate = false;
              return;
            }
          });
          provider.checkIsNext(context, isValidate, true);
        },
      ),
    );
  }

  @override
  void dispose() {
    focusNodes.forEach((element) {
      element.dispose();
    });
    currentNodes?.dispose();
    super.dispose();
  }
}
