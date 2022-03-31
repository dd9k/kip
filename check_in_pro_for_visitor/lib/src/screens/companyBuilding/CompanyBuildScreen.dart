import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/CompanyBuilding.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:provider/provider.dart';

import 'CompanyBuildingNotifier.dart';
import 'flappy_search_bar.dart';

class CompanyBuildingScreen extends MainScreen {
  static const String route_name = '/companyBuilding';

  @override
  _CompanyBuildingScreenState createState() => _CompanyBuildingScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class _CompanyBuildingScreenState extends MainScreenState<CompanyBuildingNotifier> {
  ScrollController scrollController = ScrollController();
  ScrollController scrollGridController = ScrollController();
  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Background(
      isOpeningKeyboard: !provider.isShowLogo,
      isShowBack: true,
      isRightBtn: true,
      isShowLogo: false,
      isShowClock: true,
      messSnapBar: appLocalizations.messOffline,
      isShowChatBox: Utilities().isShowForChatBox(context, provider.isShowForChatBox(context)),
      isAnimation: false,
      scrollController: scrollController,
      contentChat: AppLocalizations.of(context).translate(AppString.MESSAGE_INPUT_INFORMATION_CHATBOX),
      type: BackgroundType.MAIN,
      callbackRight: () => provider.navigationService.navigatePop(context),
      child: buildCompanyBuildingCard(),
      searchBar: searchAction(context),
    );
  }

  Widget buildCompanyBuildingCard() {
    return Selector<CompanyBuildingNotifier, bool>(
      builder: (context, data, child) => FutureBuilder<List<CompanyBuilding>>(
          future: provider.getCompanySearch(null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var companyBuilding = snapshot.data;
              if (companyBuilding.isEmpty) {
                return Center(
                  child: AutoSizeText(appLocalizations.noCompany,
                      style: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.w500, fontFamily: "Helvetica-Light", fontSize: 25)),
                );
              }
              return layoutGridViewList(context, companyBuilding);
            } else {
              return CircularProgressIndicator();
            }
          }),
      selector: (buildContext, provider) => provider.isReloadCompany,
    );
  }

  Widget cardGridView(CompanyBuilding companyBuilding) {
    return FutureBuilder<File>(
      future: Utilities().getLocalFile(
          Constants.FOLDER_TEMP, Constants.FILE_TYPE_COMPANY_BUILDING, companyBuilding.index.toString(), null),
      builder: (context, snapshot) {
        Image image;
        if (snapshot.hasData) {
          try {
            image = Image.memory(
              snapshot.data.readAsBytesSync(),
              fit: BoxFit.cover,
            );
          } catch (e) {
            image = Image.asset(
              "assets/images/temp_company.png",
              fit: BoxFit.cover,
            );
          }
        } else {
          image = null;
        }
        return new Container(
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColor.MAIN_TEXT_COLOR, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(flex: 1, child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: image,
                    ),),
                    Container(height: 5, decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColor.MAIN_TEXT_COLOR,
                          width: 0.5,
                        ),
                      ),
                    )),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 2,
                        ),
                        AutoSizeText(
                          companyBuilding.shortName,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Helvetica-Light",
                              fontSize: 25),
                        ),
                        Container(
                          height: 10,
                        ),
                        AutoSizeText(
                          appLocalizations.floorText + " " + companyBuilding.floor,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Helvetica-Light",
                              fontSize: 18),
                        ),
                        Container(
                          height: 2,
                        ),
                      ],
                    ),
                  ],
                )));
      },
    );
  }

  Widget layoutGridViewList(BuildContext context, List<CompanyBuilding> companyBuilding) {
    if (!isInit) {
      isInit = true;
      scrollController.addListener(() {
        Utilities().moveToWaiting();
      });
    }
    return Column(
      children: <Widget>[
        Container(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.all(20.0),
          child: new GridView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 10.0,
            ),
            controller: scrollGridController,
            padding: EdgeInsets.all(0.0),
            addAutomaticKeepAlives: true,
            itemCount: companyBuilding.length,
            itemBuilder: (BuildContext context, int index) {
              return InkResponse(
                child: cardGridView(companyBuilding[index]),
                onTap: () {
                  provider.moveToNextScreen(context, companyBuilding[index]);
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget searchAction(BuildContext context) {
    return SearchBar<CompanyBuilding>(
      onSearch: provider.getCompanySearch,
      listPadding: EdgeInsets.all(0.0),
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      cancellationWidget: AutoSizeText("${AppLocalizations.of(context).cancel}",
          minFontSize: 10.0,
          maxLines: 1,
          style: TextStyle(
              color: Colors.blue[700], fontWeight: FontWeight.w500, fontFamily: "Helvetica-Light", fontSize: 25)),
      onItemFound: (CompanyBuilding post, int index) {
        return InkResponse(
          child: cardGridView(post),
          onTap: () {
            provider.moveToNextScreen(context, post);
          },
        );
      },
      onCancelled: (){
        provider.searchCompany(null);
    },
      textStyle:
          TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontFamily: "Helvetica-Light", fontSize: 18),
      hintText: AppLocalizations.of(context).hintSearch,
      emptyWidget: Center(
        child: AutoSizeText(appLocalizations.noCompany,
            style: TextStyle(
                color: Colors.blue[700], fontWeight: FontWeight.w500, fontFamily: "Helvetica-Light", fontSize: 25)),
      ),
      onChanged: (text) {
        provider.searchCompany(text);
      },
    );
  }

  @override
  void onKeyboardChange(bool visible) {
    provider.isShowLogo = !visible;
    provider.hideLoading = false;
  }

  @override
  void dispose() {
    scrollController?.dispose();
    scrollGridController?.dispose();
    super.dispose();
  }
}
