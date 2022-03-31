import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class Constants {
  static final Constants _singleton = Constants._internal();

  factory Constants() {
    return _singleton;
  }

  //flutter packages pub run build_runner watch --delete-conflicting-outputs
  //flutter build appbundle
  //./adb logcat > logcard01.txt
  Constants._internal();

  static const int MAX_INT = 4294967296; //2^32
  static const double MAX_NUMBER_NAME = 11;
  static const double MIN_RAM_IOS = 4;
  static const double MIN_RAM_ANDROID = 8;
  static const Duration CONNECTION_TIME_OUT = Duration(seconds: 120);
  static const Duration CONNECTION_TIME_OUT_OCR = Duration(seconds: 45);
  static const Duration TIMER_PREVENT_SCAN = Duration(seconds: 30);

  static const String FIELD_TYPE = "type";
  static const String FIELD_PAGE_SIZE = "pageSize";
  static const String FIELD_PAGE_INDEX = "pageIndex";
  static const String FIELD_IS_PAGING = "isPaging";
  static const String FIELD_BEARER = "Bearer ";
  static const String FIELD_USER_NAME = "username";
  static const String FIELD_PASSWORD = "password";
  static const String FIELD_SYSTEM_CODE = "systemCode";
  static const String FIELD_FIREBASE_TOKEN = "firebaseId";
  static const String FIELD_LANGUAGE = "language";
  static const String FIELD_OS = "osMobile";
  static const String FIELD_APP_VERSION = "appVersion";
  static const String FIELD_DOMAIN = "domain";
  static const String FIELD_DEVICE_ID = "deviceId";
  static const String FIELD_REFRESH_TOKEN = "refreshToken";
  static const String FIELD_NAME = "name";
  static const String FIELD_OS_VERSION = "osVersion";
  static const String FIELD_IP_ADDRESS = "ipAddress";
  static const String FIELD_PRINT_IP_ADDRESS = "printIpAddress";
  static const String FIELD_LOCATION_ID = "locationId";
  static const String FIELD_BRANCH_ID = "branchId";
  static const String FIELD_TIMEOUT = "timeout";
  static const String FIELD_VISITOR_PHONE = "phoneNumber";
  static const String FIELD_SIGN_OUT_TYPE = "signOutType";
  static const String FIELD_VISITOR_ID_CARD = "visitorIdCard";
  static const String FIELD_FEEDBACK = "feedback";
  static const String FIELD_RATING = "rating";
  static const String FIELD_VISITOR_LOG_ID = "visitorLogId";
  static const String FIELD_SIGN_OUT_BY = "signOutBy";
  static const String FIELD_SIGN_IN_BY = "signInBy";
  static const String FIELD_FACE_FILE = "fileContent";
  static const String FIELD_ID_CARD_FILE = "fileContent";
  static const String FIELD_CARD_FILE = "card";
  static const String FIELD_FACE_OFFLINE = "content";
  static const String FIELD_ID_OFFLINE = "idCard";
  static const String FIELD_FACE_ID = "captureFaceId";
  static const String FIELD_VISITOR = "visitor";
  static const String FIELD_INVITE_CODE = "inviteCode";
  static const String FIELD_QR_CODE = "qrCode";
  static const String FIELD_CHK_DATA = "checkinData";
  static const String FIELD_COMPANY_ID = "companyId";
  static const String FIELD_CARD_NO = "cardNo";
  static const String FIELD_GOODS = "goods";
  static const String FIELD_RECEIVER = "receiver";
  static const String FIELD_VISITOR_POSITION = "visitorPosition";
  static const String FIELD_ID_CARD = "idCard";
  static const String FIELD_FACE_REPO_FILE = "faceCaptureFile";
  static const String FIELD_FACE_REPO_ID = "faceCaptureRepoId";
  static const String FIELD_EVENT_ID = "eventId";
  static const String FIELD_KEYWORD = "keyword";
  static const String FIELD_LAST_UPDATE = "lastUpdate";
  static const String FIELD_STATUS = "status";
  static const String FIELD_SURVEY_ID = "surveyId";
  static const String FIELD_SURVEY_ANSWER = "surveyAnswer";

  static const String KEY_IMAGE_PREFIX = "prefixImage";
  static const String KEY_IMAGE_PREFIX_1 = "prefixImage1";

  static const String BADGE_NAME = "{{visitor_name}}";
  static const String BADGE_PHONE = "{{visitor_phone_number}}";
  static const String BADGE_FROM = "{{visitor_company}}";
  static const String BADGE_TYPE = "{{visitor_type}}";
  static const String BADGE_CODE = "{{invite_code}}";
  static const String BADGE_ID = "{{id_card}}";
  static const String BADGE_QR = "{{qr_code}}";

  int indexURL = 0;
  static const List<String> URL_LIST = [
    URL,
    URL_VNG,
    URL_FPT,
  ];
  static const String URL = "https://api.checkinpro.vn/";
  static const String SUFFIX_URL = ".checkinpro.vn";

//  static const String URL_VNG = "http://61.28.235.127:5100/";
  static const String URL_VNG = "https://99dbcdf3d181.ngrok.io/";
  static const String URL_FPT = "https://api-demo.checkinpro.vn/";
  static const String SIGNAL_R_ENDPOINT = "configHubs";

  static const String PATH_LOCATION = "api/v1/location/getall";
  static const String PATH_AUTHENTICATE = "api/v1/account/authenticate";
  static const String PATH_USER_INFOR = "api/v1/account/info";
  static const String PATH_LOCATION_INFOR = "api/v1/userBranch/site-info";
  static const String PATH_CHECK_IN_FLOW = "api/v1.1/flow/";
  static const String PATH_REFRESH_TOKEN = "api/v1/account/refresh_token";
  static const String PATH_SETUP_DEVICE = "api/v1/device/setup";
  static const String PATH_UPDATE_DEVICE = "api/v1/device/update";
  static const String PATH_CHECKOUT = "api/v1/visit/CheckOut";
  static const String PATH_SEARCH_VISITOR = "api/v1/visit/getlog";
  static const String PATH_SEARCH_VISITOR_CHECKOUT = "api/v1/visit/get-checkout-log";
  static const String PATH_UPLOAD_FACE_CAPTURE = "api/v1/visit/log/upload-face-capture";
  static const String TYPE_SURVEY_HEALTH_DECLARATION = "SURVEY_HEALTH_DECLARATION";
  static const String TYPE_TEMPLATE = "TEMPLATE";
  static const String TYPE_HR = "CHANGE_ATTENDANCE_SETTING";
  static const String TYPE_WAITING = "WAITING";
  static const String TYPE_BRANDING = "BRANDING";
  static const String TYPE_BRANCH_CONFIG = "BRANCH_CONFIG";
  static const String TYPE_TOUCH_LESS = "TOUCHLESS";
  static const String TYPE_DEVICE_CONFIGURATION = "DELETE_DEVICE";
  static const String TYPE_DELETE_BRANCH = "DELETE_BRANCH";
  static const String TYPE_PASSWORD_CONFIGURATION = "CHANGE_PASSWORD";
  static const String TYPE_LOCK_ACCOUNT = "LOCK_ACCOUNT";
  static const String TYPE_DEACTIVATE_ACCOUNT = "DEACTIVATE_ACCOUNT";
  static const String TYPE_ACCOUNT_CONFIGURATION = "DELETE_ACCOUNT";
  static const String TYPE_CHANGE_LANGUAGE = "CHANGE_LANGUAGE";
  static const String PATH_CONFIGURATION = "api/v1/configuration/GetByType";
  static const String PATH_LOGOUT = "api/v1/account/signout";
  static const String PATH_CHECK_DEVICE = "api/v1/Device/checkExisted";
  static const String PATH_VISITOR_TYPE = "api/v1/SystemSetting/getbysettingtype/VISITORTYPE";
  static const String PATH_SYNC = "api/v1/sync/synchronize";
  static const String PATH_SYNC_EVENT = "api/v2/events/synchronize-event-guest";
  static const String PATH_VISITOR_CHECK_IN = "api/v1/visit/CheckIn";
  static const String PATH_EVENT_CHECK_IN = "api/v1/events/checkIn";
  static const String PATH_EVENT_VALIDATE_CODE = "api/v1/events/validate-invite-code";
  static const String PATH_EVENT_CHECK_OUT = "api/v1/events/checkout-by-invite-code";
  static const String PATH_EVENT_MODE = "api/v1/events/action-event-mode";
  static const String PATH_EVENT_VALIDATE_ACTION = "api/v1/events/validate-event-mode";
  static const String PATH_EVENT_VALIDATE = "api/v1/events/validate";
  static const String PATH_EVENT_VALIDATE_OFF = "api/v2/events/validate-offline";
  static const String PATH_EVENT_ACTION = "api/v1/events/action";
  static const String PATH_BUILDING_ALL_COMPANY = "api/v1/BuildingCompany/get-all-company";
  static const String PATH_CONTACT_PERSON = "api/v1/ContactPerson/get-by-branch/";
  static const String PATH_SEARCH_CONTACT = "api/v1.1/ContactPerson/search-by-branch/";
  static const String PATH_CONFIG_KIOS = "api/v1/BranchConfig/get-branch-configure/";
  static const String PATH_UPLOAD_ID_CARD = "api/v1/visit/log/upload-visitor-id-card";
  static const String PATH_ALL_EVENT = "api/v1.1/events/get-all-event-by-branch/";
  static const String PATH_EVENT_DETAILS = "api/v2/events/get-event-infor/";
  static const String PATH_INVITE_EVENT = "api/v1.1/events/invite/";
  static const String PATH_FUNCTION_GROUP = "core/v1/FunctionGroup/AccessMenu/";
  static const String PATH_QR_CREATE = "api/v1.3/EmployeePass/generate-qr-code/";
  static const String PATH_OCR = "core/OCR/GetInfo";
  static const String PATH_OCR_TEMP = "https://ocr.checkinpro.vn/id_card";
  static const String PATH_VALIDATE_DOMAIN = "api/v1/account/validate-company-url/";
  static const String PATH_UPDATE_STATUS = "api/v1.1/Device/update-device-status";
  static const String PATH_SURVEY = "core/v1.2/survey/get-health-declaration/";
  static const String PATH_ALL_EVENT_TICKET = "eventadvanced/v1/eventtablet/get-all";
  static const String PATH_ALL_EVENT_TICKET_DETAIL = "eventadvanced/v1/eventtablet/get-full-flow-by-id?id=";
  static const String PATH_EVENT_TICKET_CHECK_IN = "huba/v1/orderdetail/check-in";

  static const String KEY_AUTHENTICATE = "authenticate";
  static const String KEY_USER_INFOR = "userInfor";
  static const String KEY_IS_LOGGED = "isLogged";
  static const String KEY_DEVICE_NAME = "deviceName";
  static const String KEY_COMPANY_LOGO = "companyLogo";
  static const String KEY_COMPANY_SUB_LOGO = "companySubLogo";
  static const String KEY_IMAGE_WAITING = "imageWaiting";
  static const String KEY_LANGUAGE = "lang";
  static const String KEY_PASSWORD = "password";
  static const String KEY_FIREBASE_TOKEN = "firebaseToken";
  static const String KEY_DEV_MODE = "devmode";
  static const String KEY_LAST_TIME = "lastTime";
  static const String KEY_FACE_DETECT = "faceDetect";
  static const String KEY_FRONT_CAMERA = "fontCamera";
  static const String KEY_PRINTER = "printerInfo";
  static const String KEY_FACE_CAPTURE = "faceCapture";
  static const String KEY_EVENT = "event";
  static const String KEY_BADGE_PRINTER = "badgePrinter";
  static const String KEY_FUNCTION_EVENT = "functionEvent";
  static const String KEY_LAST_SYNC = "lastSync";
  static const String KEY_FIRST_START = "isFirstStart";
  static const String KEY_LOAD_WELCOME = "isLoadWelcome";
  static const String KEY_IS_KICK = "isKick";
  static const String KEY_IS_LAUNCH = "isFirstLaunch";
  static const String KEY_IDENTIFIER = "identifier";
  static const String KEY_COMPANY_ID = "companyId";
  static const String KEY_CONFIG_KIOS = "configKios";
  static const String KEY_SURVEY = "survey";
  static const String KEY_EVENT_ID = "eventId";
  static const String KEY_EVENT_TICKET_ID = "eventTicketId";
  static const String KEY_DOMAIN = "domain";
  static const String KEY_USER = "user";
  static const String KEY_DOUBLE_PRINT = "doublePrint";
  static const String KEY_LAST_REFRESH = "lastRefresh";
  static const String KEY_SYNC_EVENT = "syncEvent";
  static const String KEY_ON_LOCK = "onLock";

  static const String STATUS_SUCCESS = "SUCCESS";
  static const String STATUS_FAIL = "FAIL";
  static const String STATUS_FAIL_API = "FAIL_API";
  static const String B500 = "b500";
  static const String B401 = "401";
  static const String B400 = "400";
  static const String B403 = "403";
  static const int TIMEOUT_DEFAULT = 60;
  static const int TIMEOUT_CHECK_OUT = 30;
  static const int TIMEOUT_RESET = 10;
  static const int TIMEOUT_PRINTER = 3;
  static const int WAITING_AUTO_PLAY = 5000;
  static const int DONE_CHECK_IN = 10;
  static const int DONE_TAKE_PHOTO = 5;
  static const int DONE_THANK_YOU = 3;
  static const int DONE_BUTTON_LOADING = 500;
  static const int AUTO_RECONNECT_SIGNAL_R = 300;
  static const int TIME_TO_SYNC = 15;
  static const int TIME_ANIMATION_SCAN = 2;
  static const int TIME_DELAY_QR = 1;
  static const int TIME_REQUEST_QR = 120;
  static const int TIME_RELOAD_QR = 2;
  static const int MIN_HEIGHT = 600;
  static const int DELAY_SEARCH = 500;

  static const int AUTO_HIDE_SMALL = 1;
  static const int AUTO_HIDE_LITTLE = 2;
  static const int AUTO_HIDE_LESS = 3;
  static const int AUTO_HIDE_LONG = 5;
  static const int AUTO_HIDE_LONGER = 10;

  static const String VT_VISITORS = "VISITOR";
  static const String CONFIGURATION_BACKGROUND_COLOR = "TEXT#BACKGROUND_COLOR";
  static const String CONFIGURATION_COMPANY_LOGO = "FILE#COMPANY_LOGO";
  static const String CONFIGURATION_COMPANY_NAME = "TEXT#COMPANY_NAME";
  static const String CONFIGURATION_CHECKIN_BUTTON_TEXT = "TEXT#CHECKIN_BUTTON_TEXT";
  static const String CONFIGURATION_CHECKOUT_BUTTON_TEXT = "TEXT#CHECKOUT_BUTTON_TEXT";
  static const String CONFIGURATION_IMAGES = "FILE#IMAGES";
  static const String CONFIGURATION_LAYOUTS = "TEXT#LAYOUTS";
  static const String CONFIGURATION_COMPANY_NAME_COLOR = "TEXT#COMPANY_NAME_COLOR";
  static const String CONFIGURATION_COMPANY_TEXT_SIZE = "TEXT#WELCOME_SCREEN";

  static const String CONFIGURATION_CHECKOUT_BUTTON_BG_COLOR = "TEXT#CHECKOUT_BUTTON_BG_COLOR";
  static const String CONFIGURATION_CHECKIN_BUTTON_TEXT_COLOR = "TEXT#CHECKIN_BUTTON_TEXT_COLOR";
  static const String CONFIGURATION_CHECKIN_BUTTON_BG_COLOR = "TEXT#CHECKIN_BUTTON_BG_COLOR";
  static const String CONFIGURATION_CHECKOUT_BUTTON_TEXT_COLOR = "TEXT#CHECKOUT_BUTTON_TEXT_COLOR";
  static const String CONFIGURATION_SUB_COMPANY_LOGO = "FILE#SUB_COMPANY_LOGO";

  static const String SPLIT_SIMPLE = ";";

  static const String FILE_TYPE_IMAGE_SAVER = "saver";
  static const String FILE_TYPE_IMAGE_WAITING = "imageWaiting";
  static const String FILE_TYPE_LOGO_COMPANY = "logoCompany";
  static const String FILE_TYPE_LOGO_SUB_COMPANY = "logoSubCompany";
  static const String FILE_TYPE_TEMP = "temp";
  static const String FILE_TYPE_COMPANY_BUILDING = "companyBuilding";
  static const String FILE_TYPE_CONTACT_PERSON = "contactPerson";
  static const String FOLDER_TEMP = "temp";
  static const String FOLDER_FACE_OFFLINE = "faceOffline";
  static const String FOLDER_ID_OFFLINE = "idOffline";
  static const String FOLDER_BADGE = "badge";

  static const String BADGE_FILE_TEST = "card_printer";

  static const String SIGNAL_R_METHOD = "ADMIN_CONFIG";

  static const String PREFIX_COLOR = "0xFF";

  static const String STYLE_1 = "STYLE_1";
  static const String STYLE_2 = "STYLE_2";

  static const String STATUS_ONLINE = "1";
  static const String STATUS_OFFLINE = "0";

  static const List<String> LIST_LANG = [Constants.EN_CODE, Constants.VN_CODE];

  static const KDURATION = const Duration(milliseconds: 700);

  static const VN_CODE = "vi";
  static const EN_CODE = "en";
  static const IPAD_CODE = "IPAD";
  static const ANDROID_CODE = "ANDROID";
  static const IOS_CODE = "IOS";

  static const HQ_CODE = "HQ";

  static const TYPE_CHECK = "KIOSK";

  static const ERROR_TOKEN = "error_token";

  static const VALIDATE_IN = "EVENT_NotYetCheckin";
  static const VALIDATE_OUT = "EVENT_NotYetCheckout";
  static const VALIDATE_WRONG = "EVENT_InviteCodeNotFound";
  static const VALIDATE_ALREADY = "EVENT_AlreadyCheckout";

  static const FUNCTION_EVENT = "FN_EVENT";

  static const SCAN_VISION = "scanVision";
  static const PNG_ETX = "png";
  static const LIMIT_IMAGE_SIZE = 150000;

  static const HEIGHT_BUTTON = 60.0;
  static const PRINTER_QL = "QL-810W";
  static const PRINTER_ESC_POS = "ESC_POS";
  static const PRINTER_OTHER = "Other";
  static const PORT_9100 = 9100;
  static const ERROR_PRINTER = "ERROR_CODE";
  static const ERROR_LIMIT_UPLOAD = "FILE_UsageStorageExceedsLimit";

  static const ACTION_PRINTER_FIND = "findPrinter";
  static const ACTION_PRINTER_TEST = "printTest";
  static const ACTION_PRINTER_PRINT = "printTemplate";

  static const BADGE_TEMPLATE = "BADGE";
  static const FORMAT_DATE_BASIC = "yyyy-MM-dd'T'HH:mm:ss";
  static const DATE_FORMAT_EN = "EEE, MMMM d, yyyy";
  static const TIME_FORMAT_12_VN = "hh:mm";
  static const TIME_FORMAT_12_EN = "hh:mm a";
  static const TIME_FORMAT_24 = "HH:mm";

  static const String hardCode = "{\"vi\":\"field_name\",\"en\":\"field_name\"}";
  static const String stringReplace = "field_name";
  static const String EVENT_ERROR = "EVENT_EmailAlreadyInInviteList";

  static const PERMISSION_LIST_ANDROID = [
    PermissionGroup.camera,
    PermissionGroup.storage,
  ];

  static const PERMISSION_LIST_IOS = [
    PermissionGroup.camera,
  ];

  static const DELIVERY_STEP = ["RECEIVER", "GOODS"];

  static const DEFAULT_PURPOSE = [
    "purpose_1",
    "purpose_2",
    "purpose_3",
    "purpose_4",
    "purpose_5",
    "purpose_6",
  ];

  /// Maximum of click on Logo to show hidden Activity
  static const MAX_CLICK_NUMBER = 4;

  static const HARDWARE_CHANNEL = const MethodChannel('hardware');
  static const PRINTER_CHANNEL = const MethodChannel('flutter.native/helper');
  static const MEMORY_METHOD = 'memory';
  static const ENABLE_LOCK_METHOD = "enableLock";
  static const DISABLE_LOCK_METHOD = "disableLock";
  static const ACTIVE_ADMIN_METHOD = "activeAdmin";
  static const ACTION_IS_LOCK = "isInLock";
  static const ACTION_GO_HOME = "goHome";
  static const ACTION_IS_LAUNCHER = "isLauncher";
  static const B_TO_GB = 1000000000;
}

class StepCode {
  static const CAPTURE_FACE = "CAPTUREFACE";
  static const FROM_COMPANY = "FROMCOMPANY";
  static const FULL_NAME = "FULLNAME";
  static const ID_CARD = "IDCARD";
  static const PHONE_NUMBER = "PHONENUMBER";
  static const PURPOSE = "PURPOSE";
  static const TO_COMPANY = "TOCOMPANY";
  static const VISITOR_TYPE = "VISITORTYPE";
  static const PRINT_CARD = "PRINTVISITORCARD";
  static const EMAIL = "EMAIL";
  static const LEGAL_SIGN = "LEGALSIGN";
  static const VISITOR_POSITION = "VISITOR_POSITION";
  static const RECEIVER = "RECEIVER";
  static const GOODS = "GOODS";
  static const CARD_NO = "CARD_NO";
  static const CONTACT_PERSON = "CONTACTPERSON";
  static const SCAN_ID_CARD = "SCANIDCARD";
  static const GENDER = "GENDER";
  static const PASSPORT_NO = "PASSPORT_ID";
  static const NATIONALITY = "NATIONALITY";
  static const BIRTH_DAY = "BIRTHDAY";
  static const PERMANENT_ADDRESS = "PERMANENT_ADDRESS";
  static const ROOM_NO = "ROOM_NO";
  static const CHECKOUT_TIME_EXPECTED = "CHECKOUT_TIME_EXPECTED";
}

class StepType {
  static const IMAGE = "IMAGE";
  static const FILE = "FILE";
  static const TEXT = "TEXT";
  static const PHONE = "PHONE";
  static const MULTIPLE_TEXT = "MULTIPE TEXT";
  static const NUMBER = "NUMBER";
  static const EMAIL = "EMAIL";
}

class IDCardType {
  static const PASSPORT = "PASSPORT";
  static const ID_CARD_NEW = "Can_Cuoc";
  static const ID_CARD_OLD = "CMND";
}

class TemplateCode {
  static const DELIVERY = "DELIVERY";
  static const INTERVIEWER = "INTERVIEWER";
  static const VISITOR = "VISITOR";
  static const EVENT = "EVENT";
}

class PrinterType {
  static const BROTHER = "brother";
  static const X_PRINTER = "xPrinter";
}

class TypeVisitor {
  static const DELIVERY = "DELIVERY";

//  static const VENDOR = "VENDOR";
  static const VISITOR = "VISITOR";
  static const INTERVIEW = "INTERVIEW";
//  static const EMPLOYEE = "EMPLOYEE";
//  static const CUSTOMER = "CUSTOMER";
//  static const SUPPLIER = "SUPPLIER";
//  static const PARENT = "PARENT";
//  static const STUDENT = "STUDENT";
}

class TypeRating {
  static const TYPE1 = "TYPE1";
  static const TYPE2 = "TYPE2";
}

enum HomeNextScreen {
  CHECK_IN,
  SURVEY,
  CHECK_OUT,
  SCAN_QR,
  FACE_CAP,
  THANK_YOU,
  REVIEW_INFOR,
  FEED_BACK,
  SCAN_ID,
  COVID,
  CONTACT_PERSON
}

enum SwitchType { FACE_CAPTURE, FACE_DETECT, EVENT, FRONT_CAMERA, LOCK_MODE, OTHER }

class ItemSwitch {
  String title;
  final String subtitle;
  final IconData icon;
  bool isSelect;
  SwitchType switchType;

  ItemSwitch({this.title, this.subtitle, this.icon, this.isSelect, this.switchType});
}

class ItemSetting {
  ItemSetting(
      {@required this.title,
      this.subtitle,
      @required this.widget,
      @required this.icon,
      @required this.settingType,
      @required this.isSelect});

  final String title;
  final String subtitle;
  final Widget widget;
  final IconData icon;
  final SettingType settingType;
  bool isSelect;
}

class ErrorCode {
  static const NO_PRINTER = "noPrinter";
  static const NO_TEST_IMAGE = "noTestImage";
  static const NONE = "none";
  static const NOT_SAME_MODEL = "notsamemodel";
  static const BROTHER_PRINTER_NOT_FOUND = "brotherprinternotfound";
  static const PAPER_EMPTY = "paperempty";
  static const BATTERY_EMPTY = "batteryempty";
  static const COMMUNICATION_ERROR = "communicationerror";
  static const OVERHEAT = "overheat";
  static const PAPER_JAM = "paperjam";
  static const HIGH_VOLTAGE_ADAPTER = "highvoltageadapter";
  static const CHANGE_CASSETTE = "changecassette";
  static const FEED_OR_CASSETTE_EMPTY = "feedorcassetteempty";
  static const SYSTEM_ERROR = "systemerror";
  static const NO_CASSETTE = "nocassette";
  static const WRONG_CASSETTE_DIRECT = "wrongcassettedirect";
  static const CREATE_SOCKET_FAILED = "createsocketfailed";
  static const CONNECT_SOCKET_FAILED = "connectsocketfailed";
  static const GET_OUTPUT_STREAM_FAILED = "getoutputstreamfailed";
  static const GET_INPUT_STREAM_FAILED = "getinputstreamfailed";
  static const CLOSE_SOCKET_FAILED = "closesocketfailed";
  static const OUT_OF_MEMORY = "outofmemory";
  static const SET_OVER_MARGIN = "setovermargin";
  static const NO_SD_CARD = "nosdcard";
  static const FILE_NOT_SUPPORTED = "filenotsupported";
  static const EVALUATION_TIMEUP = "evaluationtimeup";
  static const WRONG_CUSTOM_INFO = "wrongcustominfo";
  static const NO_ADDRESS = "noaddress";
  static const NOT_MATCH_ADDRESS = "notmatchaddress";
  static const FILE_NOT_FOUND = "filenotfound";
  static const TEMPLATE_FILE_NOT_MATCH_MODEL = "templatefilenotmatchmodel";
  static const TEMPLATE_NOT_TRANS_MODEL = "templatenottransmodel";
  static const COVER_OPEN = "coveropen";
  static const WRONG_LABEL = "wronglabel";
  static const PORT_NOT_SUPPORTED = "portnotsupported";
  static const WRONG_TEMPLATE_KEY = "wrongtemplatekey";
  static const BUSY = "busy";
  static const TEMPLATE_NOT_PRINT_MODEL = "templatenotprintmodel";
  static const CANCEL = "cancel";
  static const PRINTER_SETTING_NOT_SUPPORTED = "printersettingnotsupported";
  static const INVALID_PARAMETER = "invalidparameter";
  static const INTERNAL_ERROR = "internalerror";
  static const TEMPLATE_NOT_CONTROL_MODEL = "templatenotcontrolmodel";
  static const TEMPLATE_NOT_EXIST = "templatenotexist";
  static const BUFFER_FULL = "bufferfull";
  static const TUBE_EMPTY = "tubeempty";
  static const TUBE_RIBBON_EMPTY = "tuberibbonempty";
  static const UPDATE_FRIM_NOT_SUPPORTED = "updatefrimnotsupported";
  static const OS_VERSION_NOT_SUPPORTED = "osversionnotsupported";
  static const RESOLUTION_MODE = "resolutionmode";
  static const POWER_CABLE_UNPLUGGING = "powercableunplugging";
  static const BATTERY_TROUBLE = "batterytrouble";
  static const UNSUPPORTED_MEDIA = "unsupportedmedia";
  static const TUBE_CUTTER = "tubecutter";
  static const UNSUPPORTED_TWO_COLOR = "unsupportedtwocolor";
  static const UNSUPPORTED_MONO_COLOR = "unsupportedmonocolor";
  static const MINIMUM_LENGTH_LIMIT = "minimumlengthlimit";
}

enum SettingType { LOCATION, PRINTER, CAMERA, ADVANCED, LOGOUT, VERSION }

enum BtnLoadingAction {
  START,
  STOP,
  SUCCESS,
}

enum BackgroundType {
  TOUCH_LESS,
  MAIN,
  WAITING_NEW,
  SCAN_ID,
}
