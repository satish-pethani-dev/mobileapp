import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class ImageBlock extends StatelessWidget {
  const ImageBlock({super.key, required this.block});

  final BuilderBlock block;

  double _aspectRatio() {
    final ratio = block.style['aspectRatio'] as String? ?? '16:9';
    final parts = ratio.split(':');
    if (parts.length != 2) {
      return 16 / 9;
    }

    final width = double.tryParse(parts[0]);
    final height = double.tryParse(parts[1]);
    if (width == null || height == null || height == 0) {
      return 16 / 9;
    }

    return width / height;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = block.style['imageUrl'] as String?;
    final borderRadius = (block.style['borderRadius'] as num?)?.toDouble() ?? 12;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: AspectRatio(
          aspectRatio: _aspectRatio(),
          child: imageUrl != null && imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, __) => ColoredBox(color: Colors.grey.shade300),
                  errorWidget: (_, __, ___) => ColoredBox(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Text(
                        block.title ?? 'Image',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                )
              : ColoredBox(
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Text(
                      block.title ?? 'Image',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
