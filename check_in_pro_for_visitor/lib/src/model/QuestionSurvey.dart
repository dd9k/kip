
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:json_annotation/json_annotation.dart';

part 'QuestionSurvey.g.dart';

enum QuestionType { DROP_DOWN, CHECK_BOX, RADIO_BUTTON, EDIT_TEXT, TEMPERATURE }

enum QuestionSubType { TEXT, EMAIL, PHONE, NUMBER }

@JsonSerializable()
class QuestionSurvey {
  @JsonKey(name: 'question')
  String question;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'answerOption')
  List<dynamic> answerOption;

  @JsonKey(name: 'answer')
  List<String> answer = List();

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'subType')
  String subType;

  @JsonKey(name: 'isRequired')
  int isRequired;

  @JsonKey(name: 'isHidden')
  int isHidden;

  @JsonKey(name: 'sort')
  int sort;

  @JsonKey(ignore: true)
  String errorText = "";

  QuestionSurvey(this.question, this.id, this.answerOption, this.answer, this.type, this.subType, this.isRequired, this.isHidden,
      this.sort);

  QuestionSurvey.submit(this.question, this.id, this.answer);

  QuestionSurvey._();

  factory QuestionSurvey.fromJson(Map<String, dynamic> json) => _$QuestionSurveyFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionSurveyToJson(this);

  List<String> getAnswer() {
    if (answer == null) {
      answer = List();
    }
    return answer;
  }

  String getAnswerByIndex(int index) {
    if (getAnswer().isNotEmpty) {
      return getAnswer()[index];
    }
    return "";
  }

  QuestionType getSurveyType() {
    switch (type) {
      case "1":
        {
          return QuestionType.RADIO_BUTTON;
        }
      case "2":
        {
          return QuestionType.CHECK_BOX;
        }
      case "3":
        {
          return QuestionType.DROP_DOWN;
        }
      case "4":
        {
          return QuestionType.EDIT_TEXT;
        }
      case "5":
        {
          return QuestionType.TEMPERATURE;
        }
      default:
        {
          return QuestionType.EDIT_TEXT;
        }
    }
  }

  QuestionSubType getSurveySubType() {
    switch (subType) {
      case "1":
        {
          return QuestionSubType.TEXT;
        }
      case "2":
        {
          return QuestionSubType.EMAIL;
        }
      case "3":
        {
          return QuestionSubType.PHONE;
        }
      case "4":
        {
          return QuestionSubType.NUMBER;
        }
      default:
        {
          return QuestionSubType.TEXT;
        }
    }
  }

  String getAnswerOptionValue(String option, String langSaved) {
    return Utilities().getStringByLang(option, langSaved);
  }

  List<String> getAnswerOption() {
    return List<String>.from(answerOption);
  }

  List<String> getAnswerOptionLang(String langSaved) {
    List<String> result = List();
    answerOption.forEach((element) {
      result.add(Utilities().getStringByLang(element, langSaved));
    });
    return result;
  }

  List<String> getPreValue(List<QuestionSurvey> listOld) {
    QuestionSurvey questionOld = getMatchQuestion(listOld);
    List<String> preValue = List();
    if (questionOld != null) {
      questionOld.getAnswer().forEach((answer) {
        answerOption.asMap().forEach((index, option) {
          if (getAnswerOptionValue(answer, Constants.VN_CODE).toLowerCase() == getAnswerOptionValue(option, Constants.VN_CODE).toLowerCase() || getAnswerOptionValue(answer, Constants.EN_CODE).toLowerCase() == getAnswerOptionValue(option, Constants.EN_CODE).toLowerCase()) {
            preValue.add(answerOption[index]);
          }
        });
      });
    }
    return preValue;
  }

  String getPreText(List<QuestionSurvey> listOld, String langSaved) {
    QuestionSurvey questionOld = getMatchQuestion(listOld);
    String preText = "";
    if (questionOld != null && questionOld.getAnswer().isNotEmpty) {
      if ((getSurveyType() == QuestionType.TEMPERATURE || getSurveyType() == QuestionType.EDIT_TEXT) && getSurveySubType() == questionOld.getSurveySubType()) {
        preText = Utilities().getStringByLang(questionOld.getAnswerByIndex(0), langSaved);
        getAnswer().add(questionOld.getAnswerByIndex(0));
      } else {
        questionOld.getAnswer().forEach((answer) {
          answerOption.asMap().forEach((index, option) {
            if (getAnswerOptionValue(answer, Constants.VN_CODE).toLowerCase() == getAnswerOptionValue(option, Constants.VN_CODE).toLowerCase() || getAnswerOptionValue(answer, Constants.EN_CODE).toLowerCase() == getAnswerOptionValue(option, Constants.EN_CODE).toLowerCase()) {
              preText = answerOption[index];
            }
          });
        });
      }
    }
    return preText;
  }

  QuestionSurvey getMatchQuestion(List<QuestionSurvey> listOld) {
    QuestionSurvey result;
    listOld.forEach((questionOld) {
      if (Utilities().getStringByLang(questionOld.question, Constants.VN_CODE).toLowerCase() == Utilities().getStringByLang(question, Constants.VN_CODE).toLowerCase() ||
          Utilities().getStringByLang(questionOld.question, Constants.EN_CODE).toLowerCase() == Utilities().getStringByLang(question, Constants.EN_CODE).toLowerCase()) {
        result = questionOld;
      }
    });
    return result;
  }

  QuestionSurvey createSubmit() {
    question = Utilities().validateJson(question);
    return this;
  }
}
