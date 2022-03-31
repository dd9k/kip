import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyLanguage.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:flutter/cupertino.dart';

class UtilityNotifier extends MainNotifier {
  List<CompanyLanguage> listLang;
  var currentLang = Constants.EN_CODE;

  Future<void> updateLang(String lang) {
    return null;
  }
}
