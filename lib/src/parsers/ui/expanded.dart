import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonExpanded {
  final Widget child;
  final int flex;

  JsonExpanded({
    required this.child,
    this.flex = kDefaultFlex,
  });

  factory JsonExpanded.fromJson(Map<String, dynamic> json) {
    return JsonExpanded(
      child: JsonUIUtils.getWidgetFromJson(json['child']),
      flex: json['flex'] ?? kDefaultFlex,
    );
  }

  Widget toWidget() {
    return Expanded(
      flex: flex,
      child: child,
    );
  }
}
