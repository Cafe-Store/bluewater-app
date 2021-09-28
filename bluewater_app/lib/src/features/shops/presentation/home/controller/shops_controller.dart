import 'dart:math' as math;

import 'package:get/get.dart';

import '../../../../../core/util/const.dart';
import '../../../../../shared/ui/controller/tab_controll_mixin.dart';
import '../../../../categories/domain/entity/category.dart';
import '../../../../categories/presentation/service/categories_service.dart';
import '../../dashboard/controller/shop_list_controller.dart';

class ShopsController extends GetxController with TabControllMixin {
  late final bool showCategoryTab;
  late final RxString _title;
  late final List<Category> categoris;
  late final Map<int, Category> _categoryMap;
  final List<ShopListController> shopListControllers = [];

  ShopsController() {
    categoris = Get.find<CategoriesService>().datas;
    _categoryMap = categoris.asMap();

    var getPage = Get.rootDelegate.currentConfiguration!.currentPage!;
    var getParameters = getPage.parameters;

    showCategoryTab = getParameters?[RoutesParamName.showCatagoryTab] != null &&
        getParameters?[RoutesParamName.showCatagoryTab] == true.toString();
    _title = (getParameters?[RoutesParamName.selectedCategoryName] ??
            categoris[0].name)
        .obs;
  }

  @override
  void onInit() {
    super.onInit();

    _initTabIndex();
    _createShopListController();
  }

  void _createShopListController() {
    if (showCategoryTab) {
      for (var category in categoris) {
        Get.lazyPut<ShopListController>(
          () => ShopListController(tag: category.name),
          tag: category.name,
        );

        shopListControllers
            .add(Get.find<ShopListController>(tag: category.name));
      }
    } else {
      Get.create<ShopListController>(
        () => ShopListController(),
      );
    }
  }

  void _initTabIndex() {
    currentIndex(math.max(
        0, categoris.indexWhere((element) => element.name == _title.value)));
  }

  @override
  void onClose() {
    _deleteShopListController();
    super.onClose();
  }

  void _deleteShopListController() {
    if (showCategoryTab) {
      for (var category in categoris) {
        Get.delete<ShopListController>(tag: category.name, force: true);
      }
    } else {
      Get.delete<ShopListController>(force: true);
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
