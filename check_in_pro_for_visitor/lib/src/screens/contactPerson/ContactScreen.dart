import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/model/ContactPerson.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactNotifier.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends MainScreen {
  static const String route_name = '/contactScreen';

  @override
  _ContactScreenState createState() => _ContactScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _ContactScreenState extends MainScreenState<ContactNotifier> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange &&
          !provider.isUpdating &&
          provider.listContact.length < provider.totalCount) {
        provider.getContactPerson(context, controller.text, true);
      }
//      if (scrollController.offset <= scrollController.position.minScrollExtent &&
//          !scrollController.position.outOfRange) {
//
//      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    provider.focusChange(context);
    var isLandscape = !isPortrait;
    var _crossAxisSpacing = 20.0;
    var _gridHeight = heightScreen * 55;
    var _gridWidth = widthScreen * 90;
    var _crossAxisCount = isLandscape ? 3 : 2;
    var _mainAxisCount = isLandscape ? 3 : 5;
    var _mainAxisSpacing = 10.0;

    var _height = (_gridWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) / _crossAxisCount;
    var _divide = isLandscape ? 2 : 4;
    var _cellWidth = (_gridHeight / _mainAxisCount) - ((_mainAxisCount - _divide) * _mainAxisSpacing);
    var _aspectRatio = _height / _cellWidth;

    var sizeImage = _cellWidth * 0.7;
    var spacingRowChild = 10.0;
    var sizeBoxWidth = _height - spacingRowChild * 2 - sizeImage - 5;
    return Background(
        isOpeningKeyboard: provider.isOpeningKeyboard,
        isShowStepper: true,
        isShowBack: true,
        isShowLogo: false,
        isShowChatBox: false,
        enableScroll: true,
        isShowClock: true,
        isRightBtn: true,
        type: BackgroundType.MAIN,
        callbackRight: () => provider.moveToNext(context, null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appLocalizations.contactTitle,
              style: TextStyle(fontFamily: Styles.Montserrat, fontSize: 27, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: widthScreen * 42,
              child: Selector<ContactNotifier, bool>(
                builder: (context, data, child) {
                  return TextFormField(
                      controller: controller,
                      focusNode: provider.focusNode,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          suffixIcon: provider.isShowFocusNode
                              ? GestureDetector(
                                  onTap: () {
                                    controller.clear();
                                    provider.clearList();
                                  },
                                  child: Container(
                                    height: 56,
                                    width: 56,
                                    child: Icon(
                                      Icons.cancel,
                                      size: 24,
                                      color: AppColor.HINT_TEXT_COLOR,
                                    ),
                                  ),
                                )
                              : null,
                          hintText: provider.hintText ?? appLocalizations.contactSearchHint2,
                          hintStyle: TextStyle(color: AppColor.HINT_TEXT_COLOR)),
                      onChanged: (text) {
                        provider.getContactPerson(context, text, false);
                        provider.utilities.moveToWaiting();
                      },
                      onTap: () => provider.utilities.moveToWaiting(),
                      onEditingComplete: () {
                        provider.utilities.hideKeyBoard(context);
                      },
                      style: Styles.formFieldText);
                },
                selector: (buildContext, provider) => provider.isShowFocusNode,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: _gridHeight,
              width: _gridWidth,
              child: Selector<ContactNotifier, bool>(
                builder: (context, isLoading, child) {
                  return Selector<ContactNotifier, List<ContactPerson>>(
                    builder: (context, data, child) {
                      if (!isLoading && (data == null || data.isEmpty)) {
                        return buildNoData();
                      }
                      int lengthData;
                      if (isLoading && !provider.isUpdating) {
                        lengthData = 9;
                      } else if (isLoading && provider.isUpdating) {
                        lengthData = data.length + (_crossAxisCount - (data.length % _crossAxisCount));
                      } else {
                        lengthData = data.length;
                      }
                      return GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: _crossAxisCount,
                        childAspectRatio: _aspectRatio,
                        controller: scrollController,
                        shrinkWrap: true,
                        crossAxisSpacing: isLandscape ? _crossAxisSpacing : _mainAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        scrollDirection: Axis.vertical,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(lengthData, (index) {
                          if (isLoading && !provider.isUpdating) {
                            return buildItemLoading(sizeImage, spacingRowChild, sizeBoxWidth);
                          }
                          if (index < data.length) {
                            return buildItemContact(data, index, sizeImage, context, spacingRowChild, sizeBoxWidth);
                          } else {
                            return buildItemLoading(sizeImage, spacingRowChild, sizeBoxWidth);
                          }
                        }),
                      );
                    },
                    selector: (buildContext, provider) => provider.listContact,
                  );
                },
                selector: (buildContext, provider) => provider.isLoading,
              ),
            )
          ],
        ));
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isOpeningKeyboard = visible;
  }

  Widget buildItemLoading(double sizeImage, double spacingRowChild, double sizeBoxWidth) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: spacingRowChild,
          ),
          Container(
              width: sizeImage,
              height: sizeImage,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(360.0) //         <--- border radius here
                    ),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(360.0)),
                child: OverflowBox(
                  alignment: Alignment.center,
                  child: Shimmer(
                    baseColor: AppColor.BASE_LOADING,
                    highlightColor: AppColor.HIGHLIGHT_LOADING,
                    child: Container(
                      color: AppColor.BACKGROUND_LOADING,
                      width: sizeImage,
                      height: sizeImage,
                    ),
                  ),
                ),
              )),
          SizedBox(
            width: spacingRowChild,
          ),
          Container(
            width: sizeBoxWidth,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Shimmer(
                    baseColor: AppColor.BASE_LOADING,
                    highlightColor: AppColor.HIGHLIGHT_LOADING,
                    child: Container(
                      color: AppColor.BACKGROUND_LOADING,
                      width: 200,
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Shimmer(
                    baseColor: AppColor.BASE_LOADING,
                    highlightColor: AppColor.HIGHLIGHT_LOADING,
                    child: Container(
                      color: AppColor.BACKGROUND_LOADING,
                      width: 200,
                      height: 15,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Shimmer(
                    baseColor: AppColor.BASE_LOADING,
                    highlightColor: AppColor.HIGHLIGHT_LOADING,
                    child: Container(
                      color: AppColor.BACKGROUND_LOADING,
                      width: 200,
                      height: 15,
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  GestureDetector buildItemContact(List<ContactPerson> data, int index, double sizeImage, BuildContext context,
      double spacingRowChild, double sizeBoxWidth) {
    ContactPerson contactPerson = data[index];
    Image image;
    if (contactPerson.avatarFileName == null || contactPerson.avatarFileName.isEmpty) {
      image = Image.asset("assets/images/default_avatar.png",
          cacheWidth: sizeImage.toInt(), cacheHeight: sizeImage.toInt(), fit: BoxFit.cover);
    } else {
      image = Image.network(contactPerson.avatarFileName, fit: BoxFit.cover);
    }
    return GestureDetector(
      onTap: () => provider.moveToNext(context, contactPerson),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 1),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: spacingRowChild,
            ),
            Container(
                width: sizeImage,
                height: sizeImage,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(360.0) //         <--- border radius here
                      ),
                  color: Colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(360.0)),
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: image,
                  ),
                )),
            SizedBox(
              width: spacingRowChild,
            ),
            Container(
              width: sizeBoxWidth,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      contactPerson.fullName ?? "",
                      style: TextStyle(fontFamily: Styles.Montserrat, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    if (contactPerson?.phone?.isNotEmpty == true)
                      SizedBox(
                        height: 5,
                      ),
                    if (contactPerson?.phone?.isNotEmpty == true)
                      Text(contactPerson.phone,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, fontFamily: Styles.Montserrat)),
                    if (contactPerson?.jobTitle?.isNotEmpty == true)
                      SizedBox(
                        height: 5,
                      ),
                    if (contactPerson?.jobTitle?.isNotEmpty == true)
                      Text(contactPerson.jobTitle,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300, fontFamily: Styles.Montserrat)),
                    if (contactPerson?.department?.isNotEmpty == true)
                      SizedBox(
                        height: 5,
                      ),
                    if (contactPerson?.department?.isNotEmpty == true)
                      Text(contactPerson.department,
                          style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              fontFamily: Styles.Montserrat)),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNoData() {
    if (controller.text == null || controller.text.length < 2) {
      return Container();
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            Icons.contact_phone,
            size: 128,
            color: AppColor.LINE_COLOR,
          ),
          Text(appLocalizations.noContact,
              style: TextStyle(
                fontFamily: Styles.Montserrat,
                fontSize: AppDestination.TEXT_BIG,
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
