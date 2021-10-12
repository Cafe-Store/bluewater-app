import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/util/const.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../shared/ui/color/shimmer_color.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _createTitleArea(context),
          Expanded(
            child: _createListView(context),
          ),
        ],
      ),
    );
  }

  Widget _createTitleArea(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        IconButton(
          onPressed: () {
            if (controller.datas.isNotEmpty) {
              Get.rootDelegate.toNamed(
                Routes.shops,
                parameters: {
                  RoutesParamName.selectedCategoryName: title,
                },
              );
            }
          },
          icon: Icon(
            Icons.arrow_forward_rounded,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  Widget _createListView(BuildContext context) {
    return Obx(
      () {
        if (controller.datas.isEmpty) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return _createMoreButton();
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: _createShimmerShopItem(context),
                  );
                }
              },
              itemCount: 5);
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _ShopItem(shop: controller.datas[index]),
                );
              },
              itemCount: 5);
        }
      },
    );
  }

  Widget _createShimmerShopItem(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ShimmerColor.baseColor,
      highlightColor: ShimmerColor.highlightColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 10,
            child: Container(
              constraints: BoxConstraints(minHeight: 150, minWidth: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
              ),
            ),
          ),
          Spacer(),
          Text(
            '가게 이름',
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
                '0.0(0)',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _createMoreButton() {
    return Center(
      child: SizedBox.fromSize(
        size: Size(60, 60),
        child: ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {
                if (controller.datas.isNotEmpty) {
                  Get.rootDelegate.toNamed(
                    Routes.shops,
                    parameters: {
                      RoutesParamName.selectedCategoryName: title,
                    },
                  );
                }
              },
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
                borderRadius: BorderRadius.circular(16),
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
