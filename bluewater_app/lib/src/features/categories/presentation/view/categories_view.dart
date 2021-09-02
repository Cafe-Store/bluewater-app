import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/categories_service.dart';
import '../widget/category_item.dart';

class CategoriesView extends GetView<CategoriesService> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: GridView.builder(
            itemCount: controller.datas.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) => CategoryItem(
              item: controller.datas[index],
              minWidth: 200,
              imageSize: Size(100, 100),
              badgeFontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
