import 'package:get/get.dart';

import '../controller/categories_controller.dart';

class CategroiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(() => CategoriesController());
  }
}
