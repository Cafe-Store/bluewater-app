import 'package:get/get.dart';

import '../controller/shops_dashboard_controller.dart';

class ShopsDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopsDashboardController>(() => ShopsDashboardController());
  }
}
