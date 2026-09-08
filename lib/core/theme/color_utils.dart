import 'package:flutter/material.dart';

Color parseHexColor(String value) {
  final hex = value.replaceFirst('#', '');
  if (hex.length == 6) {
    return Color(int.parse('FF$hex', radix: 16));
  }
  return const Color(0xFF008060);
}
