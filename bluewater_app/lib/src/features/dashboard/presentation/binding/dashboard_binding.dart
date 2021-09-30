import 'package:get/get.dart';

import '../../serivce/dashboard_service.dart';
import '../controller/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<DashboardService>(() => DashboardService());
  }
}
