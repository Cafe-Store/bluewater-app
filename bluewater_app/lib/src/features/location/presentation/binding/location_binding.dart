import 'package:get/get.dart';
import '../service/location_service.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
  }
}
