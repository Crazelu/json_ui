import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';
import 'package:json_ui/src/parsers/api/request.dart';
import 'package:json_ui/src/utils/json_ui_utils.dart';
import 'package:json_ui/src/utils/locator.dart';
import 'package:json_ui/src/utils/method_channel.dart';

class JsonButton {
  final Color backgroundColor;
  final Color textColor;
  final Color splashColor;
  final String text;
  final Widget? child;
  final double verticalPadding;
  final double fontSize;
  final OutlinedBorder? shape;
  final ApiRequest? requestParams;
  final String?
      methodName; //name of method to be invoked in `JsonMethodChannel`

  JsonButton(
      {this.backgroundColor: kButtonBackgroundColor,
      this.textColor: kPrimaryColorLight,
      this.splashColor: kButtonSplashColor,
      this.text: '',
      this.verticalPadding: 0,
      this.fontSize: kDefaultFontSize,
      this.shape,
      this.child,
      this.requestParams,
      this.methodName});

  factory JsonButton.fromJson(Map<String, dynamic> json) {
    return JsonButton(
        backgroundColor: Color(
            int.tryParse(json['backgroundColor'].toString()) ??
                kButtonBackgroundColor.value),
        textColor: Color(int.tryParse(json['textColor'].toString()) ??
            kPrimaryColorLight.value),
        splashColor: Color(int.tryParse(json['splashColor'].toString()) ??
            kButtonSplashColor.value),
        text: json['text'],
        child: json['child'] == null
            ? null
            : JsonUIUtils.getWidgetFromJson(json['child']),
        verticalPadding: (json["verticalPadding"] ?? 0).toDouble(),
        fontSize: (json["fontSize"] ?? kDefaultFontSize).toDouble(),
        methodName: json['methodName'],
        shape: _getShape(json['shape']),
        requestParams: ApiRequest.fromJson(json['apiRequestParams']));
  }

  static OutlinedBorder? _getShape(Map<String?, dynamic>? json) {
    switch (json!['shape']) {
      case 'stadium':
        return StadiumBorder();
      case 'circular':
        return CircleBorder();
      case 'rectangular':
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(json['radius']));
      default:
    }
  }

  Widget toWidget() {
    return TextButton(
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(100, 50)),
            textStyle: MaterialStateProperty.resolveWith(
                (states) => TextStyle(fontSize: fontSize)),
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => backgroundColor),
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => textColor),
            overlayColor:
                MaterialStateProperty.resolveWith((states) => splashColor),
            shape: MaterialStateProperty.resolveWith((states) => shape)),
        onPressed: () {
          locator<JsonMethodChannel>()
              .invokeMethod(methodName, params: requestParams);
        },
        child: child ?? Text(text));
  }
}
