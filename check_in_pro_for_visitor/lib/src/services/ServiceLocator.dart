import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Router.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/services/NavigationService.dart';
import 'package:check_in_pro_for_visitor/src/services/SignalRService.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:get_it/get_it.dart';
import 'package:check_in_pro_for_visitor/src/services/SyncService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Router());
  locator.registerLazySingleton(() => SignalRService());
  locator.registerLazySingleton(() => AppDestination());
  locator.registerLazySingleton(() => SyncService());
  locator.registerLazySingleton(() => Utilities());
  locator.registerLazySingleton(() => SizeConfig());
}
