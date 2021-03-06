import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonPadding {
  final Widget child;
  final EdgeInsets padding;

  JsonPadding({
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  factory JsonPadding.fromJson(Map<String, dynamic> json) {
    return JsonPadding(
      padding: _getEdgeInsets(json['padding']),
      child: JsonUIUtils.getWidgetFromJson(
        json['child'],
      ),
    );
  }

  Widget toWidget() => Padding(
        padding: padding,
        child: child,
      );

  static EdgeInsets _getEdgeInsets(Map<String, dynamic> json) {
    return EdgeInsets.fromLTRB(
      (json['left'] ?? 0).toDouble(),
      (json['top'] ?? 0).toDouble(),
      (json['right'] ?? 0).toDouble(),
      (json['bottom'] ?? 0).toDouble(),
    );
  }
}
