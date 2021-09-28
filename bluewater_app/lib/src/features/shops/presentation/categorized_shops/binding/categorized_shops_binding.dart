import 'package:get/get.dart';

import '../controller/categorized_shops_controller.dart';

class CategorizedShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategorizedShopsController>(() => CategorizedShopsController());
  }
}
