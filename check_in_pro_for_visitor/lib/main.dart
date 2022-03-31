import 'dart:io';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/database/Shared.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashNotifier.dart';
import 'package:check_in_pro_for_visitor/src/screens/splashScreen/SplashScreen.dart';
import 'package:check_in_pro_for_visitor/src/services/ConnectionStatusSingleton.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/ServiceLocator.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';
import 'package:check_in_pro_for_visitor/src/constants/Router.dart';
import 'src/themes/AppThemes.dart';
import 'dart:async';

//Main for example provider
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  var isOnlineMode = true;
  SharedPreferences preferences;
  var isConnection = true;
  var isPause = false;

  void updateMode() {
    isOnlineMode = isConnection;
  }

  static MyApp of(BuildContext context) {
    return context.findAncestorWidgetOfExactType();
  }

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Utilities().printLog("build app......................................");
    ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) {
      if (!result) {
        widget.isConnection = false;
      } else {
        if (!widget.isConnection) {
//          locator<SyncService>().syncAllLog(context);
          widget.isConnection = true;
//          Utilities().countDownToResetApp(Constants.TIMEOUT_RESET, context);
        }
      }
    });
    return FutureBuilder<String>(
        future: getLanguage(context),
        builder: (widget, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            SpecificLocalizationDelegate _localeOverrideDelegate = SpecificLocalizationDelegate(Locale(snapshot.data));
            return MaterialApp(
              title: 'Flutter Demoo',
              theme: appThemeData[AppTheme.BlueLight],
              debugShowCheckedModeBanner: false,
              navigatorKey: locator<NavigationService>().navigatorKey,
              home: ChangeNotifierProvider(create: (_) => SplashNotifier(), child: SplashScreen()),
              onGenerateRoute: locator<Router>().createRouteList(),
              supportedLocales: [Locale(Constants.EN_CODE), Locale(Constants.VN_CODE)],
              localizationsDelegates: [
                _localeOverrideDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
            );
          }
          return Material();
        });
  }

  Future<String> getLanguage(BuildContext context) async {
    var isConnection = await Utilities().isConnectInternet(isChangeState: false);
    widget.isOnlineMode = isConnection;
    widget.isConnection = isConnection;
    var completer = Completer<String>();
    widget.preferences = await SharedPreferences.getInstance();
    var lang = widget.preferences.getString(Constants.KEY_LANGUAGE) ?? Constants.EN_CODE;
    if (lang.isEmpty || !Constants.LIST_LANG.contains(lang)) {
      lang = Constants.EN_CODE;
    }
    completer.complete(lang);
    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void onDeactivate() {
    super.deactivate();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        {
//          var isConnect = widget.isConnection;
//          var prefer = await SharedPreferences.getInstance();
//          var isLogin = prefer.getBool(Constants.KEY_IS_LOGGED) ?? false;
//          if (isLogin && widget.isPause) {
//            var dateTime = DateTime.now();
//            var timeStamp = dateTime.millisecondsSinceEpoch;
//            var lastTime = prefer.getInt(Constants.KEY_LAST_TIME) ?? timeStamp;
//            var timeBackground = ((timeStamp - lastTime) / 3600000).round() + 1;
//            if (timeBackground < Constants.TIMEOUT_RESET) {
//              Utilities().countDownToResetApp(timeBackground, context);
//            } else if (Platform.isIOS && isConnect) {
//              Utilities().countDownToResetApp(Constants.TIMEOUT_RESET, context);
//            }
//          }
          widget.isPause = false;
          break;
        }
      case AppLifecycleState.inactive:
        {
          break;
        }
      case AppLifecycleState.paused:
        {
          widget.isPause = true;
          var prefer = await SharedPreferences.getInstance();
          prefer.setInt(Constants.KEY_LAST_TIME, DateTime.now().millisecondsSinceEpoch);
          Utilities().timeoutToResetApp?.cancel();
          break;
        }
      case AppLifecycleState.detached:
        {
          break;
        }
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setupLogging();
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setEnabledSystemUIOverlays([]);
  Wakelock.enable();
  ConnectionStatusSingleton.getInstance().initialize();
  runApp(MultiProvider(
    providers: [
      Provider(
          create: (BuildContext context) => constructDb(), dispose: (BuildContext context, Database db) => db.close()),
    ],
    child: MyApp(),
  ));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    Utilities().printLog('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
