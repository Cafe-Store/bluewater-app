import 'package:get/get.dart';

import '../../../../../routes/app_pages.dart';

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

    //home에 있는 가게 목록에서 가게 상세화면으로 이동 후, 백버튼(AOS) 눌러서 돌아올 때를 위해 코드를 추가함.
    if (startRouteName != null &&
        Routes.shops == Get.rootDelegate.currentConfiguration!.location) {
      Get.rootDelegate
          .backUntil(startRouteName.toString(), popMode: PopMode.History);
    }
  }
}
