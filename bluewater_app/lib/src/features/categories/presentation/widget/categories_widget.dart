import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../core/util/const.dart';
import '../../../../routes/app_pages.dart';
import '../../domain/entity/category.dart';
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
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () => Get.rootDelegate.toNamed(
                  Routes.shops,
                  parameters: {
                    RoutesParamName.selectedCategoryName:
                        controller.datas[index].name,
                    RoutesParamName.showCatagoryTab: true.toString(),
                  },
                ),
                child: CategoryItem<Category>(
                  item: controller.datas[index],
                  titleStyle: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            itemCount: controller.datas.length,
          );
        }
      },
    );
  }
}
