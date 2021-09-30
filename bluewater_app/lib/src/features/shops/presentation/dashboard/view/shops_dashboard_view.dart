import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/model/tab_item.dart';
import '../../../../../shared/ui/controller/tab_controll_mixin.dart';
import '../../../../../shared/ui/custom/custom_nested_scroll_view.dart';
import '../../../../categories/presentation/widget/category_item.dart';
import '../../filter/widget/shops_fliter_list_widget.dart';
import '../../home/controller/shops_controller.dart';
import '../widget/shop_list_widget.dart';

class ShopsDashboardView extends GetView<ShopsController> {
  final String pageKey = 'shopDashboard';

  const ShopsDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.rootDelegate.popRoute()),
        title: Obx(
          () => Text(
            controller.title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(
        () => controller.title.isEmpty
            ? Container()
            : PageStorage(
                bucket: controller.pageStorageBucket,
                child: RefreshIndicator(
                  onRefresh: () => Future.delayed(
                    const Duration(seconds: 2),
                  ),
                  notificationPredicate: (notification) {
                    return true;
                  },
                  child: createContent(context),
                ),
              ),
      ),
    );
  }

  Widget createContent(BuildContext context) {
    if (controller.showCategoryTab) {
      return DefaultTabController(
        length: controller.categoris.length,
        initialIndex: controller.tabIndex,
        child: CustomNestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            controller.tabController = DefaultTabController.of(context);
            return [
              SliverPersistentHeader(
                delegate: _SliverTabBarheaderDelegate(
                  expandedHeight: math.max(80, Get.height * 0.1),
                  items: controller.categoris,
                  indicatorColor: Colors.lightBlue,
                  bgColor: Theme.of(context).appBarTheme.backgroundColor!,
                  tabControllMixin: controller,
                ),
                pinned: true,
              ),
              SliverAppBar(
                pinned: true,
                title:
                    ShopsFilterListWidget(key: PageStorageKey('ShopsFilter')),
              ),
            ];
          },
          body: TabBarView(
            key: PageStorageKey('tabBar'),
            children: controller.categoris.map((category) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(builder: (context) {
                  return ShopListWidget(
                    key: PageStorageKey<String>(category.name),
                    innerScroll: PrimaryScrollController.of(context)!,
                    tag: category.name,
                  );
                }),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return ShopListWidget(
        topAreaSliverWidgets: [
          SliverAppBar(
            pinned: true,
            title: ShopsFilterListWidget(
              key: PageStorageKey('shopsfilter'),
            ),
          ),
        ],
        innerScroll: PrimaryScrollController.of(context)!,
        tag: controller.title,
      );
    }
  }
}

class _SliverTabBarheaderDelegate<T extends TabItem>
    extends SliverPersistentHeaderDelegate {
  final double _minBodersideWidth = 2.0;
  final double _minFontSize = 12;
  final double expandedHeight;
  final List<T> items;
  late final double minHeight;
  final Color indicatorColor;
  final Color bgColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color imageBorderColor;
  final Color unselectedImageBorderColor;
  final TabControllMixin tabControllMixin;

  _SliverTabBarheaderDelegate({
    required this.expandedHeight,
    required this.items,
    required this.tabControllMixin,
    this.indicatorColor = Colors.lightBlue,
    this.bgColor = Colors.white,
    this.labelColor = Colors.lightBlue,
    this.imageBorderColor = Colors.lightBlue,
    this.unselectedLabelColor = Colors.black,
    this.unselectedImageBorderColor = Colors.transparent,
  }) : assert(expandedHeight >= 80 && expandedHeight <= 800) {
    minHeight = expandedHeight * 0.7;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bodersideWidth = math.max(_minBodersideWidth, minHeight * 0.05);

    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: math.max(-shrinkOffset, -minHeight + 3),
          left: 0,
          right: 0,
          child: Container(
            color: bgColor,
            height: expandedHeight,
            child: Obx(
              () => TabBar(
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: bodersideWidth,
                    color: indicatorColor,
                  ),
                ),
                tabs: items.asMap().entries.map((entry) {
                  return Tab(
                    child: CategoryItem<T>(
                      item: entry.value,
                      imageSize: Size(minHeight * 0.8, minHeight * 0.8),
                      borderColor: entry.key == tabControllMixin.tabIndex
                          ? imageBorderColor
                          : unselectedImageBorderColor,
                      titleStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: math.max(_minFontSize, minHeight * 0.2),
                              color: entry.key == tabControllMixin.tabIndex
                                  ? labelColor
                                  : unselectedLabelColor),
                    ),
                    height: expandedHeight,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
