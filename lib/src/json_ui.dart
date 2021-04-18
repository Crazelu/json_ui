import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:json_ui/src/manager.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';
import 'package:json_ui/src/utils/http_service.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';
import 'package:json_ui/src/utils/navigaton_service.dart';

class JsonUI {
  static void init({
    required String url,
    RequestType requestType = RequestType.get,
    GlobalKey<NavigatorState>? navigationKey,
    BuildContext? context,
    Duration delay: const Duration(
        milliseconds:
            0), //delay time after json data is retrieved before dialog is shown
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    assert(navigationKey != null || context != null,
        "context or navigationKey required for navigation");

    setupLocator(navigationKey: navigationKey);

    final json = await locator<HttpService>()
        .sendNetworkRequest(url, requestType, body: body, headers: headers);

    if (json != null && json is Map) {
      JsonFlutterUI parsedJsonUI = JsonFlutterUI.fromJson(json);

      Future.delayed(delay).then((value) {
        if (navigationKey != null) {
          locator<JsonMethodChannel>().registerDismissListener(() {
            locator<NavigationService>().pop();
          });
          locator<NavigationService>().push(parsedJsonUI);
        } else {
          locator<JsonMethodChannel>().registerDismissListener(() {
            Navigator.of(context!).pop();
          });
          Navigator.of(context!).push(CupertinoPageRoute(
              builder: (context) =>
                  JsonUIDialogManager(parsedJsonUI: parsedJsonUI)));
        }
      });
    }
  }
}
