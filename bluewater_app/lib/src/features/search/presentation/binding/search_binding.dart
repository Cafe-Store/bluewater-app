import 'package:get/get.dart';

import '../controller/categories_controller.dart';
import '../controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
