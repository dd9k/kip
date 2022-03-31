import 'package:check_in_pro_for_visitor/src/widgetUtilities/awesomeDialog/awesome_dialog.dart';

class Errors {
  int code;

  String description;

  DialogType type = DialogType.ERROR;

  Errors._();

  Errors(int code, String description, DialogType type) {
    this.code = code;
    this.description = description;
    this.type = type;
  }
}
