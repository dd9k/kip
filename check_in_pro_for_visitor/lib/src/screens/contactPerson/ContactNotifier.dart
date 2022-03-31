import 'dart:async';

import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/ContactPerson.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:check_in_pro_for_visitor/src/model/ListContact.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:flutter/cupertino.dart';

class ContactNotifier extends MainNotifier {
  String hintText;
  bool isShowFocusNode = false;
  FocusNode focusNode = FocusNode();
  List<ContactPerson> listContact = List();
  Timer timerDelaySearch;
  int pageIndex = 1;
  int totalCount = 1;
  bool isUpdating = false;
  bool isLoading = false;
  bool isOpeningKeyboard = false;
  CancelableOperation cancelSearch;

  void focusChange(BuildContext context) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = "";
        isShowFocusNode = true;
        notifyListeners();
      } else {
        hintText = appLocalizations.contactSearchHint2;
        isShowFocusNode = false;
        notifyListeners();
      }
    });
  }

  Future<void> moveToNext(BuildContext context, ContactPerson contactPerson) async {
    VisitorCheckIn visitorCheckIn = arguments["visitor"] as VisitorCheckIn;
    if (contactPerson != null) {
      visitorCheckIn.contactPersonId = contactPerson.id;
    }
    bool isCapture = (arguments["isCapture"] as bool) ?? false;
    bool isHaveAlways = (arguments["isHaveAlways"] as bool) ?? false;
    bool isReturn = (arguments["isReturn"] as bool) ?? false;
    utilities.hideKeyBoard(context);
    arguments["visitor"] = visitorCheckIn;
    arguments["isShowBack"] = true;
    if (isHaveAlways || !isReturn) {
      navigationService.navigateTo(InputInformationScreen.route_name, 1, arguments: arguments);
    } else if (await utilities.isSurveyCustom(context, visitorCheckIn.visitorType)) {
      navigationService.navigateTo(SurveyScreen.route_name, 1, arguments: arguments);
    } else if (isCapture) {
      navigationService.navigateTo(TakePhotoScreen.route_name, 1, arguments: arguments);
    } else {
      navigationService.pushNamedAndRemoveUntil(ReviewCheckInScreen.route_name, WaitingScreen.route_name,
          arguments: arguments);
    }
  }

  getContactPerson(BuildContext context, String input, bool isUpdate) async {
    timerDelaySearch?.cancel();
    if (input == null || input.length < 2) {
      clearList();
    } else {
      isLoading = true;
      if (isUpdate) {
        isUpdating = true;
        pageIndex++;
      } else {
        pageIndex = 1;
      }
      notifyListeners();
      timerDelaySearch = Timer(Duration(milliseconds: Constants.DELAY_SEARCH), () async {
        ApiCallBack listCallBack = ApiCallBack((BaseResponse baseResponse) async {
          //Callback SUCCESS
          isLoading = false;
          if (baseResponse.data == null) {
            clearList();
            return;
          }
          var data = ListContact.fromJson(baseResponse.data);
          if (data != null && data.listContact != null) {
            var listResponse = data.listContact;
            totalCount = data.totalCount;
            if (isUpdate) {
              List<ContactPerson> convertList = List();
              convertList.addAll(listContact);
              convertList.addAll(listResponse);
              listContact = convertList;
              isUpdating = false;
            } else {
              listContact = listResponse;
            }
            notifyListeners();
          } else {
            clearList();
          }
        }, (Errors message) async {
          //Callback ERROR
          isLoading = false;
          totalCount = 0;
          if (!isUpdate) {
            clearList();
          } else {
            isUpdating = false;
            pageIndex--;
          }
          notifyListeners();
        });
        var currentInfor = await utilities.getUserInfor();
        var branchId = currentInfor?.deviceInfo?.branchId ?? 0.0;
        cancelSearch = CancelableOperation.fromFuture(
          ApiRequest().requestSearchContact(context, input, pageIndex, branchId, listCallBack),
          onCancel: () => {},
        );
      });
    }
  }

  void clearList() {
    listContact = List();
    isUpdating = false;
    isLoading = false;
    pageIndex = 1;
    cancelSearch?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    cancelSearch?.cancel();
    super.dispose();
  }
}
