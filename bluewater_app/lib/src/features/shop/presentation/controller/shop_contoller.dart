import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entity/shop_filter.dart';

class ShopController extends GetxController {
  List<ShopFilter> shopFilters = [
    ShopFilter('추천순aaaaaaaaa aaaa',
        trailing: const Icon(
          Icons.arrow_drop_down,
          color: Colors.amber,
        )),
    ShopFilter(
      '최소주문',
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.amber),
    ),
    ShopFilter('할인쿠폰')
  ];
}
