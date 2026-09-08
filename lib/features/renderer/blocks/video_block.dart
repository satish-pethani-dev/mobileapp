import 'package:flutter/material.dart';

import '../../../core/models/mobile_models.dart';

class VideoBlock extends StatelessWidget {
  const VideoBlock({super.key, required this.block});

  final BuilderBlock block;

  @override
  Widget build(BuildContext context) {
    final videoUrl = block.style['videoUrl'] as String?;
    final showControls = block.style['showControls'] != false;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: videoUrl != null && videoUrl.isNotEmpty
            ? Container(
                color: Colors.black,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ColoredBox(
                        color: Colors.black87,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 56,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                block.title ?? 'Video',
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (showControls)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6),
                            child: Icon(Icons.videocam, color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            : Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.play_circle_fill, color: Colors.white, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      block.title ?? 'Video',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
