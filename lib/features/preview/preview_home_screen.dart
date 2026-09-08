import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../preview/preview_controller.dart';
import '../renderer/block_renderer.dart';
import '../../core/models/mobile_models.dart';
import '../../core/theme/color_utils.dart';

class PreviewHomeScreen extends StatefulWidget {
  const PreviewHomeScreen({super.key});

  @override
  State<PreviewHomeScreen> createState() => _PreviewHomeScreenState();
}

class _PreviewHomeScreenState extends State<PreviewHomeScreen> {
  int _selectedNavIndex = 0;
  String _activeSideSlug = 'home';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  IconData _iconForName(String icon) {
    return switch (icon) {
      'home' => Icons.home_outlined,
      'shop' => Icons.storefront_outlined,
      'collections' => Icons.grid_view_outlined,
      'cart' => Icons.shopping_cart_outlined,
      'wishlist' => Icons.favorite_border,
      'account' => Icons.person_outline,
      'orders' => Icons.receipt_long_outlined,
      'offers' => Icons.local_offer_outlined,
      'about' => Icons.info_outline,
      'help' => Icons.help_outline,
      'search' => Icons.search,
      'storefront' => Icons.storefront_outlined,
      'grid' => Icons.grid_view_outlined,
      'tag' => Icons.local_offer_outlined,
      _ => Icons.home_outlined,
    };
  }

  String _pageSlugForNav(NavigationItemModel item) {
    if (item.targetType == 'page') {
      return item.targetValue;
    }
    return item.targetType;
  }

  MobilePageModel? _pageForSlug(PreviewConfig config, String slug) {
    for (final page in config.pages) {
      if (page.slug == slug) {
        return page;
      }
    }
    return config.homePage;
  }

  Widget _buildBottomNavItem({
    required NavigationItemModel item,
    required bool isActive,
    required Color activeColor,
    required String style,
    required VoidCallback onTap,
  }) {
    final inactiveColor = const Color(0xFF9CA3AF);
    final iconColor = isActive ? activeColor : inactiveColor;
    final textStyle = TextStyle(
      fontSize: 10,
      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
      color: isActive ? activeColor : inactiveColor,
    );

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_iconForName(item.icon), size: 20, color: iconColor),
        const SizedBox(height: 4),
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: textStyle,
        ),
        if (isActive && style == 'style-3')
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        if (isActive && style == 'style-4')
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Container(
              width: 18,
              height: 3,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
      ],
    );

    if (isActive && style == 'style-1') {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            width: double.infinity,
            color: activeColor,
          ),
          const SizedBox(height: 4),
          Icon(_iconForName(item.icon), size: 20, color: iconColor),
          const SizedBox(height: 4),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ],
      );
    }

    Widget child = content;
    if (isActive && style == 'style-2') {
      child = Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: content,
      );
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }

  void _openPage(PreviewConfig config, NavigationItemModel item) {
    final slug = _pageSlugForNav(item);
    final bottomNav = config.bottomNavigation;
    final bottomIndex = bottomNav.indexWhere((nav) => _pageSlugForNav(nav) == slug);
    if (bottomIndex >= 0) {
      setState(() => _selectedNavIndex = bottomIndex);
    } else {
      setState(() => _activeSideSlug = slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviewController>(
      builder: (context, controller, _) {
        final config = controller.config;
        if (config == null) {
          return const Scaffold(
            body: Center(child: Text('No preview loaded')),
          );
        }

        final primaryColor = parseHexColor(config.appSettings.primaryColor);
        final bottomNavigation = config.bottomNavigation;
        final sideNavigation = config.sideNavigation;
        final activeNav = bottomNavigation.isNotEmpty
            ? bottomNavigation[_selectedNavIndex.clamp(0, bottomNavigation.length - 1)]
            : null;
        final activeSlug = activeNav != null ? _pageSlugForNav(activeNav) : _activeSideSlug;
        final activePage = _pageForSlug(config, activeSlug);

        final visibleBlocks = activePage?.blocks
                .where((block) => block.style['visible'] != false)
                .toList() ??
            const <BuilderBlock>[];

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          drawer: sideNavigation.isEmpty
              ? null
              : Drawer(
                  child: SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            config.appSettings.appName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        const Divider(),
                        ...sideNavigation.map(
                          (item) => ListTile(
                            leading: Icon(_iconForName(item.icon)),
                            title: Text(item.title),
                            onTap: () {
                              _openPage(config, item);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          body: activePage == null
              ? const Center(child: Text('No page configured'))
              : Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(
                        left: 4,
                        right: 12,
                        top: MediaQuery.paddingOf(context).top + 6,
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          if (sideNavigation.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.menu, size: 22),
                              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                            )
                          else
                            const SizedBox(width: 48),
                          Expanded(
                            child: Text(
                              config.appSettings.appName,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const Icon(Icons.search, size: 22),
                          const SizedBox(width: 10),
                          const Icon(Icons.shopping_cart_outlined, size: 22),
                        ],
                      ),
                    ),
                    Expanded(
                      child: visibleBlocks.isEmpty
                          ? const Center(child: Text('No widgets on this page'))
                          : ListView(
                              padding: EdgeInsets.zero,
                              children: visibleBlocks
                                  .map(
                                (block) => BlockRenderer(
                                  block: block,
                                  primaryColor: primaryColor,
                                  catalog: config.catalog,
                                ),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
          bottomNavigationBar: bottomNavigation.isEmpty
              ? null
              : SafeArea(
                  top: false,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    child: Row(
                      children: bottomNavigation.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final isActive = index == _selectedNavIndex;

                        return _buildBottomNavItem(
                          item: item,
                          isActive: isActive,
                          activeColor: primaryColor,
                          style: config.appSettings.bottomNavStyle,
                          onTap: () => setState(() {
                            _selectedNavIndex = index;
                            _activeSideSlug = _pageSlugForNav(item);
                          }),
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ),
        );
      },
    );
  }
}
