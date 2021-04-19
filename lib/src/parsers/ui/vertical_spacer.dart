import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

///Adds vertical space between two widgets
class JsonVerticalSpacer {
  final double height;
  final Widget? child;

  JsonVerticalSpacer({required this.height, this.child});

  factory JsonVerticalSpacer.fromJson(Map<String, dynamic> json) {
    return JsonVerticalSpacer(
        height: json['height'].toDouble(),
        child: JsonUIUtils.getWidgetFromJson(json['child']));
  }

  Widget toWidget() {
    return SizedBox(height: height, child: child);
  }
}
