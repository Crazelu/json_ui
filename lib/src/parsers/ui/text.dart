import 'package:flutter/material.dart';
import 'package:json_ui/src/constants/constants.dart';

class JsonText {
  final String data;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softWrap;
  final int? maxLines;
  final JsonTextStyle? style;
  final double verticalPadding;
  final double? height;
  final double? width;

  JsonText({
    required this.data,
    this.overflow,
    this.textAlign,
    this.softWrap,
    this.maxLines,
    this.style,
    this.height,
    this.width,
    this.verticalPadding = 0,
  });

  factory JsonText.fromJson(Map<String, dynamic> json) {
    return JsonText(
      data: json['data'],
      softWrap: json['softWrap'],
      maxLines: json['maxLines'],
      height: json['height'] == null ? null : json['height'].toDouble(),
      width: json['width'] == null ? null : json['width'].toDouble(),
      style: JsonTextStyle.fromJson(json['style']),
      overflow: _getOverflow(json['overflow']),
      textAlign: _getAlignment(json['textAlignment']),
      verticalPadding: (json["verticalPadding"] ?? 0).toDouble(),
    );
  }

  Widget toWidget() {
    return Container(
      constraints: BoxConstraints(maxWidth: width ?? double.infinity),
      padding: EdgeInsets.only(bottom: verticalPadding),
      child: Text(
        data,
        overflow: overflow,
        softWrap: softWrap,
        textAlign: textAlign,
        maxLines: maxLines,
        style: style == null ? null : style!.toTextStyle(),
      ),
    );
  }

  static TextAlign? _getAlignment(String? alignment) {
    switch (alignment) {
      case 'center':
        return TextAlign.center;
      case 'end':
        return TextAlign.end;
      case 'justify':
        return TextAlign.justify;
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.start;
    }
  }

  static TextOverflow? _getOverflow(String? overflow) {
    switch (overflow) {
      case 'clip':
        return TextOverflow.clip;
      case 'fade':
        return TextOverflow.fade;
      case 'visible':
        return TextOverflow.visible;
      default:
        return TextOverflow.ellipsis;
    }
  }
}

class JsonTextStyle {
  final double fontSize;
  final String fontWeight;
  final Color textColor;

  JsonTextStyle({
    this.fontSize: kDefaultFontSize,
    this.fontWeight: '',
    this.textColor: kPrimaryColorDark,
  });

  factory JsonTextStyle.fromJson(Map<String, dynamic>? json) {
    if (json == null) return JsonTextStyle();
    if (json['color'] != null) {
      return JsonTextStyle(
        fontSize: (json['fontSize'] ?? kDefaultFontSize).toDouble(),
        fontWeight: json['fontWeight'] ?? '',
        textColor: Color(
          int.tryParse(json['color'] ?? '') ?? kPrimaryColorLight.value,
        ),
      );
    }
    return JsonTextStyle(
        fontSize: (json['fontSize'] ?? kDefaultFontSize).toDouble(),
        fontWeight: json['fontWeight'] ?? '');
  }

  TextStyle toTextStyle() {
    return TextStyle(
      fontWeight: _getWeight(fontWeight),
      fontSize: fontSize,
      color: textColor,
    );
  }

  FontWeight _getWeight(String? fontWeight) {
    switch (fontWeight) {
      case 'bold':
        return FontWeight.bold;
      case '100':
        return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }
}
