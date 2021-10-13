import 'package:get/get.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../../domain/entity/shop.dart';
import '../../../domain/usecase/get_shops_usecase.dart';

class CategorizedShopsController<U extends UseCase<Shop, ScrollParam>>
    extends GetxController with InfiniteScrollMixin<Shop, U> {
  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  ScrollParam get scrollParam => ShopsScrollParam();
}
