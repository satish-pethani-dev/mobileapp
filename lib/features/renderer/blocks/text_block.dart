import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class TextBlockWidget extends StatelessWidget {
  const TextBlockWidget({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final align = block.style['align'] as String? ?? 'left';
    final alignment = switch (align) {
      'center' => TextAlign.center,
      'right' => TextAlign.right,
      _ => TextAlign.left,
    };

    if (block.style['variant'] == 'button') {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: FilledButton(
            onPressed: () {},
            child: Text(block.title ?? 'Shop now'),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        block.title ?? '',
        textAlign: alignment,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
