import '../models/mobile_models.dart';

List<ShopifyProductModel> productsForBlock(BuilderBlock block, CatalogModel catalog) {
  if ((block.type == 'collection_products' || block.type == 'product_carousel') &&
      block.collectionId != null &&
      block.collectionId!.isNotEmpty) {
    return catalog.productsByCollection[block.collectionId] ?? const [];
  }

  if (block.type == 'product_grid' &&
      block.collectionId != null &&
      block.collectionId!.isNotEmpty) {
    return catalog.productsByCollection[block.collectionId] ?? const [];
  }

  if (block.type == 'product_grid' ||
      block.type == 'recently_viewed' ||
      block.type == 'product_carousel') {
    return catalog.products;
  }

  return const [];
}

List<ShopifyCollectionModel> collectionsForBlock(BuilderBlock block, CatalogModel catalog) {
  return catalog.collections.take(block.limit ?? 6).toList();
}

String formatProductPrice(ShopifyProductModel product) {
  final value = double.tryParse(product.price);
  if (value == null) {
    return product.price;
  }

  return '${product.currencyCode} ${value.toStringAsFixed(2)}';
}
