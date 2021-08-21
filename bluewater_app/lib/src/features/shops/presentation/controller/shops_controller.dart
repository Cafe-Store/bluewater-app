import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/logger/logger_utils.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecase/get_shops_usecase.dart';
import '../../../../core/injector/injection.dart';
import '../../domain/entity/shop.dart';
import '../../domain/entity/shop_filter.dart';

class ShopsController extends GetxController {
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

  late ScrollController _scroll;
  final GetShopsUsecase _getShopsUsecase = getIt<GetShopsUsecase>();

  final _shops = <Shop>[].obs;
  final RxBool _isScrolled = false.obs;
  String _failureMesage = '';
  bool _reachedMax = false;

  @override
  onInit() {
    super.onInit();
    loadShops();
  }

  void _listener() {
    _isScrolled(_scroll.position.pixels > 0);

    if (_isBottom) {
      loadShops();
    }
  }

  bool get _isBottom {
    if (!_scroll.hasClients) return false;
    final maxScroll = _scroll.position.maxScrollExtent;
    final currentScroll = _scroll.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  loadShops() async {
    if (!_reachedMax) {
      final failureOrShops = await _getShopsUsecase.execute(NoParams());

      failureOrShops.fold((failure) => _failureMesage = failure.message,
          (loadedShops) {
        if (loadedShops.isEmpty && _failureMesage.isEmpty) {
          _reachedMax = true;
        } else {
          _shops.addAll(loadedShops.getRange(0, 5));
          Logger.logNoStack.i('shop data size : ${_shops.length}');
        }
      });
    }
  }

  List<Shop> get shops => List.unmodifiable(_shops);

  bool get hasReachedMax => _reachedMax;

  String get failureMesage => _failureMesage;

  bool get isScrolled => _isScrolled.value;

  set scroll(ScrollController scroll) {
    _scroll = scroll;
    _scroll.addListener(_listener);
  }

  ScrollController get scroll => _scroll;
}
