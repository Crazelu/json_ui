import 'package:flutter/material.dart';
import 'package:json_ui/src/parsers/ui/button.dart';
import 'package:json_ui/src/parsers/ui/center.dart';
import 'package:json_ui/src/parsers/ui/circle_avatar.dart';
import 'package:json_ui/src/parsers/ui/column.dart';
import 'package:json_ui/src/parsers/ui/container.dart';
import 'package:json_ui/src/parsers/ui/expanded.dart';
import 'package:json_ui/src/parsers/ui/image.dart';
import 'package:json_ui/src/parsers/ui/inkwell.dart';
import 'package:json_ui/src/parsers/ui/listview.dart';
import 'package:json_ui/src/parsers/ui/padding.dart';
import 'package:json_ui/src/parsers/ui/row.dart';
import 'package:json_ui/src/parsers/ui/wrap.dart';
import 'package:json_ui/src/parsers/ui/spacer.dart';
import 'package:json_ui/src/parsers/ui/text.dart';
import 'package:json_ui/src/parsers/ui/vertical_spacer.dart';

class JsonUIUtils {
  static List<Widget> getWidgets(List json) {
    List<Widget> widgets = <Widget>[];

    for (var widget in json) {
      widgets.add(getWidgetFromJson(widget));
    }

    return widgets;
  }

  static Widget getWidgetFromJson(Map<String, dynamic>? json) {
    if (json == null) return Container();
    switch (json['type']) {
      case 'image':
        return JsonImage.fromJson(json).toWidget();
      case 'button':
        return JsonButton.fromJson(json).toWidget();
      case 'text':
        return JsonText.fromJson(json).toWidget();
      case 'row':
        return JsonRow.fromJson(json).toWidget();
      case 'wrap':
        return JsonWrap.fromJson(json).toWidget();
      case 'listview':
        return JsonListView.fromJson(json).toWidget();
      case 'column':
        return JsonColumn.fromJson(json).toWidget();
      case 'expanded':
        return JsonExpanded.fromJson(json).toWidget();
      case 'verticalSpacer':
        return JsonVerticalSpacer.fromJson(json).toWidget();
      case 'spacer':
        return JsonSpacer.fromJson(json).toWidget();
      case 'center':
        return JsonCenter.fromJson(json).toWidget();
      case 'padding':
        return JsonPadding.fromJson(json).toWidget();
      case 'inkwell':
        return JsonInkWell.fromJson(json).toWidget();
      case 'circleAvatar':
        return JsonCircleAvatar.fromJson(json).toWidget();
      case 'container':
        return JsonContainer.fromJson(json).toWidget();

      default:
        return Container();
    }
  }
}
