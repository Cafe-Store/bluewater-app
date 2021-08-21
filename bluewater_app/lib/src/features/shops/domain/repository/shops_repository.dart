import 'package:dartz/dartz.dart';

import '../entity/shop.dart';
import '../../../../core/error/failures.dart';

abstract class ShopsRepository {
  Future<Either<Failure, List<Shop>>> findAll();
}
