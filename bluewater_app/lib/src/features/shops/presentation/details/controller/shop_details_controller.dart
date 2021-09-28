import 'package:get/get.dart';

class ShopDetailsController extends GetxController {
  final String shopId;
  final Object? startRouteName;

  ShopDetailsController({required this.shopId, this.startRouteName});

  @override
  void onInit() {
    super.onInit();
    Get.log('created with id: $shopId and startRouteName = $startRouteName');
  }

  @override
  void onClose() {
    Get.log('ShopDetailController close with id: $shopId');
    super.onClose();
  }
}
