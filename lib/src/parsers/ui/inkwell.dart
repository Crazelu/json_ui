import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';

class JsonInkWell {
  final Widget child;
  final Color splashColor;
  final ApiRequest? requestParams;
  final String?
      methodName; //name of method to be invoked in `JsonMethodChannel`

  JsonInkWell(
      {required this.child,
      this.splashColor: kButtonSplashColor,
      this.requestParams,
      this.methodName});

  factory JsonInkWell.fromJson(Map<String, dynamic> json) {
    return JsonInkWell(
      child: JsonUIUtils.getWidgetFromJson(json['child']),
      splashColor: Color(
          int.tryParse(json['splashColor'] ?? '') ?? kButtonSplashColor.value),
      requestParams: ApiRequest.fromJson(json['requestParams']),
      methodName: json['methodName'],
    );
  }

  Widget toWidget() => InkWell(
      splashColor: splashColor,
      onTap: () {
        locator<JsonMethodChannel>()
            .invokeMethod(methodName, params: requestParams);
      },
      child: child);
}
