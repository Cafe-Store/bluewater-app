import 'package:get/get.dart';

import '../../../../../core/logger/logger_utils.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../../routes/app_pages.dart';
import '../../../domain/entity/product.dart';
import '../../../domain/entity/shop.dart';
import '../../../domain/usecase/get_products_usecase.dart';
import '../../../domain/usecase/get_shop_details_usecase.dart';

class ShopDetailsController extends GetxController {
  final String shopId;
  final Object? startRouteName;
  final UseCase<List<Product>, ProductParam> getProductsUsecase;
  final UseCase<Shop, ShopDetailsParam> getShopDetailsUsecase;

  final productsfailureMesage = ''.obs;
  final shopDetailsfailureMesage = ''.obs;
  final products = <Product>[].obs;
  final shop = Shop.empty().obs;
  final currentIdex = 1.obs;

  ShopDetailsController({
    required this.getProductsUsecase,
    required this.getShopDetailsUsecase,
    required this.shopId,
    this.startRouteName,
  });

  @override
  void onInit() {
    super.onInit();
    Get.log('created with id: $shopId and startRouteName = $startRouteName');

    _loadDatas(shopId);
  }

  void _loadDatas(String shopId) {
    _loadShopDetails(shopId);
    _loadProducts(shopId);
  }

  void _loadShopDetails(String shopId) async {
    var failureOrDatas =
        await getShopDetailsUsecase.execute(ShopDetailsParam(shopId: shopId));

    failureOrDatas.fold(
      (failure) => shopDetailsfailureMesage(failure.message),
      (loadedData) {
        Logger.logNoStack.i('${toString()}:$hashCode data loaded');
        shop(loadedData);
      },
    );
  }

  bool get isLoadedShop => Shop.empty() != shop.value;

  bool get hasReview => shop.value.rank.count > 0;

  void _loadProducts(String shopId) async {
    var failureOrDatas =
        await getProductsUsecase.execute(ProductParam(shopId: shopId));

    failureOrDatas.fold(
      (failure) => productsfailureMesage(failure.message),
      (loadedDatas) {
        if (loadedDatas.isEmpty && productsfailureMesage.isEmpty) {
          Logger.logNoStack.i('data empty');
        } else {
          Logger.logNoStack.i('${toString()}:$hashCode data loaded');
          products.addAll(loadedDatas);
        }
      },
    );
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
