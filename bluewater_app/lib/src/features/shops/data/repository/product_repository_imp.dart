import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/product.dart';
import '../../domain/repository/product_repository.dart';
import '../datasource/product_remote_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImp extends ProductRepository {
  final NetworkInfo networkInfo;
  final ProudctRemoteDataSource remoteDataSource;

  ProductRepositoryImp(this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> findAllProducts(String id) async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findAllProducts(id));
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
