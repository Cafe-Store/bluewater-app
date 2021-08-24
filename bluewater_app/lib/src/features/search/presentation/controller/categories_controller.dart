import 'package:get/get.dart';

import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../domain/entity/category.dart';
import '../../domain/usecase/get_categories_usecase.dart';

class CategoriesController extends GetxController
    with InfiniteScrollMixin<Category, GetCategoriesUsecase> {
  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  ScrollParam get scrollParam => CategoriesScrollParam();
}
