import 'package:flutter/widgets.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/manager.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';
import 'package:json_ui/src/utils/navigaton_service.dart';

class JsonUI {
  static void init({
    Map<String, dynamic>?
        jsonData, //JSON to be parsed into UI if you don't want JsonUI to load your JSON data from a web service
    String? url,
    RequestType requestType =
        RequestType.get, //type of network request to be made
    GlobalKey<NavigatorState>? navigationKey,
    BuildContext? context,
    Duration delay =
        const Duration(), //delay time after json data is retrieved before dialog is shown
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    assert(jsonData != null || url != null, "jsonData or url required");
    assert(navigationKey != null || context != null,
        "context or navigationKey required for navigation");

    setupLocator(navigationKey: navigationKey);

    var json;
    final methodChannel = locator<JsonMethodChannel>();
    final navigationService = locator<NavigationService>();

    if (url != null) {
      json = await methodChannel.invokeMethod(kMakeRequest,
          params: ApiRequest(
              url: url, type: requestType, body: body, headers: headers));
    } else {
      json = jsonData;
    }

    if (json != null && json is Map<String, dynamic>) {
      JsonFlutterUI parsedJsonUI = JsonFlutterUI.fromJson(json);

      Future.delayed(delay).then((value) {
        if (navigationKey != null) {
          methodChannel.registerDismissListener(() {
            navigationService.pop();
          });
          navigationService.push(parsedJsonUI);
        } else {
          methodChannel.registerDismissListener(() {
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
