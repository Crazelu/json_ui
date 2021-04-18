import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/method_channel.dart';
import 'package:json_ui/src/utils/navigaton_service.dart';

GetIt locator = GetIt.instance;

void setupLocator({GlobalKey<NavigatorState>? navigationKey}) {
  try {
    if (!locator.isRegistered(instance: JsonMethodChannel)) {
      locator.registerLazySingleton(() => JsonMethodChannel());
    }

    if (!locator.isRegistered(instance: HttpService)) {
      locator.registerLazySingleton(() => HttpService());
    }

    if (navigationKey != null) {
      if (!locator.isRegistered(instance: NavigationService)) {
        locator
            .registerLazySingleton(() => NavigationService(key: navigationKey));
      }
    }
  } catch (e) {
    print(e);
  }
}
