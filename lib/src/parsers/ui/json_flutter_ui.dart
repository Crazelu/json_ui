import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';

class JsonFlutterUI {
  final Color backgroundColor;
  final Color dismissButtonColor;
  final Color dismissIconColor;
  final bool shouldShowDismiss;
  final bool isFullScreen;
  final Size? dialogSize;
  final Widget widget;

  JsonFlutterUI(
      {this.backgroundColor: kPrimaryColorDark,
      this.dismissIconColor: kPrimaryColorLight,
      this.dismissButtonColor: kButtonSplashColor,
      this.dialogSize,
      this.shouldShowDismiss: true,
      required this.isFullScreen,
      this.widget: const SizedBox()});

  factory JsonFlutterUI.fromJson(Map<String, dynamic> json) {
    return JsonFlutterUI(
        backgroundColor: Color(int.tryParse(json['backgroundColor'] ?? '') ??
            kPrimaryColorLight.value),
        dismissButtonColor: Color(
            int.tryParse(json['dismissButtonColor'] ?? '') ??
                kButtonSplashColor.value),
        dismissIconColor: Color(int.tryParse(json['dismissIconColor'] ?? '') ??
            kPrimaryColorLight.value),
        shouldShowDismiss: json['shouldShowDismiss'] ?? true,
        isFullScreen: json['isFullScreen'] ?? true,
        dialogSize: _getSize(json['size']),
        widget: JsonUIUtils.getWidgetFromJson(json));
  }

  static Size? _getSize(Map<String, dynamic>? json) {
    try {
      if (json == null) return null;
      return Size(json['width'].toDouble(), json['height'].toDouble());
    } catch (e) {
      print(e);
    }
  }
}
