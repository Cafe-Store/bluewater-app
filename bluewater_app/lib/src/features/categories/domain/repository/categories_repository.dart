import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/category.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, List<Category>>> findAll();
}
