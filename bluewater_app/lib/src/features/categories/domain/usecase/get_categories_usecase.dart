import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/category.dart';
import '../repository/categories_repository.dart';

@lazySingleton
class GetCategoriesUsecase extends UseCase<Category, ScrollParam> {
  final CategoriesRepository categoryRepository;

  GetCategoriesUsecase(this.categoryRepository);

  @override
  Future<Either<Failure, List<Category>>> execute(ScrollParam params) {
    return categoryRepository.findAll();
  }
}

class CategoriesScrollParam extends ScrollParam {
  @override
  List<Object?> get props => [];
}
