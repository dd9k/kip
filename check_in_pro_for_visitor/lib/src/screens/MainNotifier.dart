import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

abstract class MainNotifier extends ChangeNotifier {
  AppLocalizations appLocalizations;
  NavigationService navigationService;
  Utilities utilities;
  Map<String, dynamic> arguments;
  Database db;
  MyApp parent;
  SharedPreferences preferences;
  BuildContext context;
}
