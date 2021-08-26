import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/method_channel.dart';
import 'package:json_ui/src/utils/navigaton_service.dart';

GetIt locator = GetIt.instance;

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void setupLocator({GlobalKey<NavigatorState>? navigationKey}) {
  try {
    _removeRegistrationIfExists<JsonMethodChannel>();
    locator.registerLazySingleton(() => JsonMethodChannel());

    _removeRegistrationIfExists<HttpService>();
    locator.registerLazySingleton(() => HttpService());

    if (navigationKey != null) {
      _removeRegistrationIfExists<NavigationService>();
      locator.registerLazySingleton(
        () => NavigationService(
          key: navigationKey,
        ),
      );
    }
  } catch (e) {
    print(e);
  }
}
