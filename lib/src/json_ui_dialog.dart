import 'package:flutter/material.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';

class JsonUIDialog extends StatelessWidget {
  final JsonFlutterUI parsedJsonUI;
  final Size size;
  const JsonUIDialog({Key? key, required this.parsedJsonUI, required this.size})
      : super(key: key);

  void dismiss() {
    locator<JsonMethodChannel>().dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      child: Scaffold(
        backgroundColor: parsedJsonUI.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: parsedJsonUI.backgroundColor,
          elevation: 0,
          actions: [
            if (parsedJsonUI.shouldShowDismiss)
              FloatingActionButton(
                  mini: true,
                  backgroundColor: parsedJsonUI.dismissButtonColor,
                  child: Icon(
                    Icons.close,
                    color: parsedJsonUI.dismissIconColor,
                  ),
                  onPressed: () {
                    dismiss();
                  }),
          ],
        ),
        body: Container(child: parsedJsonUI.widget),
      ),
    );
  }
}
