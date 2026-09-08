import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class TestimonialsBlock extends StatelessWidget {
  const TestimonialsBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.title != null && block.title!.isNotEmpty)
            Text(
              block.title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('"Great product and fast shipping!"'),
                  SizedBox(height: 8),
                  Text(
                    '— Happy customer',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
