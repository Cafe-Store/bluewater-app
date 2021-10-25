import 'package:bluewater_app/src/core/injector/injection.dart';
import 'package:bluewater_app/src/core/usecase/usecase.dart';
import 'package:bluewater_app/src/features/shops/domain/entity/shop.dart';
import 'package:bluewater_app/src/features/shops/domain/usecase/get_shops_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    configureInjection(Env.test);
  });

  test(
    'getShops',
    () async {
      var _datas = <Shop>[];
      var _failureMesage = '';
      var useCase = getIt<UseCase<List<Shop>, ShopsScrollParam>>(
          instanceName: "GetShopsUsecase");
      final failureOrDatas = await useCase.execute(ShopsScrollParam());

      failureOrDatas.fold(
        (failure) => _failureMesage = failure.message,
        (loadedDatas) {
          if (loadedDatas.isEmpty && _failureMesage.isEmpty) {
            print('data empty');
          } else {
            _datas.addAll(loadedDatas);
          }
        },
      );

      expect(_datas.isNotEmpty, true);
      expect(_datas.length, 7);
      expect(_datas[0].photos.isNotEmpty, true);
    },
    timeout: Timeout(
      Duration(minutes: 3),
    ),
  );
}
