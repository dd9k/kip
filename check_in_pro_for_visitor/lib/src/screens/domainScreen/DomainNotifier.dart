import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/screens/login/LoginScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/utilities/UtilityNotifier.dart';
import 'package:flutter/material.dart';

class DomainNotifier extends UtilityNotifier {
  bool isLoading = false;
  bool isUpdateLang = false;
  bool isShowKeyBoard = true;
  bool isDevMode = false;
  int clickNumber = 0;
  bool updateToggle = false;
  AsyncMemoizer<String> memCache = AsyncMemoizer();
  String error;
  List<bool> selections = List.generate(Constants.URL_LIST.length, (index) => false);

  Future<String> initData() async {
    return memCache.runOnce(() async {
      var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
      currentLang = langSaved;
      var domainSaved = preferences.getString(Constants.KEY_DOMAIN) ?? "";
      return domainSaved;
    });
  }

  Future<void> onToggleSelected(int index) async {
    Constants().indexURL = index;
    selections.asMap().forEach((index, element) {
      selections[index] = false;
    });
    selections[index] = true;
    preferences.setInt(Constants.KEY_DEV_MODE, index);
    updateToggle = !updateToggle;
    notifyListeners();
  }

  Future<void> onTapLogo() async {
    clickNumber++;
    // Meet maximum value
    if (Constants.MAX_CLICK_NUMBER == clickNumber) {
      // Reset clickNumber value
      clickNumber = 0;
      // Show hidden
      updateToggle = !updateToggle;
      isDevMode = !isDevMode;
      var index = preferences.getInt(Constants.KEY_DEV_MODE) ?? 0;
      selections[index] = true;
      notifyListeners();
    }
  }

  Future<void> validateDomain(BuildContext context, String domain) async {
    error = null;
    isLoading = true;
    notifyListeners();
    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
      preferences.setString(Constants.KEY_DOMAIN, domain);
      isLoading = false;
      notifyListeners();
      navigationService.navigateTo(LoginScreen.route_name, 1, arguments: {"domain": domain}).then((value) async {
        memCache = AsyncMemoizer();
        await initData();
        isUpdateLang = !isUpdateLang;
        notifyListeners();
      });
    }, (Errors message) {
      if (message.code != -2) {
        error = appLocalizations.wrongDomain;
      }
      isLoading = false;
      notifyListeners();
    });

    await ApiRequest().requestValidateDomain(context, domain, callBack);
  }

  Future<void> updateLang(String lang) async {
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    if (langSaved == lang) {
      return;
    }
    if (!Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    preferences.setString(Constants.KEY_LANGUAGE, lang);
    await appLocalizations.load(Locale(lang));
    currentLang = lang;
    if (error != null) {
      error = appLocalizations.wrongDomain;
    }
    isUpdateLang = !isUpdateLang;
    notifyListeners();
  }
}
