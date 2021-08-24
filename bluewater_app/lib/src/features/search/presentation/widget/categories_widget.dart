import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/categories_controller.dart';
import 'category_item.dart';

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
                CategoryItem(item: controller.datas[index]),
            itemCount: controller.datas.length,
          );
        }
      },
    );
  }
}
