import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class BannerSliderBlock extends StatelessWidget {
  const BannerSliderBlock({
    super.key,
    required this.block,
    required this.primaryColor,
  });

  final BuilderBlock block;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.title != null && block.title!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                block.title!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withValues(alpha: 0.6)],
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Featured',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
