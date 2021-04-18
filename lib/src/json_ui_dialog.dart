import 'package:flutter/material.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';

class JsonUIDialog extends StatelessWidget {
  final JsonFlutterUI parsedJsonUI;
  final Size size;
  const JsonUIDialog({Key? key, required this.parsedJsonUI, required this.size})
      : super(key: key);

  void dismiss(BuildContext context) {
    Navigator.of(context).pop();
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
                    dismiss(context);
                  }),
          ],
        ),
        body: Container(child: parsedJsonUI.widget),
      ),
    );
  }
}
