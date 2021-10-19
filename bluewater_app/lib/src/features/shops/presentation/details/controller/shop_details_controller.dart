import 'package:get/get.dart';

import '../../../../../core/logger/logger_utils.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../routes/app_pages.dart';
import '../../../domain/entity/product.dart';
import '../../../domain/usecase/get_products_usecase.dart';

class ShopDetailsController extends GetxController {
  final String shopId;
  final Object? startRouteName;
  final UseCase<List<Product>, ProductParam> usecase;

  final failureMesage = ''.obs;
  final products = <Product>[].obs;

  ShopDetailsController({
    required this.usecase,
    required this.shopId,
    this.startRouteName,
  });

  @override
  void onInit() {
    super.onInit();
    _loadDatas(shopId);
    Get.log('created with id: $shopId and startRouteName = $startRouteName');
  }

  void _loadDatas(String shopId) async {
    var failureOrDatas = await usecase.execute(ProductParam(shopId: shopId));

    failureOrDatas.fold((failure) => failureMesage(failure.message),
        (loadedDatas) {
      if (loadedDatas.isEmpty && failureMesage.isEmpty) {
        Logger.logNoStack.i('data empty');
      } else {
        Logger.logNoStack.i('${toString()}:$hashCode data loaded');
        products.addAll(loadedDatas);
      }
    });
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
