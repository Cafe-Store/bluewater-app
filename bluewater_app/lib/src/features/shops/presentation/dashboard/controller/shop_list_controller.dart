import 'package:get/get.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../../domain/entity/shop.dart';

class ShopListController<Param extends ScrollParam,
        U extends UseCase<Shop, Param>> extends GetxController
    with InfiniteScrollMixin<Shop, Param, U> {
  final Param param;

  ShopListController({required this.param});

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  Param get scrollParam => param;
}
