import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../shared/ui/color/shimmer_color.dart';
import '../controller/shop_details_controller.dart';

part '../widget/shop_details_sliver_header_delegate.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  const ShopDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return DefaultTabController(
          //TODO 그룹 갯수로 변경해야 함.
          length: 4,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: _ShopDetailsSliverHeaderDelegate(
                      expandedHeight:
                          Get.height * (controller.hasReview ? 0.6 : 0.4),
                      controller: controller),
                  pinned: true,
                ),
                SliverPersistentHeader(
                  delegate:
                      _TabHeaderDelegate(controller: controller, height: 80),
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(15),
                        child: Container(
                          color: Colors.blue[100 * (index % 9 + 1)],
                          height: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "Item $index",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ),
                      );
                    },
                    childCount: 1000, // 1000 list items
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabHeaderDelegate extends SliverPersistentHeaderDelegate {
  final ShopDetailsController controller;
  final double height;

  _TabHeaderDelegate({
    required this.controller,
    required this.height,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
        boxShadow: [
          BoxShadow(color: Theme.of(context).backgroundColor, spreadRadius: 1),
        ],
      ),
      child: TabBar(
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 5,
            color: Colors.black,
          ),
        ),
        //TODO 그룹으로 변경해야 함.
        tabs: [
          Tab(
            child: Text(
              '인기 상품',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Tab(
            child: Text(
              '아디다스',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Tab(
            child: Text(
              '뉴발란스',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Tab(
            child: Text(
              '나이키',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
