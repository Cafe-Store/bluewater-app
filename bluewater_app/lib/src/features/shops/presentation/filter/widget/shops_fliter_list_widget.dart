import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/shop_filter.dart';
import '../controller/shops_filter_controller.dart';
import 'shops_filter_bottom_sheet.dart';

part 'shops_filter_widget.dart';

class ShopsFilterListWidget extends GetWidget<ShopsFilterController> {
  @override
  final String? tag;

  const ShopsFilterListWidget({this.tag, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 30, maxWidth: MediaQuery.of(context).size.width),
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          endIndent: MediaQuery.of(context).size.width / 20,
        ),
        itemCount: controller.shopFilters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Obx(
            () {
              var shopFilter = controller.shopFilters[index];
              return _ShopsFilterWidget(
                name: controller.getSelectedItemName(shopFilter.name),
                textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: controller.isSelected(shopFilter)
                        ? Colors.white
                        : Colors.black),
                backgroundColor: controller.isSelected(shopFilter)
                    ? Colors.blue
                    : Colors.white,
                borderColor: controller.isSelected(shopFilter)
                    ? Colors.blue
                    : Colors.black,
                leadingIcon: shopFilter.leadingIcon,
                trailingIcon: shopFilter.trailingIcon,
                tapCallback: () {
                  if (ShopFilterType.none == shopFilter.filterType) {
                    if (controller.isSelected(shopFilter)) {
                      controller.remove(shopFilter.name);
                    } else {
                      controller.put(
                          shopFilter.name, shopFilter.filterItems[0]);
                    }
                  } else {
                    ShopsFilterBottomSheet.show(context, shopFilter, tag);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
