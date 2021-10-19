import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/shop.dart';
import '../repository/shops_repository.dart';
import 'get_shops_usecase.dart';

@named
@LazySingleton(as: UseCase)
class GetStarShopsUsecase extends UseCase<List<Shop>, ShopsScrollParam> {
  final ShopsRepository shopsRepository;

  GetStarShopsUsecase(this.shopsRepository);

  @override
  Future<Either<Failure, List<Shop>>> execute(ShopsScrollParam params) {
    return shopsRepository.findAllRankingShops();
  }
}
