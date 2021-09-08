import 'package:get/get.dart';

import '../../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../../domain/entity/shop.dart';
import '../../../domain/usecase/get_shops_usecase.dart';

class CategorizedShopsController extends GetxController
    with InfiniteScrollMixin<Shop, GetShopsUsecase> {
  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  ScrollParam get scrollParam => ShopsScrollParam();
}
