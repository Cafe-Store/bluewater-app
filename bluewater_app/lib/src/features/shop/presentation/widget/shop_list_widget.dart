import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/shop.dart';
import 'shop_fliter_list_widget.dart';
import '../controller/shop_controller.dart';

class ShopListWidget extends GetWidget<ShopController> {
  const ShopListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: _createContent(context),
      ),
    );
  }

  List<Widget> _createContent(BuildContext context) {
    List<Widget> widgetList = [];

    widgetList.add(
      CustomScrollView(
        controller: controller.scroll,
        slivers: <Widget>[
          SliverAppBar(
            title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '골라먹는 맛집',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          const SliverAppBar(
            pinned: true,
            title: ShopFilterListWidget(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 5.0),
                  child: ShopListItem(controller.shops[index]),
                );
              },
              childCount: controller.shops.length,
            ),
          ),
        ],
      ),
    );

    if (controller.isScrolled) {
      widgetList.add(
        Positioned(
          bottom: Get.height / 5,
          right: Get.width / 20,
          child: ElevatedButton(
            onPressed: () =>
                controller.scroll.jumpTo(controller.scroll.initialScrollOffset),
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
        ),
      );
    }

    return widgetList;
  }
}

class ShopListItem extends StatelessWidget {
  final Shop shop;

  const ShopListItem(
    this.shop, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height / 3,
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: CachedNetworkImage(
            imageUrl: shop.photo.uri,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                shop.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const Spacer(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
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
        ),
      ],
    );
  }
}
