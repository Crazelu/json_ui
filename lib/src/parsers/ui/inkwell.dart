import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';
import 'package:json_ui/src/utils/method_channel.dart';

class JsonInkWell {
  final Widget child;
  final Color splashColor;
  final ApiRequest? requestParams;

  JsonInkWell(
      {required this.child,
      this.splashColor: kButtonSplashColor,
      this.requestParams});

  factory JsonInkWell.fromJson(Map<String, dynamic> json) {
    return JsonInkWell(
        child: JsonUIUtils.getWidgetFromJson(json['child']),
        splashColor: Color(int.tryParse(json['splashColor'] ?? '') ??
            kButtonSplashColor.value),
        requestParams: ApiRequest.fromJson(json['requestParams']));
  }

  Widget toWidget() => InkWell(
      splashColor: splashColor,
      onTap: () {
        JsonMethodChannel().invokeMethod(kMakeRequest, params: requestParams);
      },
      child: child);
}
