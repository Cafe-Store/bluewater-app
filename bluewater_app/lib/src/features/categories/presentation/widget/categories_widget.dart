import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/util/const.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/ui/color/shimmer_color.dart';
import '../../domain/entity/category.dart';
import '../service/categories_service.dart';
import 'category_item.dart';

class CategoriesWidget extends GetView<CategoriesService> {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ListView.separated(
          separatorBuilder: (context, index) => Divider(
            indent: Get.width / 20,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: controller.datas.isNotEmpty
                ? _createCategoryItem(index, context)
                : Shimmer.fromColors(
                    baseColor: ShimmerColor.baseColor,
                    highlightColor: ShimmerColor.highlightColor,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
          ),
          itemCount: controller.datas.isNotEmpty ? controller.datas.length : 10,
        );
      },
    );
  }

  InkWell _createCategoryItem(int index, BuildContext context) {
    return InkWell(
      onTap: () => Get.rootDelegate.toNamed(
        Routes.shops,
        parameters: {
          RoutesParamName.selectedCategoryName: controller.datas[index].name,
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
    );
  }
}
