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
    return SafeArea(
        child: Material(
      child: Container(
          color: parsedJsonUI.backgroundColor,
          constraints: BoxConstraints.tight(size),
          // height: (size.height).h,
          // width: (size.width).w,
          child: Column(
            children: [
              if (parsedJsonUI.shouldShowDismiss)
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
                        }),
                  ],
                ),
              Expanded(
                child: parsedJsonUI.widget,
              )
            ],
          )),
    ));
  }
}


//  Scaffold(
//         backgroundColor: parsedJsonUI.backgroundColor,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: parsedJsonUI.backgroundColor,
//           elevation: 0,
//           actions: [
//             if (parsedJsonUI.shouldShowDismiss)
//               FloatingActionButton(
//                   mini: true,
//                   backgroundColor: parsedJsonUI.dismissButtonColor,
//                   child: Icon(
//                     Icons.close,
//                     color: parsedJsonUI.dismissIconColor,
//                   ),
//                   onPressed: () {
//                     dismiss();
//                   }),
//           ],
//         ),
//         body: Container(child: parsedJsonUI.widget),
//       ),