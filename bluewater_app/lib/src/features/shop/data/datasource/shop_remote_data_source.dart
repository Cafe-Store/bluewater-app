import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/shop_model.dart';

part 'shop_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class ShopRemoteDataSource {
  @factoryMethod
  factory ShopRemoteDataSource(Dio dio) = _ShopRemoteDataSource;

  @GET('/shops')
  Future<List<ShopModel>> findAll();
}
