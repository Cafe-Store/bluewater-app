import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/shop.dart';

abstract class ShopsRepository {
  Future<Either<Failure, List<Shop>>> findAll();

  Future<Either<Failure, List<Shop>>> findAllRankingShops();

  Future<Either<Failure, List<Shop>>> findAllCategorizedShops(String code);
  Future<Either<Failure, Shop>> findShop(String id);
}
