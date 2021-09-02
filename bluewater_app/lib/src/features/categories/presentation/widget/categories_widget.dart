import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../service/categories_service.dart';
import 'category_item.dart';

class CategoriesWidget extends GetView<CategoriesService> {
  const CategoriesWidget({Key? key}) : super(key: key);

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
                CategoryItem(item: controller.datas[index]),
            itemCount: controller.datas.length,
          );
        }
      },
    );
  }
}
