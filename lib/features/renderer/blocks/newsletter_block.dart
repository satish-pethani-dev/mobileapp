import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class NewsletterBlock extends StatelessWidget {
  const NewsletterBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final background = block.style['backgroundColor'] as String?;
    final buttonText = block.style['buttonText'] as String? ?? 'Subscribe';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _parseColor(background) ?? Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            block.title ?? 'Join our newsletter',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 280;

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: block.placeholder ?? 'Enter your email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () {},
                      child: Text(buttonText),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: block.placeholder ?? 'Enter your email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {},
                    child: Text(buttonText),
                  ),
                ],
              );
            },
          ),
        ],
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
