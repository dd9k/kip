import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/Thankyou/ThankYouScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/checkOut/CheckOutScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/companyBuilding/CompanyBuildScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/companyBuilding/CompanyBuildingNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/contactPerson/ContactScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/covidScreen/CovidScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/domainScreen/DomainScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/feedBack/FeedBackScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/givePermission/GivePermissionNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/givePermission/GivePermissionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/home/HomeScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/home/HomeScreenNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputDeviceName/InputDeviceNameNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputDeviceName/InputDeviceNameScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputInformation/InputInformationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/inputPhone/InputPhoneScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/kioskMode/KioskModeNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/kioskMode/KioskModeScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/location/LocationNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/location/LocationScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/login/LoginNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/login/LoginScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/reviewCheckIn/ReviewCheckInScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/saverScreen/SaverNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/saverScreen/SaverScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanQR/ScanQRScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/scanVS/ScanVisionScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/SettingNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/SettingScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/detailSetting/advanced/AdvancedNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/detailSetting/camera/CameraNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/detailSetting/location/LocationPageNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/settting/detailSetting/print/PrinterNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/survey/SurveyScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/takePhoto/TakePhotoScreen.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/waiting/WaitingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Router {
  Route _createRoute(Widget widget, RouteSettings settings, AnimationType type) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        if (type == AnimationType.FADE) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  createRouteList() => (RouteSettings settings) {
        switch (settings.name) {
          case SplashScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => SplashNotifier(), child: SplashScreen()),
                settings, AnimationType.FADE);

          case LoginScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(
                  create: (_) => LoginNotifier(),
                  child: LoginScreen(),
                ),
                settings,
                AnimationType.SLIDE);

          case InputDeviceNameScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => InputDeviceNameNotifier(), child: InputDeviceNameScreen()),
                settings,
                AnimationType.SLIDE);

          case ScanQRScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => ScanQRNotifier(), child: ScanQRScreen()),
                settings, AnimationType.FADE);

          case LocationScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => LocationNotifier(), child: LocationScreen()),
                settings, AnimationType.SLIDE);

          case TakePhotoScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => TakePhotoNotifier(), child: TakePhotoScreen()),
                settings, AnimationType.SLIDE);

          case TakePhotoScreen.route_name_temp:
            return _createRoute(ChangeNotifierProvider(create: (_) => TakePhotoNotifier(), child: TakePhotoScreen()),
                settings, AnimationType.SLIDE);

          case SettingScreen.route_name:
            return _createRoute(
                MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => SettingNotifier()),
                    ChangeNotifierProvider(create: (_) => LocationPageNotifier()),
                    ChangeNotifierProvider(create: (_) => PrintNotifier()),
                    ChangeNotifierProvider(create: (_) => CameraNotifier()),
                    ChangeNotifierProvider(create: (_) => AdvancedNotifier())
                  ],
                  child: SettingScreen(),
                ),
                settings,
                AnimationType.FADE);

          case WaitingScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => WaitingNotifier(), child: WaitingScreen()),
                settings, AnimationType.FADE);

          case HomeScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => HomeScreenNotifier(), child: HomeScreen()),
                settings, AnimationType.FADE);

          case InputInformationScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => InputInformationNotifier(), child: InputInformationScreen()),
                settings,
                AnimationType.SLIDE);

          case GivePermissionScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => GivePermissionNotifier(), child: GivePermissionScreen()),
                settings,
                AnimationType.SLIDE);

          case ThankYouScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => ThankYouNotifier(), child: ThankYouScreen()),
                settings, AnimationType.SLIDE);

          case CheckOutScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => CheckOutNotifier(), child: CheckOutScreen()),
                settings, AnimationType.SLIDE);

          case FeedBackScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => FeedBackNotifier(), child: FeedBackScreen()),
                settings, AnimationType.SLIDE);

          case InputPhoneScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => InputPhoneNotifier(), child: InputPhoneScreen()),
                settings, AnimationType.SLIDE);

          case ReviewCheckInScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => ReviewCheckInNotifier(), child: ReviewCheckInScreen()),
                settings,
                AnimationType.SLIDE);
          case ScanVisionScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => ScanVisionNotifier(), child: ScanVisionScreen()),
                settings, AnimationType.FADE);
          case CompanyBuildingScreen.route_name:
            return _createRoute(
                ChangeNotifierProvider(create: (_) => CompanyBuildingNotifier(), child: CompanyBuildingScreen()),
                settings,
                AnimationType.SLIDE);

          case CovidScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => CovidNotifier(), child: CovidScreen()), settings,
                AnimationType.SLIDE);

          case SurveyScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => SurveyNotifier(), child: SurveyScreen()),
                settings, AnimationType.SLIDE);

          case ContactScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => ContactNotifier(), child: ContactScreen()),
                settings, AnimationType.SLIDE);

          case DomainScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => DomainNotifier(), child: DomainScreen()),
                settings, AnimationType.FADE);

          case SaverScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => SaverNotifier(), child: SaverScreen()),
                settings, AnimationType.FADE);

          case KioskModeScreen.route_name:
            return _createRoute(ChangeNotifierProvider(create: (_) => KioskModeNotifier(), child: KioskModeScreen()),
                settings, AnimationType.SLIDE);
        }
        return null;
        //assert(false);
      };
}

enum AnimationType {
  SLIDE,
  FADE,
}
