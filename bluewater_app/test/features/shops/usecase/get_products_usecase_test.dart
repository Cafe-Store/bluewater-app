import 'package:bluewater_app/src/core/injector/injection.dart';
import 'package:bluewater_app/src/core/usecase/usecase.dart';
import 'package:bluewater_app/src/features/shops/domain/entity/product.dart';
import 'package:bluewater_app/src/features/shops/domain/usecase/get_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    configureInjection(Env.test);
  });

  test(
    'getProucts',
    () async {
      var _datas = <Product>[];
      var _failureMesage = '';
      var useCase = getIt<UseCase<List<Product>, ProductParam>>();
      final failureOrDatas = await useCase.execute(ProductParam(shopId: '1'));

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
      expect(_datas.length, 30);
      expect(_datas[0].groups[0].name, '패션');
    },
    timeout: Timeout(
      Duration(minutes: 3),
    ),
  );
}
