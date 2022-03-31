import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'SaverNotifier.dart';

class SaverScreen extends MainScreen {
  static const String route_name = '/SaverScreen';

  @override
  SaverScreenState createState() => SaverScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class SaverScreenState extends MainScreenState<SaverNotifier> with WidgetsBindingObserver {
  bool isInit = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!isInit) {
      isInit = true;
      provider.firebaseCloudMessaging_Listeners();
      provider.runClock();
    }
    List<String> listImage = provider.arguments["listImage"] as List<String>;
    String currentLang = provider.arguments["lang"] as String;
    String companyNameColor = provider.arguments["companyNameColor"] as String;
    var haveColor = companyNameColor != null && companyNameColor.isNotEmpty;
    Color colorComponent = haveColor ? Color(int.parse(companyNameColor)) : AppColor.TEXT_IN_BLUE_TIME;
    var timeSize = isPortrait ? SizeConfig.safeBlockHorizontal * 8 : SizeConfig.safeBlockVertical * 8;
    var dateSize = isPortrait ? SizeConfig.safeBlockHorizontal * 3 : SizeConfig.safeBlockVertical * 3;
    bool isDefault;
    if (listImage != null && listImage.isNotEmpty) {
      isDefault = false;
    } else {
      listImage = ["0", "1", "2"];
      isDefault = true;
    }
    return Scaffold(
      body: GestureDetector(
        onTap: () => provider.navigationService.navigatePop(context),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: CarouselSlider(
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
                aspectRatio: MediaQuery.of(context).size.aspectRatio,
                autoPlay: listImage.length > 1,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(milliseconds: Constants.WAITING_AUTO_PLAY),
                autoPlayCurve: Curves.ease,
                items: listImage.asMap().entries.map(
                  (entry) {
                    return buildImageItem(isDefault, entry.key, entry.value);
                  },
                ).toList(),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(
                  top: AppDestination.PADDING_WAITING + 5,
                  right: AppDestination.PADDING_WAITING_HORIZONTAL,
                ),
                child: Wrap(
                  children: <Widget>[
                    Consumer<SaverNotifier>(
                      builder: (context, data, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              mainAxisSize: MainAxisSize.min,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(
                                  provider.utilities.getTimeFormat(context, currentLang)[0],
                                  style:
                                  TextStyle(color: colorComponent, fontWeight: FontWeight.w300, fontSize: timeSize),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                if (!MediaQuery.of(context).alwaysUse24HourFormat)
                                  Text(
                                    provider.utilities.getTimeFormat(context, currentLang)[1],
                                    style: TextStyle(
                                        color: colorComponent, fontWeight: FontWeight.w300, fontSize: timeSize / 2),
                                  )
                              ],
                            ),
                            Text(
                              DateFormat.yMMMEd(currentLang).format(DateTime.now()),
                              style: TextStyle(color: colorComponent, fontSize: dateSize),
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            )
          ],),
      ),
    );
  }

  Widget buildImageItem(bool isDefault, int index, String value) {
    provider.utilities.printLog("pathhhhhh: $value");
    var image;
    if (isDefault) {
      image = AssetImage("assets/images/waiting$index.png");
      return buildImageContainer(image);
    } else {
      try {
        image = Image.memory(
          File(value).readAsBytesSync(),
          fit: BoxFit.cover,
        ).image;
      } catch (e) {
        image = AssetImage("assets/images/waiting$index.png");
      }
      return buildImageContainer(image);
    }
  }

  Container buildImageContainer(image) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          provider.navigationService.navigatePop(context);
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
