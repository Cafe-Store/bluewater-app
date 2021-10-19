import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shop_details_controller.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  const ShopDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _ShopDetailSliverHeaderDelegate(
                expandedHeight: Get.height * 0.6, controller: controller),
            pinned: true,
          ),
        ],
      ),
    );
  }
}

class _ShopDetailSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ShopDetailsController controller;

  _ShopDetailSliverHeaderDelegate(
      {required this.expandedHeight, required this.controller});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = 60;
    final top = expandedHeight - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
        Positioned(
          top: top,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: (shrinkOffset > 0.0) ? Colors.black : Colors.white,
          ),
          onPressed: () {
            controller.startRouteName != null
                ? Get.rootDelegate
                    .backUntil(controller.startRouteName.toString())
                : Get.rootDelegate.popRoute(popMode: PopMode.History);
          },
        ),
        title: Opacity(
          opacity: appear(shrinkOffset),
          child: Text('가게 이름'),
        ),
        centerTitle: true,
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          'https://source.unsplash.com/random?mono+dark',
          fit: BoxFit.cover,
        ),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Container(),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
