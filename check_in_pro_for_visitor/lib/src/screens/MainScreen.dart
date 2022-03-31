import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import 'MainNotifier.dart';

abstract class MainScreen extends StatefulWidget {
  String getNameScreen();

  @override
  MainScreenState createState();
}

abstract class MainScreenState<T extends MainNotifier> extends State<MainScreen> {
  AppLocalizations appLocalizations;
  double heightScreen;
  double widthScreen;
  bool isPortrait;
  T provider;
  KeyboardVisibilityNotification keyboardVisibilityNotification;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initValue(context);
    if (keyboardVisibilityNotification == null) {
      keyboardVisibilityNotification = KeyboardVisibilityNotification()
        ..addNewListener(
          onChange: onKeyboardChange,
        );
      var route = ModalRoute.of(context);
      if (route.isCurrent && NavigationService.timeOutRoute.contains(route)) {
        Utilities().moveToWaiting();
      }
    }
  }

  void onKeyboardChange(bool visible) {}

  void initValue(BuildContext context) {
    locator<SizeConfig>().init(context);
    appLocalizations = AppLocalizations.of(context);
    heightScreen = SizeConfig.safeBlockVertical;
    widthScreen = SizeConfig.safeBlockHorizontal;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    provider = Provider.of<T>(context, listen: false);
    provider.appLocalizations = appLocalizations;
    provider.navigationService = locator<NavigationService>();
    provider.utilities = locator<Utilities>();
    provider.arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    provider.db = Provider.of<Database>(context, listen: false);
    provider.parent = MyApp.of(context);
    provider.preferences = provider.parent.preferences;
    provider.context = context;
  }

  @override
  Widget build(BuildContext context) {
    provider.utilities.printLog("build ${widget.getNameScreen()}......................................");
  }

  @override
  void dispose() {
    keyboardVisibilityNotification.dispose();
    super.dispose();
  }
}
