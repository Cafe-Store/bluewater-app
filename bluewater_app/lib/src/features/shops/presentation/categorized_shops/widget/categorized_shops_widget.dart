import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../domain/entity/shop.dart';
import '../controller/categorized_shops_controller.dart';

class CategorizedShopsWidget extends GetWidget<CategorizedShopsController> {
  final String title;

  @override
  final String tag;

  CategorizedShopsWidget({
    required this.title,
    required this.tag,
    Key? key,
  }) : super(key: key) {
    Get.create(() => CategorizedShopsController(), tag: tag);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.datas.isEmpty) {
          return Container();
        } else {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    IconButton(
                      onPressed: () => print('gogo!!'),
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == 9) {
                          return _createMoreButton();
                        } else {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: _ShopItem(shop: controller.datas[index]),
                          );
                        }
                      },
                      itemCount: 10),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Center _createMoreButton() {
    return Center(
      child: SizedBox.fromSize(
        size: Size(60, 60),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () => print('gogo!!'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black54,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text("더보기"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopItem extends StatelessWidget {
  final Size imageSize;
  final Shop shop;
  const _ShopItem({
    required this.shop,
    this.imageSize = const Size(150, 150),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 10,
          child: CachedNetworkImage(
            imageUrl: shop.photo.uri,
            imageBuilder: (context, imageProvider) => Container(
              height: imageSize.height,
              width: imageSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
        Text(
          shop.name,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 15,
            ),
            Text(
              '${shop.rank.value}(${shop.rank.count})',
              style:
                  Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 12),
            )
          ],
        ),
      ],
    );
  }
}
