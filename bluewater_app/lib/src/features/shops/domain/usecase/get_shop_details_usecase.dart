import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/shop.dart';
import '../repository/shops_repository.dart';

@LazySingleton(as: UseCase)
class GetShopDetailsUsecase extends UseCase<Shop, ShopDetailsParam> {
  final ShopsRepository shopsRepository;

  GetShopDetailsUsecase(this.shopsRepository);

  @override
  Future<Either<Failure, Shop>> execute(ShopDetailsParam params) {
    return shopsRepository.findShop(params.shopId);
  }
}

class ShopDetailsParam extends Equatable {
  final String shopId;

  ShopDetailsParam({required this.shopId});

  @override
  List<Object?> get props => [shopId];
}
