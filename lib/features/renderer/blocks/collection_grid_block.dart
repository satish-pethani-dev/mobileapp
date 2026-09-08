import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/catalog/catalog_utils.dart';
import '../../../core/models/mobile_models.dart';

class CollectionGridBlock extends StatelessWidget {
  const CollectionGridBlock({
    super.key,
    required this.block,
    required this.primaryColor,
    required this.catalog,
  });

  final BuilderBlock block;
  final Color primaryColor;
  final CatalogModel catalog;

  @override
  Widget build(BuildContext context) {
    final columns = block.style['columns'] as int? ?? 2;
    final showTitle = block.style['showTitle'] != false;
    final collections = collectionsForBlock(block, catalog);
    final limit = block.limit ?? 6;
    final itemCount = collections.isNotEmpty ? collections.length : limit;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            block.title ?? 'Collections',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (collections.isEmpty) {
                return Card(
                  color: primaryColor.withValues(alpha: 0.08),
                  child: Center(
                    child: Text('Collection ${index + 1}'),
                  ),
                );
              }

              final collection = collections[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (collection.imageUrl != null)
                      CachedNetworkImage(
                        imageUrl: collection.imageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => ColoredBox(
                          color: primaryColor.withValues(alpha: 0.08),
                        ),
                        errorWidget: (_, __, ___) => ColoredBox(
                          color: primaryColor.withValues(alpha: 0.08),
                          child: const Icon(Icons.image_not_supported_outlined),
                        ),
                      )
                    else
                      ColoredBox(
                        color: primaryColor.withValues(alpha: 0.08),
                        child: const Center(child: Icon(Icons.grid_view_outlined)),
                      ),
                    if (showTitle)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.7),
                              ],
                            ),
                          ),
                          child: Text(
                            collection.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
