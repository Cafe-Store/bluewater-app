import 'package:get/get.dart';

import '../../../../../core/injector/injection.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entity/product.dart';
import '../../../domain/entity/shop.dart';
import '../../../domain/usecase/get_products_usecase.dart';
import '../../../domain/usecase/get_shop_details_usecase.dart';
import '../controller/shop_details_controller.dart';

class ShopDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopDetailsController>(() => ShopDetailsController(
          getShopDetailsUsecase: getIt<UseCase<Shop, ShopDetailsParam>>(),
          getProductsUsecase: getIt<UseCase<List<Product>, ProductParam>>(),
          shopId: Get.parameters['shopId'] ?? '',
          startRouteName:
              Get.rootDelegate.currentConfiguration!.currentPage!.arguments,
        ));
  }
}
