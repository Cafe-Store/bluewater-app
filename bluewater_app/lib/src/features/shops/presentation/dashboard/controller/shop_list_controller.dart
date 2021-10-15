import 'package:get/get.dart';

import '../../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../../domain/entity/shop.dart';

class ShopListController<Param extends ScrollParam> extends GetxController
    with InfiniteScrollMixin<Shop, Param> {
  final Param param;
  String? usecaeClassName;

  ShopListController({required this.param, this.usecaeClassName});

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  Param get scrollParam => param;

  @override
  String? get usecaeName => usecaeClassName;
}
