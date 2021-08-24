import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../domain/entity/category.dart';
import '../controller/categories_controller.dart';

class CategoriesWidget extends GetWidget<CategoriesController> {
  @override
  Widget build(BuildContext context) {
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
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                _CategoryItem(item: controller.datas[index]),
            itemCount: controller.datas.length,
          );
        }
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category item;
  const _CategoryItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      constraints: BoxConstraints(maxWidth: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: item.imageUri,
            imageBuilder: (context, imageProvider) => Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Spacer(),
          Text(
            item.name,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
