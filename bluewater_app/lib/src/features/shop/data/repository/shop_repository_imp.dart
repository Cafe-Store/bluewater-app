import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasource/shop_remote_data_source.dart';
import '../../domain/entity/shop.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/shop_repository.dart';

@LazySingleton(as: ShopRepository)
class ShopRepositoryImp implements ShopRepository {
  final ShopRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ShopRepositoryImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Shop>>> findAll() async {
    List<Shop> shops = [];
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        shops = await remoteDataSource.findAll();
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Right(shops);
  }
}
