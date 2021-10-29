import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/product.dart';
import 'group_model.dart';
import 'photo_model.dart';
import 'price_model.dart';
import 'serialiser/group_serialiser.dart';
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
    required List<GroupModel> groups,
  }) : super(
          id: productId,
          name: name,
          photo: photo,
          price: price,
          groups: groups,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
