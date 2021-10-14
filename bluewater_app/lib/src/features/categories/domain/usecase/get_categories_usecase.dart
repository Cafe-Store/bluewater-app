import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/category.dart';
import '../repository/categories_repository.dart';

@lazySingleton
class GetCategoriesUsecase extends UseCase<Category, CategoriesScrollParam> {
  final CategoriesRepository categoryRepository;

  GetCategoriesUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, List<Category>>> execute(
      CategoriesScrollParam params) {
    return categoryRepository.findAll();
  }
}

class CategoriesScrollParam extends ScrollParam {
  @override
  int page = 0;
}
