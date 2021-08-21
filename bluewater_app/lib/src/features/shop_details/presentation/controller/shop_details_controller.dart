import 'package:get/get.dart';

class ShopDetailsController extends GetxController {
  final String shopId;

  ShopDetailsController(this.shopId);

  @override
  void onInit() {
    super.onInit();
    Get.log('ShopDetailController created with id: $shopId');
  }

  @override
  void onClose() {
    Get.log('ShopDetailController close with id: $shopId');
    super.onClose();
  }
}
