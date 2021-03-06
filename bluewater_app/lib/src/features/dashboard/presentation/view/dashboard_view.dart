import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../../routes/app_pages.dart';
import '../../../categories/presentation/widget/categories_widget.dart';
import '../../../events/presentation/widget/events_slider_widget.dart';
import '../../../shops/presentation/categorized_shops/widget/categorized_shops_widget.dart';
import '../../../shops/presentation/dashboard/controller/shop_list_controller.dart';
import '../../../shops/presentation/dashboard/widget/shop_list_widget.dart';
import '../../../shops/presentation/filter/widget/shops_fliter_list_widget.dart';
import '../../serivce/dashboard_service.dart';

class DashboardView extends GetView<DashboardService> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eventHCorrection = context.isLandscape ? 3 : 6;
    var categoryHCorrection = context.isLandscape ? 4 : 8;
    var shopHCorrection = context.isLandscape ? 1.5 : 4;

    var eventHeight = Get.height / eventHCorrection;
    var categoryHeight = Get.height / categoryHCorrection;
    var shopHeight = Get.height / shopHCorrection;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: RefreshIndicator(
        onRefresh: reloadDatas,
        notificationPredicate: (notification) {
          return true;
        },
        child: PageStorage(
          bucket: controller.pageStorageBucket,
          child: SafeArea(
            top: false,
            bottom: false,
            child: ShopListWidget(
              key: PageStorageKey('shopList'),
              topAreaSliverWidgets: [
                //events
                SliverToBoxAdapter(
                  child: Container(
                    height: eventHeight,
                    child: EventSlider(
                      key: PageStorageKey('events'),
                    ),
                  ),
                ),
                //categories
                SliverToBoxAdapter(
                  child: Container(
                    height: categoryHeight,
                    child: CategoriesWidget(
                      key: PageStorageKey('categories'),
                    ),
                  ),
                ),
                //star shop
                _createCategoriezedShopsArea(
                  context,
                  CategorizedShopsWidget(
                    key: PageStorageKey('starShop'),
                    title: '?????? ??????',
                    tag: Tags.homeStarShops,
                    startRouteName: Routes.home,
                  ),
                  shopHeight,
                ),

                //new shop
                _createCategoriezedShopsArea(
                  context,
                  CategorizedShopsWidget(
                    key: PageStorageKey('newShop'),
                    title: '?????? ???????????????!',
                    tag: Tags.homeNewlyShops,
                    startRouteName: Routes.home,
                  ),
                  shopHeight,
                ),

                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, top: 8.0),
                    child: Text(
                      '?????? ?????? ??????',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),

                SliverAppBar(
                  pinned: true,
                  title: ShopsFilterListWidget(
                    key: PageStorageKey('home_dashboard_shops_filter'),
                    tag: Tags.homeDashboard,
                  ),
                ),
              ],
              tag: Tags.homeDashboard,
              startRouteName: Routes.home,
              innerScroll: PrimaryScrollController.of(context)!,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createCategoriezedShopsArea(BuildContext context,
      CategorizedShopsWidget categorizedShopsWidget, double height) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: categorizedShopsWidget,
        height: height,
      ),
    );
  }

  Future<void> reloadDatas() {
    return Future<void>(() {
      Get.find<ShopListController>(tag: Tags.homeDashboard).reloadDatas();
      Get.find<ShopListController>(tag: Tags.homeNewlyShops).reloadDatas();
      Get.find<ShopListController>(tag: Tags.homeStarShops).reloadDatas();
    });
  }
}
