import 'dart:convert';

class BuilderBlock {
  const BuilderBlock({
    required this.id,
    required this.type,
    this.title,
    this.collectionId,
    this.limit,
    this.placeholder,
    this.items,
    this.style = const {},
  });

  factory BuilderBlock.fromJson(Map<String, dynamic> json) {
    return BuilderBlock(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? 'text_block',
      title: json['title'] as String?,
      collectionId: json['collectionId'] as String?,
      limit: json['limit'] as int?,
      placeholder: json['placeholder'] as String?,
      items: json['items'] as List<dynamic>?,
      style: (json['style'] as Map<String, dynamic>?) ?? const {},
    );
  }

  final String id;
  final String type;
  final String? title;
  final String? collectionId;
  final int? limit;
  final String? placeholder;
  final List<dynamic>? items;
  final Map<String, dynamic> style;
}

class AppSettingsModel {
  const AppSettingsModel({
    required this.appName,
    required this.primaryColor,
    required this.secondaryColor,
    this.bottomNavStyle = 'style-1',
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic>? json) {
    return AppSettingsModel(
      appName: json?['appName'] as String? ?? 'Store App',
      primaryColor: json?['primaryColor'] as String? ?? '#008060',
      secondaryColor: json?['secondaryColor'] as String? ?? '#212B36',
      bottomNavStyle: json?['bottomNavStyle'] as String? ?? 'style-1',
    );
  }

  final String appName;
  final String primaryColor;
  final String secondaryColor;
  final String bottomNavStyle;
}

class NavigationItemModel {
  const NavigationItemModel({
    required this.title,
    required this.icon,
    required this.targetType,
    required this.targetValue,
    this.menuType = 'bottom',
  });

  factory NavigationItemModel.fromJson(Map<String, dynamic> json) {
    return NavigationItemModel(
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? 'home',
      targetType: json['targetType'] as String? ?? 'page',
      targetValue: json['targetValue'] as String? ?? 'home',
      menuType: json['menuType'] as String? ?? 'bottom',
    );
  }

  final String title;
  final String icon;
  final String targetType;
  final String targetValue;
  final String menuType;
}

class MobilePageModel {
  const MobilePageModel({
    required this.title,
    required this.slug,
    required this.blocks,
  });

  factory MobilePageModel.fromJson(Map<String, dynamic> json) {
    final schema = json['jsonSchema'] as Map<String, dynamic>? ?? {};
    final blocksJson = schema['blocks'] as List<dynamic>? ?? [];

    return MobilePageModel(
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      blocks: blocksJson
          .map((block) => BuilderBlock.fromJson(block as Map<String, dynamic>))
          .toList(),
    );
  }

  final String title;
  final String slug;
  final List<BuilderBlock> blocks;
}

class PreviewPayload {
  const PreviewPayload({
    required this.previewToken,
    required this.shop,
    required this.expiresAt,
  });

  factory PreviewPayload.fromQr(String rawValue) {
    final json = jsonDecode(rawValue) as Map<String, dynamic>;
    return PreviewPayload(
      previewToken: json['previewToken'] as String,
      shop: json['shop'] as String,
      expiresAt: json['expiresAt'] as String,
    );
  }

  final String previewToken;
  final String shop;
  final String expiresAt;
}

class ShopifyCollectionModel {
  const ShopifyCollectionModel({
    required this.id,
    required this.title,
    required this.handle,
    required this.imageUrl,
    required this.productsCount,
  });

  factory ShopifyCollectionModel.fromJson(Map<String, dynamic> json) {
    return ShopifyCollectionModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      handle: json['handle'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      productsCount: json['productsCount'] as int? ?? 0,
    );
  }

  final String id;
  final String title;
  final String handle;
  final String? imageUrl;
  final int productsCount;
}

class ShopifyProductModel {
  const ShopifyProductModel({
    required this.id,
    required this.title,
    required this.handle,
    required this.imageUrl,
    required this.price,
    required this.currencyCode,
    required this.compareAtPrice,
  });

  factory ShopifyProductModel.fromJson(Map<String, dynamic> json) {
    return ShopifyProductModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      handle: json['handle'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      price: json['price'] as String? ?? '0.00',
      currencyCode: json['currencyCode'] as String? ?? 'USD',
      compareAtPrice: json['compareAtPrice'] as String?,
    );
  }

  final String id;
  final String title;
  final String handle;
  final String? imageUrl;
  final String price;
  final String currencyCode;
  final String? compareAtPrice;
}

class CatalogModel {
  const CatalogModel({
    required this.collections,
    required this.products,
    required this.productsByCollection,
  });

  factory CatalogModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const CatalogModel(
        collections: [],
        products: [],
        productsByCollection: {},
      );
    }

    final collectionsJson = json['collections'] as List<dynamic>? ?? [];
    final productsJson = json['products'] as List<dynamic>? ?? [];
    final byCollectionJson =
        json['productsByCollection'] as Map<String, dynamic>? ?? {};

    final productsByCollection = <String, List<ShopifyProductModel>>{};
    for (final entry in byCollectionJson.entries) {
      productsByCollection[entry.key] = (entry.value as List<dynamic>? ?? [])
          .map((item) => ShopifyProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return CatalogModel(
      collections: collectionsJson
          .map((item) => ShopifyCollectionModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      products: productsJson
          .map((item) => ShopifyProductModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      productsByCollection: productsByCollection,
    );
  }

  final List<ShopifyCollectionModel> collections;
  final List<ShopifyProductModel> products;
  final Map<String, List<ShopifyProductModel>> productsByCollection;
}

class PreviewConfig {
  const PreviewConfig({
    required this.shopId,
    required this.shopDomain,
    required this.appSettings,
    required this.pages,
    required this.navigation,
    required this.catalog,
  });

  factory PreviewConfig.fromJson(Map<String, dynamic> json) {
    final config = json['config'] as Map<String, dynamic>? ?? {};
    final pagesJson = json['pages'] as List<dynamic>? ?? [];
    final navigationJson = json['navigation'] as List<dynamic>? ?? [];

    return PreviewConfig(
      shopId: json['shopId'] as String? ?? config['shopId'] as String? ?? '',
      shopDomain: json['shopDomain'] as String? ?? config['shopDomain'] as String? ?? '',
      appSettings: AppSettingsModel.fromJson(
        (json['appSettings'] ?? config['appSettings']) as Map<String, dynamic>?,
      ),
      pages: pagesJson
          .map((page) => MobilePageModel.fromJson(page as Map<String, dynamic>))
          .toList(),
      navigation: navigationJson
          .map((item) => NavigationItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      catalog: CatalogModel.fromJson(json['catalog'] as Map<String, dynamic>?),
    );
  }

  final String shopId;
  final String shopDomain;
  final AppSettingsModel appSettings;
  final List<MobilePageModel> pages;
  final List<NavigationItemModel> navigation;
  final CatalogModel catalog;

  MobilePageModel? get homePage => pageBySlug('home') ?? (pages.isNotEmpty ? pages.first : null);

  MobilePageModel? pageBySlug(String slug) {
    for (final page in pages) {
      if (page.slug == slug) {
        return page;
      }
    }
    return null;
  }

  List<NavigationItemModel> get bottomNavigation =>
      navigation.where((item) => item.menuType != 'side').toList();

  List<NavigationItemModel> get sideNavigation =>
      navigation.where((item) => item.menuType == 'side').toList();
}
