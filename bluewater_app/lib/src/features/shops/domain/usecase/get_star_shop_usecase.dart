import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/shop.dart';
import '../repository/shops_repository.dart';

@lazySingleton
class GetStarShopsUsecase extends UseCase<Shop, ScrollParam> {
  final ShopsRepository shopsRepository;

  GetStarShopsUsecase(this.shopsRepository);

  @override
  Future<Either<Failure, List<Shop>>> execute(ScrollParam params) {
    return shopsRepository.findAllRankingShops();
  }
}

class ShopsScrollParam extends ScrollParam {
  @override
  List<Object?> get props => [];
}
