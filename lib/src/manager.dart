import 'package:flutter/material.dart';
import 'package:json_ui/src/json_ui_dialog.dart';
import 'package:json_ui/src/parsers/ui/json_flutter_ui.dart';

class JsonUIDialogManager extends StatelessWidget {
  final JsonFlutterUI parsedJsonUI;

  const JsonUIDialogManager({Key? key, required this.parsedJsonUI})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return JsonUIDialog(
          parsedJsonUI: parsedJsonUI,
          size: parsedJsonUI.isFullScreen
              ? Size(constraints.maxWidth, constraints.maxHeight)
              : parsedJsonUI.dialogSize ?? const Size(400, 600));
    });
  }
}
