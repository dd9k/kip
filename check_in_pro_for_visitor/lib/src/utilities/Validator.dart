import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';

class Validator {
  static const String patternEmail = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
      "\\@" +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
      "(" +
      "\\." +
      "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
      ")+";

  static const String patternPhone = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  BuildContext context;

  Validator(this.context);

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please eneter your Full Name";
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(Validator.patternEmail);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return AppLocalizations.of(context).validateEmail;
    }
    return AppLocalizations.of(context).errorNoEmail;
  }

  String validateEmailWithoutRequire(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(Validator.patternEmail);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return AppLocalizations.of(context).validateEmail;
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate(AppString.MESSAGE_NO_PHONE);
    }
    RegExp regExp = new RegExp(Validator.patternPhone);
    if (value.length == 0) {
      return "Phone number is Required";
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).translate(AppString.MESSAGE_PHONE_LENGTH);
    }
    return null;
  }

  String validateQROrPhoneNumber(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).messageQRCodeOrPhoneNumber;
    }
    String patternQR = ".*[a-zA-Z].*";
    RegExp regExpQR = new RegExp(patternQR);
    if (regExpQR.hasMatch(value)) {
      return null;
    }
    RegExp regExp = new RegExp(Validator.patternPhone);
    if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).translate(AppString.MESSAGE_PHONE_LENGTH);
    }
    return null;
  }

  String validateQR(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).validateInviteCode;
    }
    return null;
  }

  String validateUserName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate(AppString.ERROR_NO_USERNAME);
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate(AppString.ERROR_NO_PASSWORD);
    }
    return null;
  }

  String validateDeviceName(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate(AppString.ERROR_NO_DEVICE_NAME);
    }
    return null;
  }

  String validateDomain(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).noDomain;
    }
    return null;
  }
}

class ValidatorLabel {
  BuildContext context;

  ValidatorLabel(this.context);

  String getStrParam = "";

  void setStrParam(String str) {
    getStrParam = str;
  }

  String validateName(String value) {
    if (value.isEmpty) {
      ;
      return AppLocalizations.of(context).errorNo.replaceAll("field_name", getStrParam);
    }
    if (!value.trim().contains(" ") || value.trim().length < 4) {
      return "${AppLocalizations.of(context).validate} ${getStrParam}";
    }
    return null;
  }

  String validateText(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).errorNo.replaceAll("field_name", getStrParam);
    }
    return null;
  }

  String validateEmail(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(Validator.patternEmail);
      if (regExp.hasMatch(value)) {
        return null;
      }
      return AppLocalizations.of(context).errorNo.replaceAll("field_name", getStrParam);
    }
    return AppLocalizations.of(context).errorNo.replaceAll("field_name", getStrParam);
  }

  String validateEmailWithoutRequire(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(Validator.patternEmail);
      if (!regExp.hasMatch(value)) {
        return "${AppLocalizations.of(context).validate} ${getStrParam}";
      }
      return null;
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context).errorNo.replaceAll("field_name", getStrParam);
    }
    RegExp regExp = new RegExp(Validator.patternPhone);
    if (value.length == 0) {
      return "${getStrParam} is Required";
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).errorMinPhone;
    }
    return null;
  }

  String validatePhoneWithoutRequire(String value) {
    if (value.isNotEmpty) {
      RegExp regExp = new RegExp(Validator.patternPhone);
      if (!regExp.hasMatch(value)) {
        return AppLocalizations.of(context).errorMinPhone;
      }
    }
    return null;
  }
}
