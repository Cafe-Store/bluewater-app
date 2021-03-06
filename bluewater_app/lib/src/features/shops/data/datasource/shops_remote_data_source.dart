import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/shop_model.dart';

part 'shops_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class ShopsRemoteDataSource {
  @factoryMethod
  factory ShopsRemoteDataSource(Dio dio) = _ShopsRemoteDataSource;

  @GET('/shops')
  Future<List<ShopModel>> findAll();

  @GET('/shops/ranking')
  Future<List<ShopModel>> findAllRankingShops();

  @GET('/shops/category')
  Future<List<ShopModel>> findAllCategorizedShops(
    @Query("code") String code,
  );

  @GET('/shops/{id}')
  Future<ShopModel> findShop(
    @Path('id') String id,
  );
}
