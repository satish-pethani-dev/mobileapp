import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/catalog/catalog_utils.dart';
import '../../../core/models/mobile_models.dart';

class ProductCarouselBlock extends StatelessWidget {
  const ProductCarouselBlock({
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
    final showPrice = block.style['showPrice'] != false;
    final products = productsForBlock(block, catalog);
    final limit = block.limit ?? 10;
    final itemCount = products.isNotEmpty ? products.length.clamp(0, limit) : limit.clamp(1, 10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Text(
            block.title ?? 'Products',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (products.isEmpty) {
                return Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            color: primaryColor.withValues(alpha: 0.1),
                            child: const Center(
                              child: Icon(Icons.image_outlined),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('Product ${index + 1}'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final product = products[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: product.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: product.imageUrl!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => ColoredBox(
                                  color: primaryColor.withValues(alpha: 0.1),
                                ),
                                errorWidget: (_, __, ___) => ColoredBox(
                                  color: primaryColor.withValues(alpha: 0.1),
                                  child: const Center(child: Icon(Icons.image_outlined)),
                                ),
                              )
                            : ColoredBox(
                                color: primaryColor.withValues(alpha: 0.1),
                                child: const Center(child: Icon(Icons.image_outlined)),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                            if (showPrice) ...[
                              const SizedBox(height: 4),
                              Text(
                                formatProductPrice(product),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
