import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../domain/entity/shop.dart';
import '../../domain/entity/shop_filter.dart';
import '../../domain/usecase/get_shops_usecase.dart';

class ShopsDashboardController extends GetxController
    with InfiniteScrollMixin<Shop, GetShopsUsecase> {
  final shopFilters = [
    ShopFilter(
      widgetType: WidgetType.list,
      name: '매장 정렬',
      filterItems: const [
        ShopFilterItem('추천순'),
        ShopFilterItem('주문많은순'),
        ShopFilterItem('가까운순'),
        ShopFilterItem('신규매장순'),
      ],
      trailing: const Icon(
        Icons.arrow_drop_down,
        color: Colors.amber,
      ),
    ).obs,
    ShopFilter(
      widgetType: WidgetType.none,
      name: '할인쿠폰',
      filterItems: const [
        ShopFilterItem.defaultItem,
        ShopFilterItem('할인쿠폰'),
      ],
    ).obs,
  ];

  ShopsDashboardController({tag});

  String? tag;

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  ScrollParam get scrollParam => ShopsScrollParam();
}
