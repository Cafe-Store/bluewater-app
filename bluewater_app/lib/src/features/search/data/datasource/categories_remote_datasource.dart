import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/category_model.dart';

part 'categories_remote_datasource.g.dart';

@injectable
@RestApi()
abstract class CategoriesRemoteDataSource {
  @factoryMethod
  factory CategoriesRemoteDataSource(Dio dio) = _CategoriesRemoteDataSource;

  @GET('/search')
  Future<List<CategoryModel>> findAll();
}
