import 'package:get/get.dart';

import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../domain/entity/category.dart';
import '../../domain/usecase/get_categories_usecase.dart';

class CategoriesService extends GetxService
    with InfiniteScrollMixin<Category, CategoriesScrollParam> {
  String? usecaeClassName;

  CategoriesService({this.usecaeClassName});

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  CategoriesScrollParam get scrollParam => CategoriesScrollParam();

  @override
  String? get usecaeName => usecaeClassName;
}
