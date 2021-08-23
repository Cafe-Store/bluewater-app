import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../events/presentation/widget/events_slider_widget.dart';
import '../../../shops_dashboard/presentation/controller/shops_dashboard_controller.dart';
import '../../../shops_dashboard/presentation/widget/shops_widget.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    preferredSize: Size.fromHeight(Get.height / 6),
                  ),
                ),
              ),
              //categories
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: Container(
                        color: Colors.amber[300],
                        child: const Center(
                          child: Text('categories'),
                        ),
                      ),
                    ),
                    preferredSize: Size.fromHeight(Get.height / 8),
                  ),
                ),
              ),
              //star shop
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        color: Colors.cyan[300],
                        child: const Center(
                          child: Text('star shop'),
                        ),
                      ),
                    ),
                    preferredSize: Size.fromHeight(Get.height / 4),
                  ),
                ),
              ),
              //new shop
              SliverPersistentHeader(
                delegate: _SliverHeaderDelegate(
                  child: PreferredSize(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        color: Colors.cyan,
                        child: const Center(
                          child: Text('new shop'),
                        ),
                      ),
                    ),
                    preferredSize: Size.fromHeight(Get.height / 4),
                  ),
                ),
              ),
            ];
          },
          body: SafeArea(
            top: false,
            bottom: false,
            child: Builder(
              builder: (context) {
                return ShopsWidget(
                  controller:
                      Get.find<ShopsDashboardController>(tag: Tags.dashboard),
                  parentScroll: PrimaryScrollController.of(context)!,
                );
              },
            ),
          ),
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
