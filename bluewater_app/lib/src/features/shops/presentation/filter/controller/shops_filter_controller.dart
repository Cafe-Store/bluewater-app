import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/shop_filter.dart';

class ShopsFilterController extends GetxController {
  final shopFilters = [
    ShopFilter(
      filterType: ShopFilterType.list,
      name: '매장 정렬',
      filterItems: const [
        ShopFilterItem('추천순'),
        ShopFilterItem('주문많은순'),
        ShopFilterItem('가까운순'),
        ShopFilterItem('신규매장순'),
      ],
      trailingIcon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.amber,
      ),
    ),
    ShopFilter(
      filterType: ShopFilterType.none,
      name: '할인쿠폰',
      filterItems: const [
        ShopFilterItem('할인쿠폰'),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();

    for (var element in shopFilters) {
      if (ShopFilterType.none != element.filterType) {
        _selectedFilters.putIfAbsent(
            element.name, () => element.filterItems[0]);
      }
    }
  }

  final Map<String, ShopFilterItem> _selectedFilters =
      <String, ShopFilterItem>{}.obs;

  void put(String filterName, ShopFilterItem item) {
    _selectedFilters.update(filterName, (value) => item, ifAbsent: () => item);
    ;
  }

  void remove(String filterName) => _selectedFilters.remove(filterName);

  bool isSelected(ShopFilter shopFilter) {
    var selectedFilter = _selectedFilters[shopFilter.name];

    return selectedFilter != null &&
        (ShopFilterType.none == shopFilter.filterType ||
            shopFilter.filterItems[0] != selectedFilter);
  }

  String getSelectedItemName(String filterName) {
    var selectedFilter = _selectedFilters[filterName];
    return selectedFilter != null ? selectedFilter.name : filterName;
  }
}
