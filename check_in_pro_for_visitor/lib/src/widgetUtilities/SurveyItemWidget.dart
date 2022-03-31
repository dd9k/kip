import 'dart:convert';
import 'dart:math';

import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/QuestionSurvey.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/radioGroupButton/RadioButtonBuilder.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'TypeHead.dart';
import 'radioGroupButton/RadioButtonTextPosition.dart';
import 'radioGroupButton/RadioGroup.dart';

typedef onChanged = Function();

class SurveyItemWidget extends StatefulWidget {
  final onChanged onChangeValue;
  final bool isValidate;
  final String lang;
  QuestionSurvey surveyModel;
  List<QuestionSurvey> listOld;

  SurveyItemWidget(
      {@required this.surveyModel, @required this.isValidate, @required this.lang, @required this.onChangeValue, @required this.listOld});

  @override
  _SurveyItemWidgetState createState() => _SurveyItemWidgetState();
}

class _SurveyItemWidgetState extends State<SurveyItemWidget> {
  bool isInit = false;
  final List<String> temperature = [" °C", " °F"];
  TextEditingController controllerDropDown = TextEditingController();
  TextEditingController controller = TextEditingController();
  GlobalKey<SimpleGroupedCheckboxState<int>> mutlicheckboxKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isError() ? AppColor.RED_SUB_COLOR : Colors.transparent,
      padding: EdgeInsets.only(left: 20, right: 64),
      margin: EdgeInsets.only(top: isError() ? 10 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, child: buildQuestion(),),
          SizedBox(
            height: 5,
          ),
          SizedBox(width: (widget.surveyModel.getSurveyType() == QuestionType.TEMPERATURE) ? 300 : double.infinity, child: buildValue(),),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: isError(),
            child: Text(
              widget.surveyModel.errorText,
              style: TextStyle(color: AppColor.RED_COLOR),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget buildQuestion() {
    double fontSize = 22;
    if (widget.surveyModel.isRequired == 1) {
      return RichText(
          maxLines: 2,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: Utilities().getStringByLang(widget.surveyModel.question, widget.lang),
                  style:
                      TextStyle(fontSize: fontSize, height: 2, color: AppColor.MAIN_TEXT_COLOR, fontWeight: FontWeight.w500)),
              TextSpan(
                  text: "*",
                  style: TextStyle(fontSize: fontSize, height: 2, color: AppColor.RED_COLOR, fontWeight: FontWeight.w500)),
            ],
          ));
    }
    return Text(
      Utilities().getStringByLang(widget.surveyModel.question, widget.lang),
      style: TextStyle(fontSize: fontSize, height: 2, color: AppColor.MAIN_TEXT_COLOR, fontWeight: FontWeight.w500),
    );
  }

  bool isError() => (widget.isValidate && widget.surveyModel.errorText?.isNotEmpty == true);

  Widget buildValue() {
    switch (widget.surveyModel.getSurveyType()) {
      case QuestionType.EDIT_TEXT:
        {
          if (!isInit) {
            isInit = true;
            controller.text = widget.surveyModel.getPreText(widget.listOld, widget.lang);
          }
          return TextFormField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: getKeyBoardType(),
              controller: controller,
              textInputAction: TextInputAction.done,
              inputFormatters: inputFormat(),
              maxLines: 1,
              onEditingComplete: () {
                Utilities().hideKeyBoard(context);
              },
              onTap: () {},
              onChanged: (text) {
                setState(() {
                  Utilities().moveToWaiting();
                  widget.surveyModel.getAnswer().clear();
                  if (text.isNotEmpty) {
                    Map<String, String> mapValue = Map();
                    mapValue[Constants.VN_CODE] = text;
                    mapValue[Constants.EN_CODE] = text;
                    String value = jsonEncode(mapValue);
                    widget.surveyModel.getAnswer().add(value);
                  }
                  widget.onChangeValue();
                });
              },
              style: Styles.formFieldText);
        }
      case QuestionType.TEMPERATURE:
        {
          if (!isInit) {
            isInit = true;
            controllerDropDown.text = temperature[0];
            var preText = widget.surveyModel.getPreText(widget.listOld, widget.lang);
            if (preText.isNotEmpty) {
              var number = preText.replaceAll(RegExp("[^\\d.]"), "");
              var secondText = preText.replaceAll(" ", "").replaceAll(number, "");
              controller.text = number;
              var indexTem = (temperature.indexOf(" " + secondText) != -1) ? temperature.indexOf(" " + secondText) : 0;
              controllerDropDown.text = temperature[indexTem];
            }
          }
          return Wrap(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDestination.RADIUS_TEXT_INPUT - 1),
                  ),

                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 7,
                      child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.number,
                          controller: controller,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(5),
                          ],
                          decoration: InputDecoration(enabledBorder: InputBorder.none, border: InputBorder.none),
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          onEditingComplete: () {
                            Utilities().hideKeyBoard(context);
                          },
                          onTap: () {},
                          onChanged: (text) {
                            setState(() {
                              Utilities().moveToWaiting();
                              widget.surveyModel.getAnswer()?.clear();
                              if (text.isNotEmpty) {
                                Map<String, String> mapValue = Map();
                                mapValue[Constants.VN_CODE] = text + controllerDropDown.text;
                                mapValue[Constants.EN_CODE] = text + controllerDropDown.text;
                                String value = jsonEncode(mapValue);
                                widget.surveyModel.getAnswer().add(value);
                              }
                              widget.onChangeValue();
                            });
                          },
                          style: Styles.formFieldText),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(width: 1.5, color: AppColor.MAIN_TEXT_COLOR),
                          ),
                          color: Colors.white,
                        ),
                        child: TypeAheadField<dynamic>(
                          hideSuggestionsOnKeyboardHide: false,
                          noItemsFoundBuilder: (context) => Container(),
                          getImmediateSuggestions: true,
                          hideOnLoading: true,
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                                  side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                              constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * 60)),
                          textFieldConfiguration: TextFieldConfiguration(
                            readOnly: true,
                            showCursor: false,
                            onTap: () {
                              Utilities().moveToWaiting();
                            },
                            decoration: InputDecoration(
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 32,
                                  color: AppColor.BLACK_TEXT_COLOR,
                                )),
                            onSubmitted: (_) async {},
                            controller: controllerDropDown,
                            onChanged: (text) {},
                            style: TextStyle(fontSize: 20, height: 1.25, fontWeight: FontWeight.bold),
                          ),
                          suggestionsCallback: (String pattern) {
                            return temperature;
                          },
                          transitionBuilder: (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          itemBuilder: (context, dynamic suggestion) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 23.0, top: 5, bottom: 5, right: 20),
                              child: Text(suggestion,
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
                            );
                          },
                          onSuggestionSelected: (dynamic suggestion) async {
                            setState(() {
                              Utilities().moveToWaiting();
                              widget.surveyModel.getAnswer()?.clear();
                              if (suggestion.isNotEmpty) {
                                Map<String, String> mapValue = Map();
                                mapValue[Constants.VN_CODE] = controller.text + suggestion;
                                mapValue[Constants.EN_CODE] = controller.text + suggestion;
                                String value = jsonEncode(mapValue);
                                widget.surveyModel.getAnswer().add(value);
                              }
                            });
                            controllerDropDown.text = suggestion;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      case QuestionType.RADIO_BUTTON:
        {
          List<String> preValue = List();
          if (!isInit) {
            isInit = true;
            preValue = widget.surveyModel.getPreValue(widget.listOld);
            widget.surveyModel.getAnswer().addAll(preValue);
          }
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: SimpleGroupedCheckbox<String>(
                key: mutlicheckboxKey,
                itemsTitle: widget.surveyModel.getAnswerOptionLang(widget.lang),
                values: widget.surveyModel.getAnswerOption(),
                activeColor: AppColor.MAIN_TEXT_COLOR,
                checkFirstElement: false,
                isLeading: true,
                multiSelection: false,
                preSelection: preValue,
                onItemSelected: (data) {
                  setState(() {
                    Utilities().moveToWaiting();
                    Utilities().hideKeyBoard(context);
                    widget.surveyModel.getAnswer().clear();
                    widget.surveyModel.getAnswer().add(data);
                    widget.onChangeValue();
                  });
                },
              ),
            ),
          );
        }
      case QuestionType.CHECK_BOX:
        {
          List<String> preValue = List();
          if (!isInit) {
            isInit = true;
            preValue = widget.surveyModel.getPreValue(widget.listOld);
            widget.surveyModel.getAnswer().addAll(preValue);
          }
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListTileTheme(
              contentPadding: EdgeInsets.all(0),
              child: SimpleGroupedCheckbox<String>(
                key: mutlicheckboxKey,
                itemsTitle: widget.surveyModel.getAnswerOptionLang(widget.lang),
                values: widget.surveyModel.getAnswerOption(),
                activeColor: AppColor.MAIN_TEXT_COLOR,
                checkFirstElement: false,
                isLeading: true,
                preSelection: preValue,
                multiSelection: true,
                onItemSelected: (data) {
                  setState(() {
                    Utilities().moveToWaiting();
                    Utilities().hideKeyBoard(context);
                    widget.surveyModel.getAnswer().clear();
                    if (data.isNotEmpty) {
                      widget.surveyModel.getAnswer().addAll(data);
                    }
                    widget.onChangeValue();
                  });
                },
              ),
            ),
          );
        }
      case QuestionType.DROP_DOWN:
        {
          if (!isInit) {
            isInit = true;
            widget.surveyModel.getAnswer().clear();
            var preText = widget.surveyModel.getPreText(widget.listOld, widget.lang);
            if (preText.isNotEmpty) {
              widget.surveyModel.getAnswer().add(preText);
            } else if (widget.surveyModel.answerOption.isNotEmpty) {
              widget.surveyModel.getAnswer().add(widget.surveyModel.answerOption[0]);
            }
            controller.text = widget.surveyModel.getPreText(widget.listOld, widget.lang);
          }
          return TypeAheadField<dynamic>(
            hideSuggestionsOnKeyboardHide: false,
            noItemsFoundBuilder: (context) => Container(),
            getImmediateSuggestions: true,
            hideOnLoading: true,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                    side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                constraints: BoxConstraints(maxHeight: SizeConfig.safeBlockVertical * 60)),
            textFieldConfiguration: TextFieldConfiguration(
              readOnly: true,
              showCursor: false,
              decoration: InputDecoration(
                  suffixIcon: Icon(
                Icons.arrow_drop_down,
                size: 32,
                color: AppColor.BLACK_TEXT_COLOR,
              ),),
              onTap: () {
                Utilities().moveToWaiting();
              },
              onSubmitted: (_) async {},
              controller: controller
                ..text = (widget.surveyModel.getAnswer().isEmpty)
                    ? widget.surveyModel.getAnswerOptionValue(widget.surveyModel.answerOption[0], widget.lang)
                    : widget.surveyModel.getAnswerOptionValue(widget.surveyModel.getAnswerByIndex(0), widget.lang),
              onChanged: (text) {},
              style: Styles.formFieldText,
            ),
            suggestionsCallback: (String pattern) {
              return widget.surveyModel.getAnswerOption();
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, dynamic suggestion) {
              return itemDropDown(suggestion);
            },
            onSuggestionSelected: (dynamic suggestion) async {
              setState(() {
                Utilities().moveToWaiting();
                widget.surveyModel.getAnswer().clear();
                widget.surveyModel.getAnswer().add(suggestion);
                controller.text = widget.surveyModel.getAnswerOptionValue(suggestion, widget.lang);
                widget.onChangeValue();
              });
            },
          );
        }
      default:
        {
          return RadioGroup<String>.builder(
            direction: Axis.vertical,
            horizontalAlignment: MainAxisAlignment.spaceEvenly,
            groupValue: widget.surveyModel.getAnswerByIndex(0),
            onChanged: (value) => setState(() {
              Utilities().moveToWaiting();
              Utilities().hideKeyBoard(context);
              widget.surveyModel.getAnswer().clear();
              if (value.isNotEmpty) {
                widget.surveyModel.getAnswer().add(value);
              }
              widget.onChangeValue();
            }),
            items: widget.surveyModel.getAnswerOptionLang(widget.lang),
            itemBuilder: (item) => RadioButtonBuilder(
              widget.surveyModel.getAnswerOptionValue(item, widget.lang),
              textPosition: RadioButtonTextPosition.right,
            ),
          );
        }
    }
  }

  TextInputType getKeyBoardType() {
    switch (widget.surveyModel.getSurveySubType()) {
      case QuestionSubType.EMAIL:
        return TextInputType.emailAddress;

      case QuestionSubType.TEXT:
        return TextInputType.text;

      case QuestionSubType.PHONE:
        return TextInputType.phone;

      case QuestionSubType.NUMBER:
        return TextInputType.number;

      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> inputFormat() {
    switch (widget.surveyModel.getSurveySubType()) {
      case QuestionSubType.TEXT:
        {
          return <TextInputFormatter>[
            UpperCaseFirstLetterFormatter(),
            LengthLimitingTextInputFormatter(200),
          ];
        }

      case QuestionSubType.PHONE:
        return <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(13),
        ];

      case QuestionSubType.EMAIL:
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(200),
        ];

      case QuestionSubType.NUMBER:
        return <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(200),
        ];

      default:
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(200),
        ];
    }
  }

  Widget itemDropDown(String text) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 50 : 30;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Container(height: 32,),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 100 - 200,
              child: Text(widget.surveyModel.getAnswerOptionValue(text, widget.lang),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
            ),
            Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR)
          ],
        )
      ],
    );
  }
}
