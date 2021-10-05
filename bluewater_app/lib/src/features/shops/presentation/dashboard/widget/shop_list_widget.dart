import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
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

    if (controller.isScrolled || controller.preScrollOffset > 0.0) {
      widgetList.add(
        createJumpButton(),
      );
    }

    return widgetList;
  }

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
                child: ShopListItem(controller.datas[index], tag),
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
  final String? _tag;

  ShopListItem(
    this.shop,
    this._tag, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: CachedNetworkImage(
              imageUrl: shop.photo.uri,
              imageBuilder: (context, imageProvider) => Container(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              _tag ?? shop.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
                size: 16,
              ),
              Text(
                '${shop.rank.value}(${shop.rank.count})',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
