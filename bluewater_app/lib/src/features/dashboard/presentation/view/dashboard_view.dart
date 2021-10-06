import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/ui/widget/shimmer/shimmer.dart';
import '../../../categories/presentation/widget/categories_widget.dart';
import '../../../events/presentation/widget/events_slider_widget.dart';
import '../../../shops/presentation/categorized_shops/widget/categorized_shops_widget.dart';
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
      body: Shimmer(
        linearGradient: Shimmer.shimmerGradient,
        child: RefreshIndicator(
          onRefresh: () => Future.delayed(
            const Duration(seconds: 2),
          ),
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
                        title: '인기 가게',
                        tag: Tags.homePopularShops),
                    shopHeight,
                  ),

                  //new shop
                  _createCategoriezedShopsArea(
                    context,
                    CategorizedShopsWidget(
                        key: PageStorageKey('newShop'),
                        title: '새로 들어왔어요!',
                        tag: Tags.homeNewlyShops),
                    shopHeight,
                  ),

                  SliverToBoxAdapter(
                    child: Container(
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.only(left: 10.0, top: 8.0),
                      child: Text(
                        '우리 동네 가게',
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
}
