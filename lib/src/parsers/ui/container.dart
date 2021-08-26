import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonContainer {
  final Widget child;
  final Color? color;
  final double radius;
  final Alignment alignment;
  final double? height;
  final double? width;

  JsonContainer({
    required this.child,
    this.alignment: Alignment.center,
    this.color,
    this.height,
    this.width,
    this.radius = 0,
  });

  factory JsonContainer.fromJson(Map<String, dynamic> json) {
    return JsonContainer(
      color: json['color'] == null
          ? null
          : Color(
              int.tryParse(json['color'] ?? '') ?? kPrimaryColorLight.value,
            ),
      radius: (json['radius'] ?? 0).toDouble(),
      height: json['height'] == null ? null : (json['height']).toDouble(),
      width: json['width'] == null ? null : (json['width']).toDouble(),
      alignment: _getAlignment(json['alignment']),
      child: JsonUIUtils.getWidgetFromJson(
        json['child'],
      ),
    );
  }

  static Alignment _getAlignment(String? alignment) {
    switch (alignment) {
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'centerRight':
        return Alignment.centerRight;
      case 'topCenter':
        return Alignment.topCenter;
      case 'topLeft':
        return Alignment.topLeft;
      case 'topRight':
        return Alignment.topRight;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'bottomLeft':
        return Alignment.bottomLeft;
      case 'bottomRight':
        return Alignment.bottomRight;
      default:
        return Alignment.center;
    }
  }

  Widget toWidget() => Container(
        constraints: BoxConstraints(minWidth: width ?? 0),
        width: width,
        height: height,
        child: child,
        alignment: alignment,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      );
}
