import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonWrap {
  final List<Widget> children;
  final double horizontalSpacing;
  final double verticalSpacing; //space between runs on different lines

  JsonWrap({
    required this.children,
    this.verticalSpacing = 0,
    this.horizontalSpacing = 10,
  });

  factory JsonWrap.fromJson(Map<String, dynamic> json) {
    return JsonWrap(
      children: JsonUIUtils.getWidgets(json['children']),
      verticalSpacing: (json['verticalSpacing'] ?? 0).toDouble(),
      horizontalSpacing: (json["horizontalSpacing"] ?? 0).toDouble(),
    );
  }

  Widget toWidget() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: horizontalSpacing,
      runSpacing: verticalSpacing,
      children: children,
    );
  }
}
