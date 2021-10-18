import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/product_model.dart';

part 'product_remote_data_source.g.dart';

@injectable
@RestApi()
abstract class ProudctRemoteDataSource {
  @factoryMethod
  factory ProudctRemoteDataSource(Dio dio) = _ProudctRemoteDataSource;

  @GET('/shops/{id}/products')
  Future<List<ProductModel>> findAllProducts(@Path("id") String id);
}
