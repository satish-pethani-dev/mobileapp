import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class RichTextBlock extends StatelessWidget {
  const RichTextBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final align = block.style['align'] as String? ?? 'left';
    final alignment = switch (align) {
      'center' => TextAlign.center,
      _ => TextAlign.left,
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (block.title != null && block.title!.isNotEmpty)
            Text(
              block.title!,
              textAlign: alignment,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          if (block.title != null && block.title!.isNotEmpty)
            const SizedBox(height: 8),
          Text(
            (block.style['content'] as String?) ?? '',
            textAlign: alignment,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
