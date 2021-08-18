import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/shop.dart';
import '../repository/shop_repository.dart';

@lazySingleton
class GetShopsUsecase extends UseCase<Shop, NoParams> {
  final ShopRepository shopRepository;

  GetShopsUsecase(this.shopRepository);

  @override
  Future<Either<Failure, List<Shop>>> execute(NoParams params) {
    return shopRepository.findAll();
  }
}
