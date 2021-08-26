import 'package:flutter/material.dart';

class JsonImage {
  final Size size;
  final String imageUrl;
  final String overlayText;
  final double verticalPadding;
  final double borderRadius;
  final BoxFit fit;

  JsonImage(
    this.imageUrl,
    this.size, {
    this.overlayText = '',
    this.verticalPadding = 0,
    this.borderRadius = 0,
    this.fit = BoxFit.contain,
  });

  factory JsonImage.fromJson(Map<String, dynamic> json) {
    return JsonImage(
      json['imageUrl'],
      Size((json['size']['width']).toDouble(),
          (json['size']['height']).toDouble()),
      overlayText: json['displayText'] ?? '',
      verticalPadding: (json["verticalPadding"] ?? 0).toDouble(),
      borderRadius: (json["borderRadius"] ?? 0).toDouble(),
      fit: _getBoxFit(
        json['fit'],
      ),
    );
  }

  static BoxFit _getBoxFit(String? fit) {
    switch (fit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      default:
        return BoxFit.contain;
    }
  }

  Widget toWidget() {
    return Container(
      alignment: Alignment.bottomLeft,
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          fit: fit,
          image: NetworkImage(imageUrl),
        ),
      ),
      child: Text(overlayText),
    );
  }
}
