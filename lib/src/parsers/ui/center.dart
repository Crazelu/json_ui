import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonCenter {
  final Widget child;

  JsonCenter({required this.child});

  factory JsonCenter.fromJson(Map<String, dynamic> json) {
    return JsonCenter(
      child: JsonUIUtils.getWidgetFromJson(
        json['child'],
      ),
    );
  }

  Widget toWidget() => Center(child: child);
}
