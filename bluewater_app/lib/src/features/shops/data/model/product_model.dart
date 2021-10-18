import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/product.dart';
import 'photo_model.dart';
import 'price_model.dart';
import 'serialiser/photo_serialiser.dart';
import 'serialiser/price_serialiser.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  final String productId;

  const ProductModel({
    required this.productId,
    required String name,
    required PhotoModel photo,
    required PriceModel price,
  }) : super(id: productId, name: name, photo: photo, price: price);

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
