import 'package:bluewater_app/src/core/injector/injection.dart';
import 'package:bluewater_app/src/core/usecase/usecase.dart';
import 'package:bluewater_app/src/features/shops/domain/entity/shop.dart';
import 'package:bluewater_app/src/features/shops/domain/usecase/get_shop_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    configureInjection(Env.test);
  });

  test(
    'getProucts',
    () async {
      var _data;
      var _failureMesage = '';
      var useCase = getIt<UseCase<Shop, ShopDetailsParam>>();
      final failureOrDatas =
          await useCase.execute(ShopDetailsParam(shopId: '1'));

      failureOrDatas.fold((failure) => _failureMesage = failure.message,
          (loadedData) {
        _data = loadedData;
      });

      expect(_data != null, true);
      expect(_failureMesage.isEmpty, true);
    },
    timeout: Timeout(
      Duration(minutes: 3),
    ),
  );
}
