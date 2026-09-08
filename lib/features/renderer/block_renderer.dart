import 'package:flutter/material.dart';

import '../../core/models/mobile_models.dart';
import 'blocks/banner_slider_block.dart';
import 'blocks/collection_grid_block.dart';
import 'blocks/countdown_block.dart';
import 'blocks/divider_block.dart';
import 'blocks/header_block.dart';
import 'blocks/image_block.dart';
import 'blocks/instagram_feed_block.dart';
import 'blocks/newsletter_block.dart';
import 'blocks/offer_banner_block.dart';
import 'blocks/product_carousel_block.dart';
import 'blocks/product_grid_block.dart';
import 'blocks/rich_text_block.dart';
import 'blocks/search_bar_block.dart';
import 'blocks/social_links_block.dart';
import 'blocks/testimonials_block.dart';
import 'blocks/text_block.dart';
import 'blocks/video_block.dart';

class BlockRenderer extends StatelessWidget {
  const BlockRenderer({
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
    switch (block.type) {
      case 'header':
        return HeaderBlock(block: block, primaryColor: primaryColor);
      case 'search_bar':
        return SearchBarBlock(block: block);
      case 'product_carousel':
        return ProductCarouselBlock(
          block: block,
          primaryColor: primaryColor,
          catalog: catalog,
        );
      case 'collection_grid':
        return CollectionGridBlock(
          block: block,
          primaryColor: primaryColor,
          catalog: catalog,
        );
      case 'product_grid':
        return ProductGridBlock(
          block: block,
          primaryColor: primaryColor,
          catalog: catalog,
        );
      case 'text_block':
        return TextBlockWidget(block: block);
      case 'offer_banner':
        return OfferBannerBlock(block: block, primaryColor: primaryColor);
      case 'banner_slider':
        return BannerSliderBlock(block: block, primaryColor: primaryColor);
      case 'collection_products':
        return ProductGridBlock(
          block: block,
          primaryColor: primaryColor,
          catalog: catalog,
        );
      case 'countdown':
        return CountdownBlock(block: block);
      case 'image_block':
        return ImageBlock(block: block);
      case 'recently_viewed':
        return ProductCarouselBlock(
          block: block,
          primaryColor: primaryColor,
          catalog: catalog,
        );
      case 'divider':
        return DividerBlock(block: block);
      case 'video_block':
        return VideoBlock(block: block);
      case 'rich_text':
        return RichTextBlock(block: block);
      case 'newsletter':
        return NewsletterBlock(block: block);
      case 'testimonials':
        return TestimonialsBlock(block: block);
      case 'social_links':
        return SocialLinksBlock(block: block);
      case 'instagram_feed':
        return InstagramFeedBlock(block: block);
      default:
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(block.title ?? block.type),
            subtitle: Text('Block type "${block.type}" not implemented yet'),
          ),
        );
    }
  }
}
