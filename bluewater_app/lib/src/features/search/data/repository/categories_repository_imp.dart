import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/category.dart';
import '../../domain/repository/categories_repository.dart';
import '../datasource/categories_remote_datasource.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImp implements CategoriesRepository {
  final CategoriesRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  CategoriesRepositoryImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Category>>> findAll() async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findAll());
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
