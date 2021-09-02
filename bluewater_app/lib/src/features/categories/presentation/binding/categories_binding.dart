import 'package:get/get.dart';

import '../service/categories_service.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesService>(() => CategoriesService());
  }
}
