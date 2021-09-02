import 'package:get/get.dart';

import '../controller/shop_details_controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<ShopDetailsController>(() => ShopDetailsController(
          shopId: Get.parameters['shopId'] ?? '',
          tag: Get.arguments ?? '',
        ));
  }
}
