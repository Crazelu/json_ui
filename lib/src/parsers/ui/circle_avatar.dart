import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonCircleAvatar {
  final Widget? child;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? imageUrl;

  JsonCircleAvatar(
      {this.child,
      this.radius: 10,
      this.imageUrl,
      this.backgroundColor: kPrimaryColorLight,
      this.foregroundColor: kPrimaryColorLight});

  factory JsonCircleAvatar.fromJson(Map<String, dynamic> json) {
    return JsonCircleAvatar(
        radius: json['radius'] ?? 10,
        imageUrl: json['imageUrl'],
        backgroundColor: Color(int.tryParse(json['backgroundColor'] ?? '') ??
            kPrimaryColorLight.value),
        foregroundColor: Color(int.tryParse(json['foregroundColor'] ?? '') ??
            kPrimaryColorLight.value),
        child: json['child'] == null
            ? null
            : JsonUIUtils.getWidgetFromJson(json['child']));
  }

  Widget toWidget() => CircleAvatar(
        child: child,
        radius: radius,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        foregroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      );
}
