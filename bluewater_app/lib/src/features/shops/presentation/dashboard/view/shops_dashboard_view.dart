import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/model/tab_item.dart';
import '../../../../../shared/ui/controller/tab_controll_mixin.dart';
import '../../../../categories/presentation/widget/category_item.dart';
import '../../home/controller/shops_controller.dart';
import '../widget/shop_list_widget.dart';

class ShopsDashboardView extends GetView<ShopsController> {
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
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          const Duration(seconds: 2),
        ),
        notificationPredicate: (notification) {
          return true;
        },
        child: createBody(context),
      ),
    );
  }

  Widget createBody(BuildContext context) {
    if (controller.showCategoryTab) {
      return DefaultTabController(
        length: controller.categoris.length,
        initialIndex: controller.tabIndex,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            controller.tabController = DefaultTabController.of(context);
            return createHeaderArea(context);
          },
          body: SafeArea(
            child: TabBarView(
              children: controller.categoris.map((category) {
                return ShopListWidget(
                  tag: category.name,
                  parentScroll: PrimaryScrollController.of(context)!,
                );
              }).toList(),
            ),
          ),
        ),
      );
    } else {
      return ShopListWidget(
        parentScroll: PrimaryScrollController.of(context)!,
      );
    }
  }

  List<Widget> createHeaderArea(BuildContext context) {
    var headerWidgetList = <Widget>[];

    if (controller.showCategoryTab) {
      headerWidgetList.add(
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
      );
    }
    return headerWidgetList;
  }
}

class _SliverTabBarheaderDelegate<T extends TabItem>
    extends SliverPersistentHeaderDelegate {
  final double minBodersideWidth = 2.0;
  final double minFontSize = 12;
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
    final bodersideWidth = math.max(minBodersideWidth, minHeight * 0.05);

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
                              fontSize: math.max(minFontSize, minHeight * 0.2),
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
