import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoNotifier.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ProcessWaiting.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TemplatePrint.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class TakePhotoScreen extends MainScreen {
  static const String route_name = '/takePhoto';
  static const String route_name_temp = '/takePhotoTemp';

  @override
  TakePhotoScreenState createState() => TakePhotoScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class TakePhotoScreenState extends MainScreenState<TakePhotoNotifier> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = SizeConfig.safeBlockHorizontal * 70;
    provider.isScanId = (provider.arguments["isScanId"] as bool) ?? false;
    var visitor = provider.arguments["visitor"] as VisitorCheckIn;
    var isShowBack = (provider.arguments["isShowBack"] as bool) ?? true;
    var isReplace = (provider.arguments["isReplace"] as bool) ?? false;
    var isQRScan = (provider.arguments["isQRScan"] as bool) ?? false;
    if (isPortrait) {
      size = SizeConfig.safeBlockHorizontal * 70;
    } else {
      size = SizeConfig.safeBlockVertical * 70;
    }
    var countDownText = isPortrait ? SizeConfig.safeBlockHorizontal * 10 : SizeConfig.safeBlockVertical * 10;
    return Stack(
      children: <Widget>[
        Selector<TakePhotoNotifier, String>(
            builder: (context, data, child) {
              return FutureBuilder<SharedPreferences>(
                future: provider.getType(context, visitor.visitorType),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                    var badgeTemplate = snapshot.data.getString(Constants.KEY_BADGE_PRINTER);
                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: RepaintBoundary(
                          key: provider.repaintBoundary,
                          child: Container(
                            height: AppDestination.CARD_HEIGHT,
                            width: AppDestination.CARD_WIGHT,
                            color: Colors.white,
                            child: new Center(child: cardTemplate(badgeTemplate)),
                          )),
                    );
                  }
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: RepaintBoundary(
                        key: provider.repaintBoundary,
                        child: Container(
                          height: AppDestination.CARD_HEIGHT,
                          width: AppDestination.CARD_WIGHT,
                          color: Colors.white,
                          child: new Center(child: cardTemplate(null)),
                        )),
                  );
                },
              );
            },
            selector: (buildContext, provider) => provider.inviteCode),
        Selector<TakePhotoNotifier, bool>(
            builder: (context, data, child) {
              return Background(
                isShowStepper: !isReplace && !isQRScan,
                timeOutInit: provider.isCountDown ? Constants.DONE_TAKE_PHOTO : null,
                isShowBack: isShowBack,
                type: BackgroundType.MAIN,
                isShowChatBox: false,
                initState: !provider.parent.isOnlineMode,
                messSnapBar: AppLocalizations.of(context).messOffMode,
                isShowClock: provider.isCountDown,
                isShowLogo: false,
                child: Selector<TakePhotoNotifier, bool>(
                    builder: (context, data, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Stack(
                            children: [
                              Selector<TakePhotoNotifier, bool>(
                                  builder: (context, data, child) {
                                    if (!data) {
                                      return FutureBuilder<void>(
                                        future: provider.initializeController(context),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return NativeDeviceOrientationReader(
                                                builder: (context1) {
                                                  NativeDeviceOrientation orientation = NativeDeviceOrientationReader.orientation(context1);

                                                  switch (orientation) {
                                                    case NativeDeviceOrientation.landscapeLeft:
                                                      provider.turnCamera = -1;
                                                      break;
                                                    case NativeDeviceOrientation.landscapeRight:
                                                      provider.turnCamera = 1;
                                                      break;
                                                    case NativeDeviceOrientation.portraitDown:
                                                      provider.turnCamera = 2;
                                                      break;
                                                    case NativeDeviceOrientation.portraitUp:
                                                      provider.turnCamera = 0;
                                                      break;
                                                    default:
                                                      provider.turnCamera = 0;
                                                      break;
                                                  }
                                                  return Stack(
                                                    fit: StackFit.passthrough,
                                                    children: <Widget>[
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: _buildCameraPreview(
                                                              CameraPreview(provider.controller),
                                                              size)),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            return Align(
                                                alignment: Alignment.center,
                                                child: _buildCameraPreview(
                                                    null, size));
                                          }
                                        },
                                      );
                                    }
                                    if (provider.visibleButton) {
                                      provider.countDownToNext(context);
                                    }

                                    return _buildPicturePreview(size);
                                  },
                                  selector: (buildContext, provider) =>
                                  provider.reloadCamera),
                              Selector<TakePhotoNotifier, String>(
                                  builder: (context, data, child) {
                                    return Positioned.fill(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            provider.message,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: countDownText,
                                                color: AppColor.MAIN_TEXT_COLOR,
                                                decoration: TextDecoration.none),
                                          )),
                                    );
                                  },
                                  selector: (buildContext, provider) => provider.message),
                              Selector<TakePhotoNotifier, bool>(
                                  builder: (context, data, child) {
                                    return Visibility(
                                      visible: data,
                                      child: Positioned.fill(
                                        child: Align(alignment: Alignment.center, child: CircularProgressIndicator()),
                                      ),
                                    );
                                  },
                                  selector: (buildContext, provider) => provider.isLoading)
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Selector<TakePhotoNotifier, bool>(
                              builder: (context, data, child) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    if (!provider.visibleButton)
                                      SizedBox(
                                        width: 250,
                                        child: RaisedGradientButton(
                                          isLoading: false,
                                          disable: false,
                                          btnText: AppLocalizations.of(context).takePicture,
                                          onPressed: () {
                                            provider.takePhoto(context);
                                          },
                                        ),
                                      ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    if (provider.visibleButton)
                                      SizedBox(
                                        width: 250,
                                        child: RaisedGradientButton(
                                          styleEmpty: true,
                                          isLoading: false,
                                          disable: false,
                                          btnText: AppLocalizations.of(context).takeNewPicture,
                                          onPressed: () {
                                            provider.takePhotoAgain(context);
                                          },
                                        ),
                                      ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    if (provider.visibleButton)
                                      SizedBox(
                                        width: 250,
                                        child: RaisedGradientButton(
                                          isLoading: false,
                                          disable: false,
                                          btnText: AppLocalizations.of(context).btnOk,
                                          onPressed: () {
                                            provider.doNext(context);
                                          },
                                        ),
                                      ),
                                  ],
                                );
                              },
                              selector: (buildContext, provider) => provider.visibleButton),
                        ],
                      );
                    },
                    selector: (buildContext, provider) => provider.isRebuild),
              );
            },
            selector: (buildContext, provider) => provider.isCountDown),
        _buildProcessWaiting()
      ],
    );
  }

  Widget cardTemplate(String badgeIndex) {
    return TemplatePrint(
      visitorName: provider.visitor.fullName ?? "",
      phoneNumber: provider.visitor.phoneNumber ?? "",
      fromCompany: provider.visitor.fromCompany ?? "",
      toCompany: provider.visitor.toCompany ?? "",
      visitorType: provider.visitorType,
      idCard: provider.visitor.idCard ?? "",
      indexTemplate: badgeIndex,
      printerModel: provider.printer,
      inviteCode: provider.inviteCode,
      badgeTemplate: provider.eventDetail?.getBadgeTemplate(provider.langSaved),
      isBuilding: provider.isBuilding,
      floor: provider.visitor.floor,
    );
  }

  Widget _buildCameraPreview(CameraPreview cameraPreview, double size) {
    return buildCircleLayout(
        size,
        FittedBox(
          fit: BoxFit.cover,
          child: Container(
            width: size,
            height: (cameraPreview == null || provider.controller == null || !provider.controller.value.isInitialized)
                ? size
                : size / provider.controller.value.aspectRatio,
            child: (cameraPreview == null || provider.controller == null)
                ? Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  appLocalizations.loadingCamera,
                  style: TextStyle(color: AppColor.HINT_TEXT_COLOR, fontSize: AppDestination.TEXT_NORMAL),
                ),
              ),
            )
                : cameraPreview, // this is my CameraPreview
          ),
        ),
        true);
  }

  Widget _buildPicturePreview(double size) {
    return buildCircleLayout(
        size,
        Container(
          width: size,
          height: size,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.file(
              File(provider.path),
              fit: BoxFit.cover,
            ),
          ), // this is my CameraPreview
        ),
        false);
  }

  Widget buildCircleLayout(double size, Widget child, bool isTurn) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Container(
        width: isPortrait ? size : size * 1.25,
        height: isPortrait ? size : size,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: RotatedBox(
          quarterTurns: isTurn ? provider.turnCamera : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: OverflowBox(
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ));
  }

  Widget _buildProcessWaiting() {
    return Selector<TakePhotoNotifier, bool>(
        builder: (cx, data, child) {
          return Selector<TakePhotoNotifier, String>(
              builder: (cx, message, child) {
                return ProcessWaiting(
                  message: message,
                  isVisible: data,
                );
              },
              selector: (buildContext, provider) => provider.messagePopup);
        },
        selector: (buildContext, provider) => provider.isProcessing);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          provider.takePhotoAgain(context);
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }
}
