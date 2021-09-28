import 'package:get/get.dart';

import '../controller/shop_details_controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopDetailsController>(() => ShopDetailsController(
          shopId: Get.parameters['shopId'] ?? '',
          startRouteName:
              Get.rootDelegate.currentConfiguration!.currentPage!.arguments,
        ));
  }
}
