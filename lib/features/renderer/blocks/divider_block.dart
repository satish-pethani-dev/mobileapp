import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class DividerBlock extends StatelessWidget {
  const DividerBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final height = (block.style['height'] as num?)?.toDouble() ?? 1;
    final margin = (block.style['margin'] as num?)?.toDouble() ?? 16;
    final colorHex = block.style['color'] as String? ?? '#e5e7eb';

    return Padding(
      padding: EdgeInsets.symmetric(vertical: margin),
      child: Container(
        height: height,
        color: _parseColor(colorHex) ?? Colors.grey.shade300,
      ),
    );
  }

  Color? _parseColor(String value) {
    if (!value.startsWith('#')) {
      return null;
    }
    final hex = value.replaceFirst('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return null;
  }
}
