import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/shop.dart';
import '../repository/shops_repository.dart';

@lazySingleton
class GetShopsUsecase extends UseCase<Shop, ScrollParam> {
  final ShopsRepository shopsRepository;

  GetShopsUsecase(this.shopsRepository);

  @override
  Future<Either<Failure, List<Shop>>> execute(ScrollParam params) {
    return shopsRepository.findAll();
  }
}

class ShopsScrollParam extends ScrollParam {
  @override
  List<Object?> get props => [];
}
