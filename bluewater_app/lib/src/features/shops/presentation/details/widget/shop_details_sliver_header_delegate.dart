part of '../view/shop_details_view.dart';

class _ShopDetailsSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final ShopDetailsController controller;
  late final double _floatContainerHeight;
  final double horizontalPadding = 20;

  _ShopDetailsSliverHeaderDelegate(
      {required this.expandedHeight, required this.controller}) {
    _floatContainerHeight = expandedHeight * 0.2;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Obx(
      () => Stack(
        children: [
          _createShopInfoWidget(context, shrinkOffset),
          _createAppBar(context, shrinkOffset),
          _createFloatingArea(context, shrinkOffset),
        ],
      ),
    );
  }

  double _appear(double shrinkOffset) =>
      math.min((shrinkOffset) / expandedHeight, 1.0);

  double _disappear(double shrinkOffset) =>
      1 - math.min((shrinkOffset * 1.5) / expandedHeight, 1.0);

  Widget _createAppBar(BuildContext context, double shrinkOffset) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top * 0.6),
        constraints: BoxConstraints(minHeight: minExtent),
        color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(
              _appear(shrinkOffset),
            ),
        child: Row(
          children: [
            IconButton(
              color: _appear(shrinkOffset) > 0.5 ? Colors.black : Colors.white,
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
            Expanded(
              child: Opacity(
                opacity: _appear(shrinkOffset),
                child: Text(
                  controller.shop.value.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            IconButton(
              color: _appear(shrinkOffset) > 0.5 ? Colors.black : Colors.white,
              onPressed: () {},
              icon: Icon(
                Icons.share,
              ),
            ),
            IconButton(
              color: _appear(shrinkOffset) > 0.5
                  ? Colors.redAccent[400]
                  : Colors.white,
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline_rounded,
              ),
            )
          ],
        ),
      );

  Widget _createShopInfoWidget(BuildContext context, double shrinkOffset) =>
      Opacity(
        opacity: _disappear(shrinkOffset),
        child: Column(
          children: [
            Expanded(
              flex: controller.hasReview ? 5 : 7,
              child: _createShopPhotoSlider(context, shrinkOffset),
            ),
            Expanded(
              flex: controller.hasReview ? 5 : 3,
              child: _createBottomArea(context),
            ),
          ],
        ),
      );

  Widget _createShopPhotoSlider(BuildContext context, double shrinkOffset) {
    final top =
        (expandedHeight - shrinkOffset) * (controller.hasReview ? 0.5 : 0.69) -
            _floatContainerHeight;

    return Stack(
      fit: StackFit.expand,
      children: [
        _ImageSlider(controller: controller),
        Positioned(
          top: top,
          right: horizontalPadding,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.5)),
            child: Text(
              '${controller.currentIdex} / ${controller.shop.value.photos.length}',
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

  Widget _createBottomArea(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: _floatContainerHeight * (controller.hasReview ? 0.5 : 0.7),
          left: horizontalPadding,
          right: horizontalPadding),
      child: Column(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '영업중 (09:00 ~ 17:00)',
                          style: Theme.of(context).textTheme.bodyText1!,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Get.rootDelegate.toNamed(
                    Routes.shopInfos(controller.shopId),
                  ),
                  child: Row(
                    children: [
                      Text('매장정보',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blue)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: controller.hasReview ? 2 : 0,
            child: Visibility(
              visible: controller.hasReview,
              child: Container(
                color: Colors.deepOrange,
                child: Center(
                  child: Text('여긴 리뷰 목록을 보여줄려고 함'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createFloatingArea(BuildContext context, double shrinkOffset) {
    final top =
        (expandedHeight - shrinkOffset) * (controller.hasReview ? 0.5 : 0.69) -
            (_floatContainerHeight / 2);
    var shop = controller.shop.value;

    return Positioned(
      top: top,
      left: horizontalPadding,
      right: horizontalPadding,
      child: Opacity(
        opacity: _disappear(shrinkOffset),
        child: Container(
          constraints: BoxConstraints(minHeight: _floatContainerHeight),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          child: controller.isLoadedShop
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shop.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Visibility(
                      visible: controller.hasReview,
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
                                          .bodyText1!
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
  double get minExtent => kToolbarHeight + 50;

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
