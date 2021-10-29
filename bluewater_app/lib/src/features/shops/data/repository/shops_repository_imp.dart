import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/shop.dart';
import '../../domain/repository/shops_repository.dart';
import '../datasource/shops_remote_data_source.dart';

@LazySingleton(as: ShopsRepository)
class ShopsRepositoryImp implements ShopsRepository {
  final ShopsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ShopsRepositoryImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Shop>>> findAll() async {
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

  @override
  Future<Either<Failure, List<Shop>>> findAllRankingShops() async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findAllRankingShops());
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Shop>>> findAllCategorizedShops(
      String code) async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findAllCategorizedShops(code));
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Shop>> findShop(String id) async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findShop(id));
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
