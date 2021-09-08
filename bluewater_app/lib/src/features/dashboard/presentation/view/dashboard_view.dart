import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../categories/presentation/widget/categories_widget.dart';
import '../../../events/presentation/widget/events_slider_widget.dart';
import '../../../shops/presentation/categorized_shops/widget/categorized_shops_widget.dart';
import '../../../shops/presentation/dashboard/widget/shops_widget.dart';
import '../../../shops/presentation/filter/widget/shops_fliter_list_widget.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var eventHCorrection = context.isLandscape ? 3 : 6;
    var categoryHCorrection = context.isLandscape ? 4 : 8;
    var shopHCorrection = context.isLandscape ? 1.5 : 4;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(
          const Duration(seconds: 2),
        ),
        notificationPredicate: (notification) {
          return true;
        },
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              //events
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: PreferredSize(
                    child: EventSlider(),
                    preferredSize:
                        Size.fromHeight(Get.height / eventHCorrection),
                  ),
                ),
              ),
              //categories
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: PreferredSize(
                    child: Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: CategoriesWidget()),
                    preferredSize:
                        Size.fromHeight(Get.height / categoryHCorrection),
                  ),
                ),
              ),
              //star shop
              _createCategoriezedShopsArea(
                context,
                CategorizedShopsWidget(title: '인기 가게', tag: Tags.popularShops),
                shopHCorrection,
              ),

              //new shop
              _createCategoriezedShopsArea(
                context,
                CategorizedShopsWidget(
                    title: '새로 들어왔어요!', tag: Tags.newlyShops),
                shopHCorrection,
              ),
            ];
          },
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) {
                return ShopsWidget(
                  topAreaSliverWidgets: [
                    SliverAppBar(
                      title: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '우리 동네 가게',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ),
                    SliverAppBar(
                      pinned: true,
                      title: ShopsFilterListWidget(
                        tag: Tags.homeDashboard,
                      ),
                    ),
                  ],
                  tag: Tags.homeDashboard,
                  parentScroll: PrimaryScrollController.of(context)!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  SliverPersistentHeader _createCategoriezedShopsArea(BuildContext context,
      CategorizedShopsWidget categorizedShopsWidget, num shopHCorrection) {
    return SliverPersistentHeader(
      delegate: _SliverHeaderDelegate(
        child: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: categorizedShopsWidget,
          ),
          preferredSize: Size.fromHeight(Get.height / shopHCorrection),
        ),
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
