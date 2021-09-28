import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../../routes/app_pages.dart';
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
                childAspectRatio: 0.9),
            itemBuilder: (context, index) => InkWell(
              onTap: () => Get.rootDelegate.toNamed(
                Routes.shops,
                parameters: {
                  RoutesParamName.selectedCategoryName:
                      controller.datas[index].name,
                  RoutesParamName.showCatagoryTab: true.toString(),
                },
              ),
              child: CategoryItem(
                item: controller.datas[index],
                imageSize: Size(100, 100),
                badgeFontSize: 15,
                titleStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
