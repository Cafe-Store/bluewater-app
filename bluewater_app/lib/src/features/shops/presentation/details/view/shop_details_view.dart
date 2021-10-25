import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../shared/ui/color/shimmer_color.dart';
import '../controller/shop_details_controller.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  const ShopDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Obx(() {
      return Container();
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: _ShopDetailSliverHeaderDelegate(
                expandedHeight: Get.height * 0.7, controller: controller),
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
  late final _floatContainerHeight;

  _ShopDetailSliverHeaderDelegate(
      {required this.expandedHeight, required this.controller}) {
    _floatContainerHeight = expandedHeight * 0.2;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(
      () => Stack(
        fit: StackFit.expand,
        children: [
          _createShopInfoWidget(context, shrinkOffset),
          _createAppBar(context, shrinkOffset),
          _createFloatingArea(context, shrinkOffset),
        ],
      ),
    );
  }

  double _appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double _disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget _createAppBar(BuildContext context, double shrinkOffset) => AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          color: (shrinkOffset == expandedHeight) ? Colors.black : Colors.white,
          icon: Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () {
            controller.startRouteName != null
                ? Get.rootDelegate
                    .backUntil(controller.startRouteName.toString())
                : Get.rootDelegate.popRoute(popMode: PopMode.History);
          },
        ),
        title: Opacity(
          opacity: _appear(shrinkOffset),
          child: Text(controller.shop.value.name),
        ),
        centerTitle: false,
      );

  Widget _createShopInfoWidget(BuildContext context, double shrinkOffset) =>
      Opacity(
        opacity: _disappear(shrinkOffset),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: _createImageSlider(context),
            ),
            Expanded(
              flex: 5,
              child: _createBottomArea(),
            ),
          ],
        ),
      );

  Widget _createImageSlider(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _ImageSlider(controller: controller),
        Positioned(
          bottom: _floatContainerHeight / 2 + 10,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.5)),
            child: Text(
              '${controller.currentIdex} / 1',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createBottomArea() {
    return Container(
      color: Colors.yellow,
    );
  }

  Widget _createFloatingArea(BuildContext context, double shrinkOffset) {
    final top = (expandedHeight - shrinkOffset) / 2 - _floatContainerHeight / 2;
    var shop = controller.shop.value;

    return Positioned(
      top: top,
      left: 20,
      right: 20,
      child: Opacity(
        opacity: _disappear(shrinkOffset),
        child: Container(
          constraints: BoxConstraints(minHeight: _floatContainerHeight),
          color: Theme.of(context).backgroundColor,
          child: controller.isLoadedShop
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shop.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Visibility(
                      visible: shop.rank.count != 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text('${shop.rank.value}',
                              style: Theme.of(context).textTheme.headline6),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextButton(
                              onPressed: () => print('리뷰 보자!!'),
                              child: Row(
                                children: [
                                  Text('리뷰 ${shop.rank.count}개',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(color: Colors.blue)),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _ImageSlider extends StatelessWidget {
  const _ImageSlider({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShopDetailsController controller;

  @override
  Widget build(BuildContext context) {
    var shop = controller.shop.value;

    return CarouselSlider.builder(
      itemCount: controller.isLoadedShop ? shop.photos.length : 1,
      itemBuilder: (context, index, realIndex) {
        return controller.isLoadedShop
            ? CachedNetworkImage(
                // color: Colors.grey[300],
                // colorBlendMode: BlendMode.multiply,
                fit: BoxFit.cover,
                imageUrl: shop.photos[index].photo.uri,
              )
            : Shimmer.fromColors(
                child: Container(
                  color: Colors.black,
                ),
                baseColor: ShimmerColor.baseColor,
                highlightColor: ShimmerColor.highlightColor);
      },
      options: CarouselOptions(
        autoPlay: true,
        disableCenter: true,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          controller.currentIdex(++index);
        },
        scrollPhysics:
            !controller.isLoadedShop ? NeverScrollableScrollPhysics() : null,
      ),
    );
  }
}
