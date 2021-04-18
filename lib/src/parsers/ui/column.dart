import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonColumn {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double verticalPadding;

  JsonColumn(
      {required this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment,
      this.verticalPadding: 0});

  factory JsonColumn.fromJson(Map<String, dynamic> json) {
    return JsonColumn(
        children: JsonUIUtils.getWidgets(json['children']),
        mainAxisAlignment: _getAlignment(true, json['mainAxisAlignment']),
        crossAxisAlignment: _getAlignment(false, json['crossAxisAlignment']),
        verticalPadding: json['verticalPadding'] ?? 0);
  }

  static _getAlignment(bool isMainAxisAlignment, String? alignment) {
    switch (alignment) {
      case 'start':
        if (isMainAxisAlignment) return MainAxisAlignment.start;
        return CrossAxisAlignment.start;
      case 'center':
        if (isMainAxisAlignment) return MainAxisAlignment.center;
        return CrossAxisAlignment.center;
      case 'end':
        if (isMainAxisAlignment) return MainAxisAlignment.end;
        return CrossAxisAlignment.end;
      case 'spaceEvenly':
        if (isMainAxisAlignment) return MainAxisAlignment.spaceEvenly;
        return CrossAxisAlignment.center;
      case 'baseline':
        if (!isMainAxisAlignment) return CrossAxisAlignment.baseline;
        return MainAxisAlignment.start;
      case 'stretch':
        if (!isMainAxisAlignment) return CrossAxisAlignment.stretch;
        return MainAxisAlignment.start;
      case 'spaceAround':
        if (isMainAxisAlignment) return MainAxisAlignment.spaceAround;
        return CrossAxisAlignment.center;
      case 'spaceBetween':
        if (isMainAxisAlignment) return MainAxisAlignment.spaceBetween;
        return CrossAxisAlignment.center;

      default:
    }
  }

  Widget toWidget() {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: children,
    );
  }
}
