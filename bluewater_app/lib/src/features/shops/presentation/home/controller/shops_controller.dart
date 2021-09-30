import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/util/const.dart';
import '../../../../../shared/ui/controller/tab_controll_mixin.dart';
import '../../../../categories/domain/entity/category.dart';
import '../../../../categories/presentation/service/categories_service.dart';
import '../../dashboard/controller/shop_list_controller.dart';
import '../../filter/controller/shops_filter_controller.dart';

class ShopsController extends GetxController with TabControllMixin {
  final List<ShopListController> shopListControllers = [];
  final PageStorageBucket pageStorageBucket = PageStorageBucket();

  late final bool showCategoryTab;
  late final RxString _title;
  late final List<Category> categoris;
  late final Map<int, Category> _categoryMap;
  late final ShopsFilterController shopsFilterController;

  ShopsController() {
    categoris = Get.find<CategoriesService>().datas.toList();
    _categoryMap = categoris.asMap();

    var getPage = Get.rootDelegate.currentConfiguration!.currentPage!;
    var getParameters = getPage.parameters;
    var categoryName = getParameters?[RoutesParamName.selectedCategoryName];

    showCategoryTab = getParameters?[RoutesParamName.showCatagoryTab] != null &&
        getParameters?[RoutesParamName.showCatagoryTab] == true.toString();
    _title = (categoryName ?? '').obs;
  }

  @override
  void onInit() {
    super.onInit();

    if (_title.value.isNotEmpty) {
      _initTabIndex();
      _initShopListController();
      _initShopsFilterController();
    }
  }

  void _initShopsFilterController() {
    Get.lazyPut<ShopsFilterController>(() => ShopsFilterController());
    shopsFilterController = Get.find<ShopsFilterController>();
  }

  void _initShopListController() {
    if (showCategoryTab) {
      for (var category in categoris) {
        Get.put<ShopListController>(
          ShopListController(tag: category.name),
          tag: category.name,
        );

        shopListControllers
            .add(Get.find<ShopListController>(tag: category.name));
      }
    } else {
      Get.put<ShopListController>(
        ShopListController(),
        tag: _title.value,
      );

      shopListControllers.add(Get.find<ShopListController>(tag: _title.value));
    }
  }

  void _initTabIndex() {
    currentIndex(math.max(
        0, categoris.indexWhere((element) => element.name == _title.value)));
  }

  @override
  void onClose() {
    if (_title.value.isNotEmpty) {
      _deleteShopListController();
    }
    super.onClose();
  }

  void _deleteShopListController() {
    if (showCategoryTab) {
      for (var category in categoris) {
        Get.delete<ShopListController>(tag: category.name, force: true);
      }
    } else {
      Get.delete<ShopListController>(tag: _title.value, force: true);
    }
  }

  String get title => _title.value;

  @override
  void changedTab() {
    _title(_categoryMap[tabIndex]?.name);

    shopListControllers.asMap().forEach((index, controller) {
      controller.setFocus = index == tabIndex;
    });
  }
}
