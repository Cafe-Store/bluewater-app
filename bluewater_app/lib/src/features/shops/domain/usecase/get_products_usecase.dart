import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/product.dart';
import '../repository/product_repository.dart';

@LazySingleton(as: UseCase)
class GetProductesUsecase extends UseCase<Product, ProductParam> {
  final ProductRepository productRepository;

  GetProductesUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> execute(ProductParam param) {
    return productRepository.findAllProducts(param.shopId);
  }
}

class ProductParam {
  final String shopId;

  ProductParam({required this.shopId});
}
