import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class OfferBannerBlock extends StatelessWidget {
  const OfferBannerBlock({
    super.key,
    required this.block,
    required this.primaryColor,
  });

  final BuilderBlock block;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final background = block.style['backgroundColor'] as String?;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _parseColor(background) ?? primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        block.title ?? 'Limited Offer',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color? _parseColor(String? value) {
    if (value == null || !value.startsWith('#')) {
      return null;
    }

    final hex = value.replaceFirst('#', '');
    if (hex.length == 6) {
      return Color(int.parse('FF$hex', radix: 16));
    }
    return null;
  }
}
