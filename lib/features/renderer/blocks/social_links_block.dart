import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class SocialLinksBlock extends StatelessWidget {
  const SocialLinksBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final instagram = block.style['instagram'] as String?;
    final facebook = block.style['facebook'] as String?;
    final tiktok = block.style['tiktok'] as String?;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (block.title != null && block.title!.isNotEmpty)
            Text(
              block.title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (instagram != null && instagram.isNotEmpty)
                _SocialChip(label: 'IG'),
              if (facebook != null && facebook.isNotEmpty)
                _SocialChip(label: 'FB'),
              if (tiktok != null && tiktok.isNotEmpty)
                _SocialChip(label: 'TT'),
            ],
          ),
        ],
      ),
    );
  }
}

class _SocialChip extends StatelessWidget {
  const _SocialChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade200,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
