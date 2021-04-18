import 'package:flutter/material.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonRow {
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  JsonRow(
      {required this.children,
      this.mainAxisAlignment,
      this.crossAxisAlignment});

  factory JsonRow.fromJson(Map<String, dynamic> json) {
    return JsonRow(
      mainAxisAlignment: _getAlignment(true, json['mainAxisAlignment']),
      crossAxisAlignment: _getAlignment(false, json['crossAxisAlignment']),
      children: JsonUIUtils.getWidgets(json['children']),
    );
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
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: children,
    );
  }
}
