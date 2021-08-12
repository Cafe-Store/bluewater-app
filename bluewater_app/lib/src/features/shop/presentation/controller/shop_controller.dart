import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/injector/injection.dart';
import '../../domain/entity/shop.dart';
import '../../domain/repository/shop_repository.dart';
import '../../domain/entity/shop_filter.dart';

class ShopController extends GetxController {
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

  final ScrollController scroll = ScrollController();
  final ShopRepository _shopRepository = getIt<ShopRepository>();
  final _shops = <Shop>[].obs;
  final RxBool _isScrolled = false.obs;
  String _failureMesage = '';
  bool _reachedMax = false;

  @override
  onInit() {
    super.onInit();
    scroll.addListener(_listener);

    loadShops();
  }

  @override
  void onClose() {
    scroll.dispose();
  }

  void _listener() {
    _isScrolled(scroll.position.pixels > 0);

    if (_isBottom) {
      loadShops();
    }
  }

  bool get _isBottom {
    if (!scroll.hasClients) return false;
    final maxScroll = scroll.position.maxScrollExtent;
    final currentScroll = scroll.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  loadShops() async {
    if (!_reachedMax) {
      final failureOrShops = await _shopRepository.findAll();

      failureOrShops.fold((failure) => _failureMesage = failure.message,
          (loadedShops) {
        if (loadedShops.isEmpty) {
          _reachedMax = true;
        } else {
          _shops.addAll(loadedShops);
        }
      });
    }
  }

  List<Shop> get shops => List.unmodifiable(_shops);

  bool get hasReachedMax => _reachedMax;

  String get failureMesage => _failureMesage;

  bool get isScrolled => _isScrolled.value;
}
