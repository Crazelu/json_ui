import 'package:flutter/material.dart';

class JsonSpacer {
  final int flex;

  JsonSpacer({this.flex: 1});

  factory JsonSpacer.fromJson(Map<String, dynamic> json) {
    return JsonSpacer(flex: json['flex'] ?? 1);
  }

  Widget toWidget() => Spacer(flex: flex);
}
