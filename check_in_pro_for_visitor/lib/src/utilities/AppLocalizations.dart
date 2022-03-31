import 'dart:convert';

import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _localizedStrings;
  Map<String, String> _viStrings;
  Map<String, String> _enStrings;

  Future<bool> load(Locale locale) async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  Future<bool> initLocalLang() async {
    if (_viStrings != null) {
      return false;
    }
    String jsonString = await rootBundle.loadString('assets/lang/vi.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _viStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    jsonString = await rootBundle.loadString('assets/lang/en.json');
    jsonMap = json.decode(jsonString);

    _enStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String get noPassword => translate(AppString.ERROR_NO_PASSWORD);

  String get wrongPassword => translate(AppString.ERROR_WRONG_PASSWORD);

  String get titleCheckIn => translate(AppString.TITLE_CHECK_IN);

  String get titleCheckIn0 => translate("title_check_in0");

  String get titleCheckOut => translate(AppString.TITLE_CHECK_OUT);

  String get titleScanQR => translate(AppString.TITLE_SCAN_QR);

  String get langVi => translate(AppString.LANG_EN);

  String get langEn => translate(AppString.LANG_VI);

  String get errorNoName => translate(AppString.ERROR_NO_FULL_NAME);

  String get errorNo => translate(AppString.ERROR_NO);

  String get errorMinPhone => translate("message_phone_length");

  String get btnClose => translate(AppString.BUTTON_CLOSE);

  String get titleConfirmPassword => translate(AppString.TITLE_CONFIRM_PASSWORD);

  String get password => translate(AppString.PASSWORD);

  String get btnLogout => translate(AppString.BUTTON_LOGOUT);

  String get titleNotification => translate(AppString.TITLE_NOTIFICATION);

  String get deviceExist => translate(AppString.DEVICE_EXIST);

  String get btnYes => translate(AppString.BUTTON_YES);

  String get btnNo => translate(AppString.BUTTON_NO);

  String get validate => translate(AppString.VALIDATE);

  String get validateEmail => translate(AppString.VALIDATE_EMAIL);

  String get errorNoEmail => translate(AppString.ERROR_NO_USERNAME);

  String get emailNotExist => translate("email_not_exist");

  String get accountDeactivated => translate("account_deactivated");

  String get accountLocked => translate("account_locked");

  String get noData => translate("no_data");

  String get reviewMessage => translate("review_message");

  String get btnCheckIn => translate("btn_check_in");

  String get takeNewPicture => translate("take_new_picture");

  String get takePicture => translate("take_picture");

  String get scanIdAgain => translate("scan_id_again");

  String get editDetails => translate("edit_details");

  String get phoneText => translate("hint_phone_number");

  String get permanentAddressText => translate("permanent_address_text");

  String get birthDayText => translate("birth_day_text");

  String get fullNameText => translate("hint_full_name");

  String get fromText => translate("from_text");

  String get toText => translate("to_text");

  String get reviewInfo => translate("review_info");

  String get editInfo => translate("edit_info");

  String get noVisitor => translate("no_visitor");

  String get noPhone => translate("no_phone");

  String get btnOk => translate("btn_ok");

  String get expiredToken => translate("expired_token");

  String get optionalField => translate("optional_field");

  String get noPermission => translate("no_permission");

  String get noFunction => translate("no_function");

  String get limitDevice => translate("limit_device");

  String get noLocation => translate("no_location");

  String get existedDevice => translate("existed_device");

  String get deletedDevice => translate("deleted_device");

  String get deletedBranch => translate("deleted_branch");

  String get deletedAccount => translate("deleted_account");

  String get changedAccount => translate("changed_account");

  String get changedConfiguration => translate("changed_configuration");

  String get changedConfigurationContent => translate("changed_configuration_content");

  String get noVisitorType => translate("no_visitor_type");

  String get visitorType => translate("visitor_type");

  String get noPermissionTitle => translate("no_permission_title");

  String get noPermissionAndroid => translate("no_permission_android");

  String get noPermissionCamera => translate("no_permission_camera");

  String get noPermissionIOS => translate("no_permission_ios");

  String get btnOpenSetting => translate("btn_open_setting");

  String get sendMailNDAContent => translate("content_send_email_NDA");

  String get btnContinue => translate("btn_continue");

  String get tapHereSignatureContent => translate("tap_here_signature_content");

  String get msnEvent => translate("msn_event");

  String get confirm => translate("confirm");

  String get faceCapture => translate("face_capture");

  String get faceDetection => translate("face_detection");

  String get faceCaptureSub => translate("face_capture_sub");

  String get faceDetectionSub => translate("face_detection_sub");

  String get eventMode => translate("event_mode");

  String get eventModeSub => translate("event_mode_sub");

  String get noDetectTitle => translate("no_detect_title");

  String get noDetectContent => translate("no_detect_content");

  String get logoutTitle => translate("logout_title");

  String get deviceLabel => translate("device_label");

  String get btnSave => translate("btn_save");

  String get successTitle => translate("success_title");

  String get saveSuccess => translate("save_success");

  String get connected => translate("connected");

  String get disconnected => translate("disconnected");

  String get connect => translate("connect");

  String get disconnect => translate("disconnect");

  String get printTest => translate("print_test");

  String get updateDevice => translate("update_device");

  String get settingLocation => translate("setting_location");

  String get settingPrint => translate("setting_print");

  String get settingCamera => translate("setting_camera");

  String get settingAdvanced => translate("setting_advanced");

  String get settingLogout => translate("setting_logout");

  String get settingVersion => translate("setting_version");

  String get settingTitle => translate("setting_title");

  String get searchPrinter => translate("search_printer");

  String get noPrinter => translate("no_printer");

  String get noEvent => translate("no_event");

  String get titleEvent => translate("title_event");

  String get labelEvent => translate("label_event");

  String get cantOffline => translate("cant_offline");

  String get errorInviteCode => translate("error_invite_code");

  String get errorEventCode => translate("error_event_code");

  String get inviteCode => translate("invite_code");

  String get phoneNumber => translate("phone_number");

  String get waitPrinter => translate("wait_printer");

  String get qrOrPhoneNumber => translate("qr_or_phone_number");

  String get messageQRCodeOrPhoneNumber => translate("input_qr_or_phone_number");

  String get alreadyCheckout => translate("already_checkout");

  String get refresh => translate("refresh");

  String get cardPhone => translate("card_phone");

  String get cardFrom => translate("card_from");

  String get cardTo => translate("card_to");

  String get cardID => translate("card_id");

  String get welcomeText => translate("welcome_text");

  String get eventExpired => translate("event_expired");

  String get emptyPaper => translate("empty_paper");

  String get communicationError => translate("communication_error");

  String get coverOpen => translate("cover_open");

  String get noInternetSetting => translate("no_internet_setting");

  String get btnSkip => translate("btn_skip");

  String get permissionTitleIOS => translate("permission_title_ios");

  String get permissionSubtitleIOS => translate("permission_subtitle_ios");

  String get permissionTitleAndroid => translate("permission_title_android");

  String get permissionSubtitleAndroid => translate("permission_subtitle_android");

  String get lockTitle => translate("lock_title");

  String get lockSubtitle => translate("lock_subtitle");

  String get fontCamera => translate("font_camera");

  String get fontCameraSub => translate("font_camera_sub");

  String get lockMode => translate("lock_mode");

  String get lockModeSub => translate("lock_mode_sub");

  String get purpose1 => translate("purpose_1");

  String get purpose2 => translate("purpose_2");

  String get purpose3 => translate("purpose_3");

  String get purpose4 => translate("purpose_4");

  String get purpose5 => translate("purpose_5");

  String get purpose6 => translate("purpose_6");

  String get fullNameFlow => translate("full_name_flow");

  String get idCardFlow => translate("id_card_flow");

  String get goodFlow => translate("good_flow");

  String get receiverFlow => translate("receiver_flow");

  String get companyToFlow => translate("company_to_flow");

  String get titleDelivery => translate("title_delivery");

  String get usePhone => translate("use_phone");

  String get scanIdFail => translate("scan_id_fail");

  String get idCardText => translate("ID_card_text");

  String get cancel => translate("cancel");

  String get male => translate("male");

  String get female => translate("female");

  String get hintSearch => translate("hint_search");

  String get dataNotFound => translate("data_not_found");

  String get waitingTitle => translate("waiting_title");

  String get waitingTitleScan => translate("waiting_title_scan");

  String get scanTitle => translate("scan_title");

  String get noEventCode => translate("no_event_code");

  String get titleVisitorType => translate("title_visitor_type");

  String get titleMainSurvey => translate("title_main_survey");

  String get titleSurvey0 => translate("title_survey_0");

  String get titleSurvey0Vi => translateVi("title_survey_0");

  String get titleSurvey0En => translateEn("title_survey_0");

  String get titleSurvey1 => translate("title_survey_1");

  String get titleSurvey1Vi => translateVi("title_survey_1");

  String get titleSurvey1En => translateEn("title_survey_1");

  String get valueSurveyYes => translate("value_survey_yes");

  String get valueSurveyYesVi => translateVi("value_survey_yes");

  String get valueSurveyYesEn => translateEn("value_survey_yes");

  String get valueSurveyNo => translate("value_survey_no");

  String get valueSurveyNoVi => translateVi("value_survey_no");

  String get valueSurveyNoEn => translateEn("value_survey_no");

  String get titleSurvey2 => translate("title_survey_2");

  String get titleSurvey2Vi => translateVi("title_survey_2");

  String get titleSurvey2En => translateEn("title_survey_2");

  String get value0Survey2 => translate("value_0_survey_2");

  String get value0Survey2Vi => translateVi("value_0_survey_2");

  String get value0Survey2En => translateEn("value_0_survey_2");

  String get value1Survey2 => translate("value_1_survey_2");

  String get value1Survey2Vi => translateVi("value_1_survey_2");

  String get value1Survey2En => translateEn("value_1_survey_2");

  String get value2Survey2 => translate("value_2_survey_2");

  String get value2Survey2Vi => translateVi("value_2_survey_2");

  String get value2Survey2En => translateEn("value_2_survey_2");

  String get value3Survey2 => translate("value_3_survey_2");

  String get value3Survey2Vi => translateVi("value_3_survey_2");

  String get value3Survey2En => translateEn("value_3_survey_2");

  String get value4Survey2 => translate("value_4_survey_2");

  String get value4Survey2Vi => translateVi("value_4_survey_2");

  String get value4Survey2En => translateEn("value_4_survey_2");

  String get titleSurvey3 => translate("title_survey_3");

  String get titleSurvey3Vi => translateVi("title_survey_3");

  String get titleSurvey3En => translateEn("title_survey_3");

  String get surveyValidate => translate("survey_validate");

  String get useMobile => translate("use_mobile");

  String get useKiosk => translate("use_kiosk");

  String get contactTitle => translate("contact_title");

  String get contactSearchHint => translate("contact_search_hint");

  String get contactSearchExample => translate("contact_search_example");

  String get noContact => translate("no_contact");

  String get contactSearchHint2 => translate("contact_search_hint2");

  String get domainHint => translate("domain_hint");

  String get noDomain => translate("error_no_domain");

  String get wrongDomain => translate("wrong_domain");
  String get hi => translate("hi");

  String get titleStepCompany => translate("title_step_company");

  String get titleStepDetect => translate("title_step_detect");

  String get titleStepScan => translate("title_step_scan");

  String get titleStepContact => translate("title_step_contact");

  String get titleStepInput => translate("title_step_input");

  String get titleStepPhoto => translate("title_step_photo");

  String get titleStepDone => translate("title_step_done");

  String get btnBack => translate("btn_back");

  String get messOffline => translate("mess_offline");

  String get messOffMode => translate("mess_off_mode");

  String get titleQRTouchLess => translate("title_QR_touchLess");

  String get subTitleQRTouchLess0 => translate("sub_title_QR_touchLess0");

  String get subTitleQRTouchLess1 => translate("sub_title_QR_touchLess1");

  String get titleScanTouchLess => translate("title_scan_touchLess");

  String get subTitleScanTouchLess => translate("subTitle_scan_touchLess");

  String get storageLimit => translate("storage_limit");

  String get invalidQR => translate("invalid_QR");

  String get titleTouchless0 => translate("title_touchless0");

  String get titleTouchless1 => translate("title_touchless1");

  String get titleTouchless2 => translate("title_touchless2");

  String get touchlessExpired => translate("touchless_expired");

  String get doublePrint => translate("double_print");

  String get doublePrintSub => translate("double_print_sub");

  String get titlePrinter => translate("title_printer");

  String get loadingCamera => translate("loading_camera");

  String get alreadyCheckin => translate("already_checkin");

  String get alreadyCheckOut => translate("already_checkOut");

  String get syncEvent => translate("sync_event");

  String get syncBtn => translate("sync_btn");

  String get needSyncEvent => translate("need_sync_event");

  String get noGuestEvent => translate("no_guest_event");

  String get noCompany => translate("no_company");

  String get floorText => translate("floor_text");

  String get inviteCodeError => translate("invite_code_error");

  String get orderNotPaid => translate("order_not_paid");

  String get inviteCodeUsed => translate("invite_code_used");

  String get validateInviteCode => translate("validate_invite_code");

  String translate(String key) {
    return _localizedStrings[key];
  }

  String translateVi(String key) {
    return _viStrings[key];
  }

  String translateEn(String key) {
    return _enStrings[key];
  }
}

class SpecificLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(overriddenLocale);
    await localizations.load(overriddenLocale);
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
