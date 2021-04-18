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
    Map<String, dynamic>?
        jsonData, //JSON to be parsed into UI if you don't want JsonUI to load your JSON data from a web service,
    String? url,
    RequestType requestType = RequestType.get,
    GlobalKey<NavigatorState>? navigationKey,
    BuildContext? context,
    Duration delay: const Duration(
        milliseconds:
            0), //delay time after json data is retrieved before dialog is shown
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    assert(jsonData != null || url != null, "jsonData or url required");
    assert(navigationKey != null || context != null,
        "context or navigationKey required for navigation");

    setupLocator(navigationKey: navigationKey);

    var json;

    if (url != null) {
      json = await locator<HttpService>()
          .sendNetworkRequest(url, requestType, body: body, headers: headers);
    } else {
      json = jsonData;
    }

    if (json != null && json is Map<String, dynamic>) {
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
          Navigator.of(context!).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, primary, secondary) =>
                  JsonUIDialogManager(parsedJsonUI: parsedJsonUI)));
        }
      });
    }
  }
}
