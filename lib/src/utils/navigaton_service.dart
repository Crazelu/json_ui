import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_ui/src/manager.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';

class NavigationService {
  late GlobalKey<NavigatorState> key;

  NavigationService({GlobalKey<NavigatorState>? key}) {
    this.key = key ?? GlobalKey<NavigatorState>();
  }

  Object? push(JsonFlutterUI parsedJsonUI) async {
    return await key.currentState?.push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, primary, secondary) => JsonUIDialogManager(
          parsedJsonUI: parsedJsonUI,
        ),
      ),
    );
  }

  void pop() {
    key.currentState?.pop();
  }
}
