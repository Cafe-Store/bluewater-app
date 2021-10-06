import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../shared/ui/widget/parallax/parallax_flow_delegate.dart';
import '../../../domain/entity/shop.dart';
import '../controller/shop_list_controller.dart';

class ShopListWidget extends GetWidget<ShopListController> {
  final ScrollController innerScroll;
  final List<Widget>? topAreaSliverWidgets;
  final String? startRouteName;
  final Widget? sliverOverlapInjector;
  final bool needCorrectScrollOffset;
  late final double _initScrollOffset;

  @override
  final String? tag;

  ShopListWidget({
    this.tag,
    this.startRouteName,
    this.topAreaSliverWidgets,
    this.needCorrectScrollOffset = false,
    this.sliverOverlapInjector,
    required this.innerScroll,
    Key? key,
  }) : super(key: key) {
    _initScrollOffset = needCorrectScrollOffset ? -0.01 : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    controller.scroll = innerScroll;
    return Obx(
      () {
        if (controller.datas.isEmpty) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.grey,
              size: 15,
            ),
          );
        } else {
          return Stack(
            children: _createContent(context),
          );
        }
      },
    );
  }

  List<Widget> _createContent(BuildContext context) {
    var widgetList = <Widget>[];
    widgetList.add(CustomScrollView(
      controller: controller.scroll,
      key: PageStorageKey('shoplist_customScrollView'),
      slivers: createSlivers(context),
    ));

    if (_isShowJumpButton) {
      widgetList.add(
        createJumpButton(),
      );
    }

    return widgetList;
  }

  bool get _isShowJumpButton =>
      controller.isScrolled && controller.preScrollOffset > 0.0;

  Positioned createJumpButton() {
    return Positioned(
      bottom: Get.height / 10,
      right: Get.width / 20,
      child: ElevatedButton(
        onPressed: () {
          controller.scroll.jumpTo(_initScrollOffset);
          controller.preScrollOffset(0.0);
        },
        child: const Icon(
          Icons.arrow_upward_outlined,
          size: 30,
        ),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          primary: Colors.grey[100]!.withOpacity(0.8),
          onPrimary: Colors.black,
        ),
      ),
    );
  }

  List<Widget> createSlivers(BuildContext context) {
    var slivers = <Widget>[];
    if (topAreaSliverWidgets != null) {
      slivers.addAll(topAreaSliverWidgets!);
    }

    if (sliverOverlapInjector != null) {
      slivers.add(sliverOverlapInjector!);
    }
    slivers.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () {
                Get.rootDelegate.toNamed(Routes.shopDetails('$index'),
                    arguments: startRouteName);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: ShopListItem(
                  controller.datas[index],
                ),
              ),
            );
          },
          childCount: controller.datas.length,
        ),
      ),
    );
    return slivers;
  }
}

class ShopListItem extends StatelessWidget {
  final Shop shop;
  final GlobalKey _backgroundImageKey = GlobalKey();

  ShopListItem(
    this.shop, {
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              _createParallaxBackground(context),
              _createGradient(),
              _createInfoArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context)!,
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        CachedNetworkImage(
          imageUrl: shop.photo.uri,
          imageBuilder: (context, imageProvider) => Container(
            key: _backgroundImageKey,
            height: Get.height / 3,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _createInfoArea(BuildContext context) {
    return Positioned(
      left: 15,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            shop.name,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                Text(
                  '${shop.rank.value}(${shop.rank.count})',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
