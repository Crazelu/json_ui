import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/method_channel.dart';
import 'package:json_ui/src/utils/navigaton_service.dart';

GetIt locator = GetIt.instance;

void setupLocator({GlobalKey<NavigatorState>? navigationKey}) {
  locator.registerLazySingleton(() => JsonMethodChannel());
  locator.registerSingleton(() => HttpService());
  if (navigationKey != null) {
    locator.registerSingleton(() => NavigationService(key: navigationKey));
  }
}
