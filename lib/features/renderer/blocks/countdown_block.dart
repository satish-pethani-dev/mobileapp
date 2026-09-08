import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class CountdownBlock extends StatelessWidget {
  const CountdownBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final imageUrl = block.style['imageUrl'] as String?;
    final backgroundColor = block.style['backgroundColor'] as String? ?? '#f9fafb';
    final textColor = block.style['textColor'] as String? ?? '#111827';
    final showText = block.style['showText'] != false;
    final showButton = block.style['showButton'] != false;

    Color parseColor(String hex, Color fallback) {
      final normalized = hex.replaceAll('#', '');
      if (normalized.length != 6) {
        return fallback;
      }
      final value = int.tryParse('FF$normalized', radix: 16);
      return value == null ? fallback : Color(value);
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: EdgeInsets.only(
        top: (block.style['paddingTop'] as num?)?.toDouble() ?? 16,
        bottom: (block.style['paddingBottom'] as num?)?.toDouble() ?? 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: parseColor(backgroundColor, Colors.grey.shade100),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          if (imageUrl != null && imageUrl.isNotEmpty) const SizedBox(height: 12),
          if (showText)
            Text(
              block.title ?? 'Sale ends in',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: parseColor(textColor, Colors.black87),
                  ),
            ),
          if (showText) const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['02', '14', '35']
                .map(
                  (value) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (showButton) ...[
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {},
              child: Text(
                block.style['buttonText'] as String? ?? 'Shop now',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
