import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';

class JsonUIDialog extends StatelessWidget {
  final JsonFlutterUI parsedJsonUI;
  final Size size;
  const JsonUIDialog({Key? key, required this.parsedJsonUI, required this.size})
      : super(key: key);

  void dismiss() {
    locator<JsonMethodChannel>().invokeMethod(kDismissPage);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: parsedJsonUI.backgroundColor,
        constraints: BoxConstraints.tight(size),
        child: Column(
          children: [
            if (parsedJsonUI.shouldShowDismiss) ...{
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: parsedJsonUI.dismissButtonColor,
                    child: Icon(
                      Icons.close,
                      color: parsedJsonUI.dismissIconColor,
                    ),
                    onPressed: () {
                      dismiss();
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            },
            Expanded(
              child: parsedJsonUI.widget,
            )
          ],
        ),
      ),
    );
  }
}
