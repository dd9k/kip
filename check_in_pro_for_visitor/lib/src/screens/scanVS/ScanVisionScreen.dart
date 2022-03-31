import 'dart:io';
import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/screens/MainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScannerOverlayShape.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/Background.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ring.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/three_bounce.dart';
import 'package:flutter/material.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:provider/provider.dart';

class ScanVisionScreen extends MainScreen {
  static const String route_name = '/scanid';

  @override
  ScanVisionScreenState createState() => ScanVisionScreenState();

  @override
  String getNameScreen() {
    return route_name;
  }
}

class ScanVisionScreenState extends MainScreenState<ScanVisionNotifier> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var size = widthScreen * 60;
    if (isPortrait) {
      size = widthScreen * 80;
    } else {
      size = heightScreen * 80;
    }
    var countDownText = isPortrait ? widthScreen * 10 : heightScreen * 10;
    var isReplace = provider.arguments["isReplace"] as bool ?? false;
    return Stack(
      children: <Widget>[
        Background(
          isShowBack: true,
          isShowClock: true,
          type: BackgroundType.SCAN_ID,
          isShowChatBox: false,
          isShowLogo: !isReplace,
          child: Selector<ScanVisionNotifier, bool>(
              builder: (context, data, child) {
                return Stack(
                  children: [
                    Selector<ScanVisionNotifier, bool>(
                        builder: (context, data, child) {
                          if (!data) {
                            return FutureBuilder<void>(
                              future: provider.initializeController(context),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return NativeDeviceOrientationReader(builder: (context1) {
                                    NativeDeviceOrientation orientation =
                                        NativeDeviceOrientationReader.orientation(context1);
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
                                        _buildCameraPreview(CameraPreview(provider.controller), size, provider),
                                        Align(
                                            alignment: Alignment.center,
                                            child: _buildOverlayPreview(null, size, provider, isPortrait)),
                                        buildBtnTake(isPortrait, provider, context)
                                      ],
                                    );
                                  });
                                } else {
                                  return Align(
                                      alignment: Alignment.center, child: _buildCameraPreview(null, size, provider));
                                }
                              },
                            );
                          }
                          return _buildPicturePreview(size, provider);
                        },
                        selector: (buildContext, provider) => provider.reloadCamera),
                    _buildProcessWaiting()
                  ],
                );
              },
              selector: (buildContext, provider) => provider.isRebuild),
          callbackRight: () {
            if (provider.isTakePhoto) {
              return;
            }
            provider.initDataBackup(provider.visitorBackup);
            provider.moveToNextPage(context, provider.visitorBackup, null, true);
          },
          callback: () {
            provider.capAgain = false;
            provider.timerTakePhoto?.cancel();
            provider.timerNext?.cancel();
            provider.controller?.dispose();
          },
        ),
        Selector<ScanVisionNotifier, String>(
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
      ],
    );
  }

  Positioned buildBtnTake(bool isPortrait, ScanVisionNotifier provider, BuildContext context) {
    var sizeBtn = 75.0;
    return Positioned.fill(
        child: Padding(
      padding: EdgeInsets.only(top: (isPortrait ? widthScreen * 40 : heightScreen * 50) + sizeBtn * 2 + 20),
      child: Align(
        alignment: Alignment.center,
        child: RaisedButton(
          onPressed: () => provider.takePhoto(context),
          color: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDestination.RADIUS_TEXT_INPUT)),
          child: Container(
              width: sizeBtn,
              height: sizeBtn,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF958493), width: 5.0),
                borderRadius: BorderRadius.all(Radius.circular(50.0) //         <--- border radius here
                    ),
                color: Color(0xFFFAFAFA),
              )),
        ),
      ),
    ));
  }

  Widget _buildOverlayPreview(CameraPreview cameraPreview, double size, ScanVisionNotifier provider, bool isPortrait) {
    var width = isPortrait ? widthScreen * 40 : heightScreen * 50;
    var height = width * 0.6;
    return buildCircleLayout(
        size,
        FittedBox(
            fit: BoxFit.cover,
            child: Stack(
              children: <Widget>[
                Container(
                  width: size,
                  height: (cameraPreview == null || provider.controller == null)
                      ? size
                      : size / provider.controller.value.aspectRatio,
                  child: null,
                  decoration: ShapeDecoration(
                    shape: ScannerOverlayShape(
                        borderColor: Colors.white,
                        borderWidth: 3.0,
                        cutOutSizeWidth: isPortrait ? width : height,
                        cutOutSizeHeight: isPortrait ? height : width),
                  ),
                ),
              ],
            )),
        provider,
        true);
  }

  Widget _buildProcessWaiting() {
    return Selector<ScanVisionNotifier, bool>(
        builder: (cx, data, child) {
          return Center(
            child: AnimatedOpacity(
              opacity: data ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: 400,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: const SpinKitRing(
                                color: AppColor.MAIN_TEXT_COLOR,
                                lineWidth: 3.0,
                                size: 40,
                              ),
                            ),
                            Text(AppLocalizations.of(context).waitingTitleScan,
                                style: TextStyle(
                                  fontSize: AppDestination.TEXT_BIG_WEL,
                                  color: AppColor.MAIN_TEXT_COLOR,
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: const SpinKitThreeBounce(
                                color: AppColor.MAIN_TEXT_COLOR,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ))),
            ),
          );
        },
        selector: (buildContext, provider) => provider.isProcessing);
  }

  Widget _buildCameraPreview(CameraPreview cameraPreview, double size, ScanVisionNotifier provider) {
    return buildCircleLayout(
        size,
        FittedBox(
          fit: BoxFit.cover,
          child: Container(
            width: size,
            height: (cameraPreview == null || provider.controller == null)
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
        provider,
        true);
  }

  Widget _buildPicturePreview(double size, ScanVisionNotifier provider) {
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
        provider,
        false);
  }

  Widget buildCircleLayout(double size, Widget child, ScanVisionNotifier provider, bool isTurn) {
    return Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.MAIN_TEXT_COLOR, width: 0.0),
          color: Colors.transparent,
        ),
        child: RotatedBox(
          quarterTurns: isTurn ? provider.turnCamera : 0,
          child: ClipRRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ));
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
          provider.handlerBack();
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
