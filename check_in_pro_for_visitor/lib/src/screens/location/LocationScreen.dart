import 'package:auto_size_text/auto_size_text.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/model/BranchInfor.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/location/LocationNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TypeHead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationScreen extends MainScreen {
  static const String route_name = '/location';

  @override
  _LocationScreenState createState() => _LocationScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _LocationScreenState extends MainScreenState<LocationNotifier> {
  final TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var percentBox = isPortrait ? 70 : 50;
    var percentBoxHeight = isPortrait ? 50 : 30;

    return Background(
        isShowBack: false,
        isShowChatBox: false,
        isAnimation: true,
        isOpeningKeyboard: !provider.isShowLogo,
        isShowLogo: provider.isShowLogo,
        type: BackgroundType.MAIN,
        child: Container(
          height: widthScreen * percentBoxHeight,
          child: Column(
            children: <Widget>[
              Container(
                width: widthScreen * percentBox,
                alignment: Alignment.topCenter,
                child: _buildLocationItem(context),
              ),
              SizedBox(
                child: _buildBtnNext(provider),
                width: widthScreen * percentBox,
              )
            ],
          ),
        ));
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowLogo = !visible;
    provider.hideLoading = false;
  }

  Widget _buildLocationItem(BuildContext context) {
    var provider = Provider.of<LocationNotifier>(context, listen: false);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentSuggestHeight = isPortrait ? 40 : 30;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    var aspectRatio = itemWidth / itemHeight;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      aspectRatio = itemHeight / itemWidth;
    }
    return Selector<LocationNotifier, bool>(
      builder: (context, data, child) => FutureBuilder<List<BranchInfor>>(
          future: provider.getLocation(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var listLocation = snapshot.data;
              return TypeAheadField<BranchInfor>(
                hideSuggestionsOnKeyboardHide: false,
                getImmediateSuggestions: true,
                hideOnLoading: true,
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT),
                        side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 1.5)),
                    constraints: BoxConstraints(maxHeight: heightScreen * percentSuggestHeight)),
                textFieldConfiguration: TextFieldConfiguration(
                  focusNode: focusNode,
                  controller: controller,
                  autofocus: provider.autoFocus,
                  onSubmitted: (_) {
                    if (provider.locationInfor == null ||
                        provider.locationInfor.id == null ||
                        controller.text.isEmpty) {
                      provider.handlerError(context, controller.text);
                    }
                  },
                  onTap: () {
                    controller.text = "";
                    provider.locationInfor = null;
                  },
                  onChanged: (_) {
                    provider.locationInfor = null;
                  },
                  style: TextStyle(fontSize: AppDestination.TEXT_BIG),
                  decoration: InputDecoration(
                      errorText: provider.errorText,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 32,
                        color: AppColor.HINT_TEXT_COLOR,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.text = "";
                          provider.locationInfor = null;
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 24,
                          color: AppColor.HINT_TEXT_COLOR,
                        ),
                      ),
                      border: OutlineInputBorder(),
                      hintText: AppLocalizations.of(context).translate(AppString.MESSAGE_SELECT_BRANCH_CHATBOX)),
                ),
                suggestionsCallback: (String pattern) async {
                  return provider.getSuggestions(listLocation, pattern);
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                itemBuilder: (context, BranchInfor suggestion) {
                  return itemLocation(suggestion);
                },
                noItemsFoundBuilder: (context) => itemNone(),
                onSuggestionSelected: (BranchInfor suggestion) {
                  controller.text = suggestion.branchName;
                  provider.errorText = null;
                  provider.locationInfor = suggestion;
                },
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) return Container();
              return CircularProgressIndicator();
            }
          }),
      selector: (buildContext, provider) => provider.isReload,
    );
  }

  Widget _buildBtnNext(LocationNotifier provider) {
    if (!provider.isInit) {
      FocusScope.of(context).requestFocus(focusNode);
      provider.isInit = true;
      provider.autoFocus = true;
    }
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: RaisedGradientButton(
        isLoading: false,
        disable: false,
        btnText: AppLocalizations.of(context).translate(AppString.BTN_CONTINUE),
        onPressed: () {
          Utilities().hideKeyBoard(context);
          if (provider.locationInfor == null || provider.locationInfor.id == null || controller.text.isEmpty) {
            provider.handlerError(context, controller.text);
          } else {
            provider.moveToInputDevice(context, provider.locationInfor.branchId, true);
          }
        },
      ),
    );
  }

  Widget itemLocation(BranchInfor locationInfor) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 70 : 50;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.language,
            size: 32,
            color: AppColor.HINT_TEXT_COLOR,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: (widthScreen * percentBox) - 55,
              child: AutoSizeText(locationInfor.branchName,
                  maxLines: 3,
                  minFontSize: 8,
                  maxFontSize: 16,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL)),
            ),
            SizedBox(
                width: (widthScreen * percentBox) - 55,
                child: AutoSizeText(locationInfor?.branchAddress ?? "",
                    maxLines: 3,
                    minFontSize: 8,
                    maxFontSize: 16,
                    style: TextStyle(fontSize: AppDestination.TEXT_NORMAL - 5))),
          ],
        )
      ],
    );
  }

  Widget itemNone() {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var percentBox = isPortrait ? 60 : 40;
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.sentiment_very_dissatisfied,
            size: 32,
            color: AppColor.HINT_TEXT_COLOR,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: widthScreen * percentBox,
              child: Text(AppLocalizations.of(context).noData,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppDestination.TEXT_NORMAL + 5)),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
