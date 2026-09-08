import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class InstagramFeedBlock extends StatelessWidget {
  const InstagramFeedBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final columns = (block.style['columns'] as num?)?.toInt() ?? 3;
    final limit = block.limit ?? 6;
    final crossAxisCount = columns.clamp(2, 3);

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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: limit.clamp(3, 12),
            itemBuilder: (_, __) => Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
