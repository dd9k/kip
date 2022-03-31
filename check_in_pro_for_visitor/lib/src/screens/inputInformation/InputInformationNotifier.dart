import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/CheckInFlow.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorType.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../constants/Constants.dart';
import '../../model/VisitorType.dart';

class InputInformationNotifier extends MainNotifier {
  final TextEditingController controllerTo = TextEditingController();
  String errorToCompany;
  bool isReloadCompany = false;
  CheckInFlow companyBuildingItem;

  final TextEditingController controllerFrom = TextEditingController();
  String errorFromCompany;
  bool isReloadFrom = false;
  CheckInFlow fromCompanyItem;

  final TextEditingController controllerType = TextEditingController();
  String errorVisitorType;
  bool isReloadType = false;
  CheckInFlow visitorTypeItem;

  final TextEditingController controllerNote = TextEditingController();
  String errorNote;
  bool isReloadNote = false;
  CheckInFlow noteItem;

  final TextEditingController controllerGender = TextEditingController();
  String errorGender;
  bool isReloadGender = false;
  CheckInFlow genderItem;

  ScrollController scrollController = ScrollController();
  List<VisitorType> listType;
  String valueFocus = '';
  List<String> defaultPurpose = List();
  List<CompanyBuilding> listCompanyBuilding;
  bool isReload = false;
  VisitorType visitorType;
  CompanyBuilding companyBuilding;
  bool hideLoading = true;
  AsyncMemoizer<List<VisitorType>> memCache = AsyncMemoizer();
  AsyncMemoizer<List<CompanyBuilding>> memCacheCompany = AsyncMemoizer();
  AsyncMemoizer<List<CheckInFlow>> memCacheFlows = AsyncMemoizer();
  bool isLoading;
  bool isShowLogo = true;
  bool isShowFooter = true;
  bool isDelivery = false;
  bool isReplace = false;
  bool isReturn = false;
  GlobalKey<FormState> formKey = GlobalKey();
  var textFormFields = <TextFormField>[];
  List<CheckInFlow> flows = List();
  List<CheckInFlow> flowsInit = List();
  CancelableOperation cancelableRefresh;
  CancelableOperation cancelableLogout;
  Map<String, TextEditingController> textEditingControllers = {};
  List<GlobalKey<FormState>> keyList = List();
  BuildContext context;
  String initValueBuilding;
  bool isHaveCompany = false;
  VisitorCheckIn visitorBackup;
  var indexInitType;
  var langSaved;
  var isBuilding = false;
  bool isScanId = false;

  CancelableOperation cancelCheckIn;
  CancelableOperation cancellableOperation;

  List<String> dummyData = [StepCode.CAPTURE_FACE, StepCode.PRINT_CARD, StepCode.SCAN_ID_CARD, StepCode.LEGAL_SIGN];

  Future<List<CheckInFlow>> getCheckInFlow() async {
    return memCacheFlows.runOnce(() async {
      isScanId = arguments["isScanId"] as bool ?? false;
      visitorBackup = arguments["visitor"] as VisitorCheckIn;
      isDelivery = arguments["isDelivery"] as bool ?? false;
      isReplace = (arguments["isReplace"] as bool) ?? false;
      isReturn = arguments["isReturn"] as bool ?? false;
      await getVisitorType(context);

      await renderFlowByType();
      if (flows == null || flows.isEmpty) {
        moveToNextPage();
      } else {
        getDefaultPurpose(context);
        isBuilding = await Utilities().checkIsBuilding();
        isLoading = false;
        notifyListeners();
      }
      return flows;
    });
  }

  void reloadFlow(VisitorType suggestion) {
    visitorType = suggestion;
    controllerType.text = suggestion.description;
    renderFlowByType();
    notifyListeners();
  }

  Future renderFlowByType() async {
    flows = await getFlowOffline();

    isBuilding = (await Utilities().checkIsBuilding() && (await db.companyBuildingDAO.isExistData() != null));

    flows?.removeWhere((element) => element.getRequestType() == RequestType.HIDDEN);
    flows?.removeWhere((element) => dummyData.contains(element.stepCode));
    flows?.sort((a, b) => int.parse(a.sort).compareTo(int.parse(b.sort)));
    flowsInit.clear();

    if (isBuilding && !isEventFlow()) {
      if (!isReplace) {
        flows?.removeWhere((element) => (element.stepCode == StepCode.TO_COMPANY));
      } else if (!isContains()) {
        var stepName =
            Constants.hardCode.replaceAll(Constants.stringReplace, AppLocalizations.of(context).companyToFlow);
        flows?.add(CheckInFlow.hardcode(stepName, StepCode.TO_COMPANY, StepType.TEXT, 1, flows.length.toString()));
      }
    }
    if (!isReplace) {
      flows?.removeWhere((element) => (element.stepCode == StepCode.VISITOR_TYPE));
    }
    flowsInit.addAll(flows);

    if (!isReplace && isReturn) {
      flows?.removeWhere((element) =>
          (element.getRequestType() != RequestType.ALWAYS && element.getRequestType() != RequestType.ALWAYS_NO));
    }
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    flows?.forEach((item) {
      var mapLang = json.decode(item.stepName);
      item.stepName = mapLang[langSaved];
    });
  }

  bool isContains() {
    var isContain = false;
    flows?.forEach((element) {
      if (element.stepCode == StepCode.TO_COMPANY) {
        isContain = true;
      }
    });
    return isContain;
  }

  Future<List<CheckInFlow>> getFlowOffline() async {
    var templateCode = (visitorType != null)
        ? visitorType.settingKey
        : ((visitorBackup.visitorType != null && visitorBackup.visitorType.isNotEmpty)
            ? visitorBackup.visitorType
            : listType[0].settingKey);

    if (isEventFlow()) {
      templateCode = TemplateCode.EVENT;
    }
    return await db.checkInFlowDAO.getbyTemplateCode(templateCode);
  }

  bool isEventFlow() {
//    var isQRScan = arguments["isQRScan"] as bool ?? false;
    var isQRScan = true;
    var isEventMode = preferences.getBool(Constants.KEY_EVENT) ?? false;
    return isQRScan && isEventMode;
  }

  void _onFocusChange(FocusNode focus, CheckInFlow item) {
    if (focus.hasFocus) {
      valueFocus = item.stepCode;
      notifyListeners();
    } else {
      valueFocus = '';
      notifyListeners();
    }
  }

  void initItemFlow(CheckInFlow item, int index, TextEditingController controller, List<FocusNode> focusNodes) {
    item.index = index;
    // Focus on textfield
    var _focus = FocusNode();
    _focus.addListener(() {
      _onFocusChange(_focus, item);
    });
    focusNodes.add(_focus);
    keyList.add(GlobalKey());
    item.initValue = item.buildInitValue(context, visitorBackup);
    if (controller != null) {
      textEditingControllers.putIfAbsent(item.stepCode, () => controller);
    } else {
      var textEditingController = new TextEditingController();
      textEditingControllers.putIfAbsent(item.stepCode, () => textEditingController);
      textEditingController.value = TextEditingValue(text: item.initValue);
    }
  }

  Future checkIsNext(BuildContext context, bool isValidate, bool isNext) async {
    var isErrorTo = await handlerToCompany(context, controllerTo.text);
    var isErrorGender = await handlerGender(context, controllerGender.text);
    var isErrorFrom = await handlerFromCompany(context, controllerFrom.text);
    var isVisitorType = await handlerVisitorType(context, controllerType.text);
    var isErrorNote = await handlerNote(context, controllerNote.text);
    if (isVisitorType && isErrorTo && isErrorGender && isErrorFrom && isValidate && isNext && isErrorNote) {
      moveToNextPage();
    }
  }

  Future<bool> handlerToCompany(BuildContext context, String value) async {
    var isBuilding = await Utilities().checkIsBuilding();
    if (value.isEmpty &&
        isBuilding &&
        isHaveCompany &&
        companyBuildingItem?.isVisible == true &&
        listCompanyBuilding != null &&
        listCompanyBuilding.isNotEmpty &&
        (companyBuildingItem?.getRequestType() == RequestType.ALWAYS ||
            companyBuildingItem?.getRequestType() == RequestType.FIRST)) {
      errorToCompany = AppLocalizations.of(context).errorNo.replaceAll("field_name", companyBuildingItem?.stepName);
      isReloadCompany = !isReloadCompany;
      notifyListeners();
      return false;
    }
    if (listCompanyBuilding != null && listCompanyBuilding.isNotEmpty && companyBuildingItem?.isVisible == true) {
      errorToCompany = null;
      isReloadCompany = !isReloadCompany;
      notifyListeners();
    }
    return true;
  }

  Future<bool> handlerGender(BuildContext context, String value) async {
    if (value.isEmpty &&
        genderItem?.isVisible == true &&
        (genderItem?.getRequestType() == RequestType.ALWAYS || genderItem?.getRequestType() == RequestType.FIRST)) {
      errorGender = AppLocalizations.of(context).errorNo.replaceAll("field_name", genderItem?.stepName);
      isReloadGender = !isReloadGender;
      notifyListeners();
      return false;
    }
    if (genderItem?.isVisible == true) {
      errorGender = null;
      isReloadGender = !isReloadGender;
      notifyListeners();
    }
    return true;
  }

  Future<bool> handlerFromCompany(BuildContext context, String value) async {
    if (value.isEmpty &&
        fromCompanyItem?.isVisible == true &&
        (fromCompanyItem?.getRequestType() == RequestType.ALWAYS ||
            fromCompanyItem?.getRequestType() == RequestType.FIRST)) {
      errorFromCompany = AppLocalizations.of(context).errorNo.replaceAll("field_name", fromCompanyItem?.stepName);
      isReloadFrom = !isReloadFrom;
      notifyListeners();
      return false;
    }
    if (fromCompanyItem?.isVisible == true) {
      errorFromCompany = null;
      isReloadFrom = !isReloadFrom;
      notifyListeners();
    }
    return true;
  }

  Future<bool> handlerNote(BuildContext context, String value) async {
    if (value.isEmpty &&
        noteItem?.isVisible == true &&
        (noteItem?.getRequestType() == RequestType.ALWAYS || noteItem?.getRequestType() == RequestType.FIRST)) {
      errorNote = AppLocalizations.of(context).errorNo.replaceAll("field_name", noteItem?.stepName);
      isReloadNote = !isReloadNote;
      notifyListeners();
      return false;
    }
    if (noteItem?.isVisible == true) {
      errorNote = null;
      isReloadNote = !isReloadNote;
      notifyListeners();
    }
    return true;
  }

  void validateFieldBefore(int index) {
    List<CheckInFlow> convertList = List();
    convertList.addAll(flows);
    switch (convertList[index].stepCode) {
      case StepCode.PURPOSE:
        {
          handlerNote(context, controllerNote.text);
          break;
        }
      case StepCode.FROM_COMPANY:
        {
          handlerFromCompany(context, controllerFrom.text);
          break;
        }
      case StepCode.TO_COMPANY:
        {
          handlerToCompany(context, controllerTo.text);
          break;
        }
      case StepCode.GENDER:
        {
          handlerGender(context, controllerGender.text);
          break;
        }
      case StepCode.VISITOR_TYPE:
        {
          handlerVisitorType(context, controllerType.text);
          break;
        }
      default:
        {
          keyList[index].currentState.validate();
          break;
        }
    }
  }

  Future<bool> handlerVisitorType(BuildContext context, String value) async {
    if (value.isEmpty &&
        visitorTypeItem?.isVisible == true &&
        (visitorTypeItem?.getRequestType() == RequestType.ALWAYS ||
            visitorTypeItem?.getRequestType() == RequestType.FIRST)) {
      errorVisitorType = AppLocalizations.of(context).errorNo.replaceAll("field_name", visitorTypeItem?.stepName);
      isReloadType = !isReloadType;
      notifyListeners();
      return false;
    }
    if (visitorTypeItem?.isVisible == true) {
      errorVisitorType = null;
      isReloadType = !isReloadType;
      notifyListeners();
    }
    return true;
  }

  void buildInitValueTypeHead() {
    var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
    initValueBuilding = (initValueBuilding == null) ? (visitorCheckIn.toCompany ?? "") : controllerTo.text;
  }

  Future<VisitorCheckIn> _retrieveValues(VisitorType visitorType) async {
    var tempData = VisitorCheckIn.createVisitorByInput(
        context, this.isReplace ? flowsInit : flows, flowsInit, textEditingControllers, visitorBackup);

    tempData.id = 0;
    if (isBuilding) {
      if (companyBuilding != null) {
        tempData.toCompany = companyBuilding.companyName;
        tempData.toCompanyId = companyBuilding.id;
        tempData.contactPersonId = companyBuilding.representativeId;
        tempData.floor = companyBuilding.floor;
      } else {
        var isMatch = false;
        if (listCompanyBuilding != null && listCompanyBuilding.isNotEmpty && tempData.toCompany != null) {
          await Future.forEach(listCompanyBuilding, (CompanyBuilding element) {
            if (element.companyName.toLowerCase() == tempData.toCompany.toLowerCase() && !isMatch) {
              isMatch = true;
              tempData.toCompany = element.companyName;
              tempData.toCompanyId = element.id;
              tempData.contactPersonId = element.representativeId;
              tempData.floor = element.floor;
            }
          });
        }
      }
    }

    var type = TypeVisitor.VISITOR;
    if (listType != null && listType.isNotEmpty) {
      type = listType[0].settingKey;
    }
    if (visitorType?.settingKey != null) {
      type = visitorType?.settingKey;
    } else if (isDelivery || (flows[0].templateCode == TemplateCode.DELIVERY && visitorBackup.visitorType == null)) {
      type = TypeVisitor.DELIVERY;
    } else if (visitorBackup.visitorType != null) {
      type = visitorBackup.visitorType;
    }
    tempData.visitorType = type;

    tempData.id = visitorBackup.id;
    tempData.visitorId = visitorBackup.visitorId;
    if (await Utilities().checkIsBuilding() && (tempData.toCompany == null || tempData.toCompany.isEmpty)) {
      tempData.toCompany = visitorBackup.toCompany;
      tempData.toCompanyId = visitorBackup.toCompanyId;
      tempData.floor = visitorBackup.floor;
    }
    tempData.imagePath = visitorBackup.imagePath;
    tempData.imageIdPath = visitorBackup.imageIdPath;
    tempData.survey = visitorBackup.survey;
    tempData.surveyId = visitorBackup.surveyId;
    tempData.contactPersonId = visitorBackup.contactPersonId;
    var userInfor = await Utilities().getUserInfor();
    tempData.signInBy = userInfor?.deviceInfo?.id ?? 0;
    var isReplace = (arguments["isReplace"] as bool) ?? false;
    var visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
    if (isReplace) {
      tempData.imagePath = visitorCheckIn.imagePath;
      tempData.imageIdPath = visitorCheckIn.imageIdPath;
    }
    return tempData;
  }

  TextInputType getKeyBoardType(String type) {
    switch (type?.toUpperCase()) {
      case StepType.TEXT:
        return TextInputType.text;

      case StepType.PHONE:
        return TextInputType.number;

      case StepType.EMAIL:
        return TextInputType.emailAddress;

      case StepType.NUMBER:
        return TextInputType.number;

      case StepType.MULTIPLE_TEXT:
        return TextInputType.multiline;

      default:
        return TextInputType.text;
    }
  }

  List<String> getDefaultPurpose(BuildContext context) {
    Constants.DEFAULT_PURPOSE.forEach((element) {
      defaultPurpose.add(AppLocalizations.of(context).translate(element));
    });
    return defaultPurpose;
  }

  List<TextInputFormatter> inputFormat(CheckInFlow item) {
    switch (item?.stepType?.toUpperCase()) {
      case StepType.TEXT:
        {
          if (item?.stepCode == StepCode.FULL_NAME) {
            return <TextInputFormatter>[
              AutoCapWordsInputFormatter(),
              BlacklistingTextInputFormatter(RegExp("[0-9!#\$\"%&'()*+,-./:;<=>?@[\\]^_`{|}~₫¥€§…]")),
              LengthLimitingTextInputFormatter(30),
            ];
          }
          if (item?.stepCode == StepCode.BIRTH_DAY) {
            return <TextInputFormatter>[
              LengthLimitingTextInputFormatter(30),
            ];
          }
          if (item?.stepCode == StepCode.PERMANENT_ADDRESS) {
            return <TextInputFormatter>[
              LengthLimitingTextInputFormatter(150),
            ];
          }
          if (item?.stepCode == StepCode.TO_COMPANY || item?.stepCode == StepCode.FROM_COMPANY) {
            return <TextInputFormatter>[
              AutoCapWordsInputFormatter(),
              BlacklistingTextInputFormatter(RegExp("[!#\$\"%&'()*+,-./:;<=>?@[\\]^_`{|}~₫¥€§…]")),
              LengthLimitingTextInputFormatter(50),
            ];
          }
          return <TextInputFormatter>[
            UpperCaseFirstLetterFormatter(),
            BlacklistingTextInputFormatter(RegExp("[!#\$\"%&'()*+,-./:;<=>?@[\\]^_`{|}~₫¥€§…]")),
            LengthLimitingTextInputFormatter(50),
          ];
        }

      case StepType.PHONE:
        return <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(30),
        ];

      case StepType.EMAIL:
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(30),
        ];

      case StepType.NUMBER:
        return <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(30),
        ];

      case StepType.MULTIPLE_TEXT:
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(200),
        ];

      default:
        return <TextInputFormatter>[
          LengthLimitingTextInputFormatter(30),
        ];
    }
  }

  TextCapitalization checkingCapitalization(CheckInFlow item) {
    if (item?.stepCode == StepCode.FULL_NAME) {
      return TextCapitalization.words;
    }
    return TextCapitalization.sentences;
  }

  FormFieldValidator<String> checkingValidator(CheckInFlow item) {
    switch (item.stepType?.toUpperCase()) {
      case StepType.TEXT:
        if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
          ValidatorLabel _validator = new ValidatorLabel(context);
          _validator.setStrParam(item.stepName);
          if (item.stepCode == StepCode.FULL_NAME) return _validator.validateName;
          return _validator.validateText;
        }
        return null;

      case StepType.MULTIPLE_TEXT:
        if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
          ValidatorLabel _validator = new ValidatorLabel(context);
          _validator.setStrParam(item.stepName);
          if (item.stepCode == StepCode.FULL_NAME) return _validator.validateName;
          return _validator.validateText;
        }
        return null;

      case StepType.PHONE:
        ValidatorLabel _validator = new ValidatorLabel(context);
        if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
          _validator.setStrParam(item.stepName);
          return _validator.validatePhoneNumber;
        }
        return _validator.validatePhoneWithoutRequire;

      case StepType.NUMBER:
        ValidatorLabel _validator = new ValidatorLabel(context);
        if (item.stepCode == StepCode.PHONE_NUMBER) {
          if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
            _validator.setStrParam(item.stepName);
            return _validator.validatePhoneNumber;
          }
          return _validator.validatePhoneWithoutRequire;
        } else if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
          _validator.setStrParam(item.stepName);
          return _validator.validateText;
        }
        return null;

      case StepType.EMAIL:
        ValidatorLabel _validator = new ValidatorLabel(context);
        if (item.getRequestType() == RequestType.ALWAYS || item.getRequestType() == RequestType.FIRST) {
          _validator.setStrParam(item.stepName);
          return _validator.validateEmail;
        }
        return _validator.validateEmailWithoutRequire;

      default:
        return null;
    }
  }

//  Future<List<VisitorType>> getSuggestions(
//      List<VisitorType> list, String query) async {
//    var completer = new Completer<List<VisitorType>>();
//    var convertList = List<VisitorType>();
//    list.forEach((element) {
//      var convertItem = VisitorType(
//          element.settingKey, element.settingValue, element.description);
//      convertList.add(convertItem);
//    });
//    var preferences = await SharedPreferences.getInstance();
//    var langSaved =
//        preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
//    if (!Constants.LIST_LANG.contains(langSaved)) {
//      langSaved = Constants.EN_CODE;
//    }
//    convertList.forEach((element) {
//      mapLang = json.decode(element.description);
//      element.description = mapLang[langSaved];
//    });
//    var returnList = convertList
//        .where((item) =>
//            item.description.toLowerCase().contains(query.toLowerCase()))
//        .toList();
//    completer.complete(returnList);
//    listType = returnList;
//    return completer.future;
//  }

  Future<List<CompanyBuilding>> getSuggestionOffice(List<CompanyBuilding> list, String query) async {
    return await db.companyBuildingDAO.getDataByCompanyName(query);
  }

  Future<List<String>> getSuggestionFromCompany(String query) async {
    return await db.visitorCompanyDAO.searchCompanyNameForVisitor(query);
  }

  List<String> getSuggestionNote(String query) {
    if (query.isEmpty || query == null) {
      return defaultPurpose;
    }
    return defaultPurpose.where((element) => tiengviet(element).contains(tiengviet(query))).toList();
  }

  int getTypeInit(List<VisitorType> list) {
    var convertList = List<VisitorType>();
    list.forEach((element) {
      var convertItem = VisitorType(element.settingKey, element.settingValue, element.description,
          element.isTakePicture, element.isScanIdCard, element.isSurvey, element.isPrintCard, element.allowToDisplayContactPerson);
      convertList.add(convertItem);
    });

//    convertList.forEach((element) {
//      mapLang = json.decode(element.description);
//      element.description = mapLang[langSaved];
//    });

    var settingKey = visitorBackup.visitorType;
    int index;
    if (settingKey != null) {
      convertList.asMap().forEach((key, value) {
        if (value.settingKey.toLowerCase() == settingKey.toLowerCase()) {
          index = key;
        }
      });
    }
    return index;
  }

  Future<List<VisitorType>> getVisitorType(BuildContext context) async {
    var langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    if (!Constants.LIST_LANG.contains(langSaved)) {
      langSaved = Constants.EN_CODE;
    }
    listType = await db.visitorTypeDAO.getAlls();
    listType.removeWhere((element) => element.settingKey == TypeVisitor.DELIVERY);
    listType.forEach((element) {
      element.description = element.settingValue.getValue(langSaved);
    });
    return listType;
  }

  Future<List<CompanyBuilding>> getCompanyBuilding(BuildContext context) async {
    langSaved = preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    if (!Constants.LIST_LANG.contains(langSaved)) {
      langSaved = Constants.EN_CODE;
    }
    var list = await getCompany(context);
    return list;
  }

  Future<List<CompanyBuilding>> getCompany(BuildContext context) async {
    return memCacheCompany.runOnce(() async {
      var completer = new Completer<List<CompanyBuilding>>();
      listCompanyBuilding = await db.companyBuildingDAO.isExistData();
      if (listCompanyBuilding == null) {
        listCompanyBuilding = List();
      }
      completer.complete(listCompanyBuilding);
      return completer.future;
    });
  }

  Future<void> moveToNextPage() async {
    var isReplace = (arguments["isReplace"] as bool) ?? false;
    var isFlowEmpty = (flows == null || flows.isEmpty);
    var visitorCheckIn = isFlowEmpty ? (arguments["visitor"] as VisitorCheckIn) : await _retrieveValues(visitorType);
    var isCapture = await Utilities().checkIsCapture(context, visitorCheckIn?.visitorType);
    if (isReplace) {
      if (isCapture && (visitorCheckIn.imagePath.isEmpty || visitorCheckIn.imagePath == null)) {
        locator<NavigationService>().pushNamedAndRemoveUntil(TakePhotoScreen.route_name, WaitingScreen.route_name,
            arguments: {'visitor': visitorCheckIn, 'isScanId': isScanId, 'isDelivery': isDelivery});
      } else {
        locator<NavigationService>().pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
            arguments: {'visitor': visitorCheckIn, 'isScanId': isScanId, 'isDelivery': isDelivery});
      }
    } else {
      if (await Utilities().isSurveyCustom(context, visitorCheckIn.visitorType)) {
        locator<NavigationService>().navigateTo(SurveyScreen.route_name, 1, arguments: {
          'visitor': visitorCheckIn,
          'isReplace': false,
          'isScanId': isScanId,
          'isDelivery': isDelivery,
          'isCapture': isCapture
        }).then((value) {
          if (isFlowEmpty) {
            navigationService.navigatePop(context);
          }
        });
      } else if (isCapture) {
        locator<NavigationService>().navigateTo(TakePhotoScreen.route_name, 1,
            arguments: {'visitor': visitorCheckIn, 'isReplace': false, 'isScanId': isScanId, 'isDelivery': isDelivery})
            .then((value) {
          if (isFlowEmpty) {
            navigationService.navigatePop(context);
          }
        });
      } else {
        locator<NavigationService>().pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
            arguments: {'visitor': visitorCheckIn, 'isScanId': isScanId, 'isDelivery': isDelivery});
      }
    }
  }

  @override
  void dispose() {
    cancelableRefresh?.cancel();
    cancelableLogout?.cancel();
    cancellableOperation?.cancel();
    super.dispose();
  }
}
