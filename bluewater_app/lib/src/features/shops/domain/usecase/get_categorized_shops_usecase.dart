import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/logger/logger_utils.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/shop.dart';
import '../repository/shops_repository.dart';

@LazySingleton(as: UseCase)
class GetCategorizedShopsUsecase
    extends UseCase<List<Shop>, CategorizedShopsScrollParam> {
  final ShopsRepository shopsRepository;

  GetCategorizedShopsUsecase(this.shopsRepository);

  @override
  Future<Either<Failure, List<Shop>>> execute(
      CategorizedShopsScrollParam params) {
    Logger.logNoStack.i('category code param ${params.code}');
    return shopsRepository.findAllCategorizedShops(params.code);
  }
}

class CategorizedShopsScrollParam extends ScrollParam {
  final String code;

  @override
  int page = 0;

  CategorizedShopsScrollParam({required this.code});
}
