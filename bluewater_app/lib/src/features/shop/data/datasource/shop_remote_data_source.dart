import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/injector/injection.dart';
import '../model/shop_model.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> findAll();
}

@LazySingleton(as: ShopRemoteDataSource, env: [Env.dev, Env.test])
class MockShopRemoteDataSourceImp implements ShopRemoteDataSource {
  final Dio client;
  int index = 0;
  MockShopRemoteDataSourceImp({required this.client});

  @override
  Future<List<ShopModel>> findAll() {
    return Future.delayed(const Duration(seconds: 1))
        .then((onValue) => _createMock());
  }

  List<ShopModel> _createMock() {
    List<ShopModel> shopModels = [];
    for (int i = 20 * index; i < 20 * (index + 1); i++) {
      shopModels.add(ShopModel(
          id: i,
          name: 'shop$i',
          imageUrls: const [
            'https://p0.piqsels.com/preview/136/172/955/assorted-foods-on-table.jpg'
          ],
          rank: 0.0));
    }

    index++;

    return shopModels;
  }
}
