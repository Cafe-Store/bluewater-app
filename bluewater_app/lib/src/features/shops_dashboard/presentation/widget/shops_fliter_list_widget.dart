import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/shop_filter.dart';
import '../controller/shops_dashboard_controller.dart';
import 'shops_filter_bottom_sheet.dart';

part 'shops_filter_widget.dart';

class ShopsFilterListWidget extends StatelessWidget {
  final ShopsDashboardController controller;

  const ShopsFilterListWidget({required this.controller, Key? key})
      : super(key: key);

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
            () => _ShopsFilterWidget(
              rxShopFilter: controller.shopFilters[index],
              textStyle: Theme.of(context).textTheme.bodyText1,
              tapCallback: () {
                var shopFilter = controller.shopFilters[index].value;
                if (!shopFilter.hasFilterItem()) {
                  controller.shopFilters[index].value.onDefaultTap();
                  controller.shopFilters[index].refresh();
                } else {
                  ShopsFilterBottomSheet.show(
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
