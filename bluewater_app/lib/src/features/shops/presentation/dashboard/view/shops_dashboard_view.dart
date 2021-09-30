import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/ui/custom/custom_nested_scroll_view.dart'
    as custom;
import '../../filter/widget/shops_fliter_list_widget.dart';
import '../../home/controller/shops_controller.dart';
import '../widget/nested_sliver_tabbar_header_delegate.dart';
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
        child: custom.CustomNestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            controller.tabController = DefaultTabController.of(context);
            return [
              custom.SliverOverlapAbsorber(
                handle: custom.CustomNestedScrollView
                    .sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  delegate: NestedSliverTabBarheaderDelegate(
                    expandedHeight: math.max(80, Get.height * 0.1),
                    items: controller.categoris,
                    indicatorColor: Colors.lightBlue,
                    bgColor: Theme.of(context).appBarTheme.backgroundColor!,
                    tabControllMixin: controller,
                    bottom: PreferredSize(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        child: ShopsFilterListWidget(
                          key: PageStorageKey('ShopsFilter'),
                        ),
                      ),
                      preferredSize: Size.fromHeight(55),
                    ),
                  ),
                  pinned: true,
                ),
              ),
            ];
          },
          body: TabBarView(
            key: PageStorageKey('tabBar'),
            children: controller.categoris.map((category) {
              return SafeArea(
                child: Builder(builder: (context) {
                  return ShopListWidget(
                    needCorrectScrollOffset: true,
                    key: PageStorageKey<String>(category.name),
                    innerScroll: PrimaryScrollController.of(context)!,
                    tag: category.name,
                    sliverOverlapInjector: custom.SliverOverlapInjector(
                      // This is the flip side of the SliverOverlapAbsorber
                      // above.
                      handle: custom.CustomNestedScrollView
                          .sliverOverlapAbsorberHandleFor(context),
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        ),
      );
    } else {
      return ShopListWidget(
        needCorrectScrollOffset: true,
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
