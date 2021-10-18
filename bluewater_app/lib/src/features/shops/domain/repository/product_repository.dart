import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> findAllProducts(String id);
}
