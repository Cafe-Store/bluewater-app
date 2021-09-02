import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';
import '../../../domain/entity/shop.dart';
import '../controller/shops_dashboard_controller.dart';

class ShopsWidget extends GetWidget<ShopsDashboardController> {
  final ScrollController parentScroll;
  final List<Widget> topAreaSliverWidgets;

  @override
  final String? tag;

  const ShopsWidget({
    this.tag,
    required this.parentScroll,
    required this.topAreaSliverWidgets,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.scroll = parentScroll;

    return Obx(
      () => Stack(
        children: _createContent(context),
      ),
    );
  }

  List<Widget> _createContent(BuildContext context) {
    var widgetList = <Widget>[];
    widgetList.add(
      CustomScrollView(
        slivers: createSlivers,
      ),
    );

    if (controller.isScrolled) {
      widgetList.add(
        Positioned(
          bottom: Get.height / 10,
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

  List<Widget> get createSlivers {
    var slivers = <Widget>[];
    slivers.addAll(topAreaSliverWidgets);
    slivers.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return InkWell(
              onTap: () => Get.rootDelegate
                  .toNamed(Routes.shopDetails('1'), arguments: controller.tag),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: ShopListItem(controller.datas[index]),
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
