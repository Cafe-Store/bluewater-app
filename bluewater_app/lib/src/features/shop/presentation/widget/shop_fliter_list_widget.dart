import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/shop_filter.dart';
import '../controller/shop_controller.dart';
import 'shop_filter_bottom_sheet.dart';

part 'shop_filter_widget.dart';

class ShopFilterListWidget extends GetWidget<ShopController> {
  const ShopFilterListWidget({Key? key}) : super(key: key);

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
            () => _ShopFilterWidget(
              rxShopFilter: controller.shopFilters[index],
              textStyle: Theme.of(context).textTheme.bodyText1,
              tapCallback: () {
                var shopFilter = controller.shopFilters[index].value;
                if (!shopFilter.hasFilterItem()) {
                  controller.shopFilters[index].value.onDefaultTap();
                  controller.shopFilters[index].refresh();
                } else {
                  ShopFilterBottomSheet.show(
                      context, controller.shopFilters[index]);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
