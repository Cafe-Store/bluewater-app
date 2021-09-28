import 'package:get/get.dart';

import '../controller/shops_controller.dart';

class ShopsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShopsController>(ShopsController());
  }
}
