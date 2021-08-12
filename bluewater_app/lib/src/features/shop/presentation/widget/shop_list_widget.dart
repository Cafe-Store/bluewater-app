import 'package:cached_network_image/cached_network_image.dart';
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
      () => CustomScrollView(
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
            imageUrl: shop.imageUrls[0],
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
              Text(
                '14-24분',
                style: Theme.of(context).textTheme.bodyText1,
              )
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
                '${shop.rank}(1,701) · 1.8km  · 무료 배달',
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      ],
    );
  }
}
