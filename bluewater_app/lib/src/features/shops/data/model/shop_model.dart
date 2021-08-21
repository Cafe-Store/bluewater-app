import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/shop.dart';
import 'serialiser/photo_serialiser.dart';
import 'serialiser/rank_serialiser.dart';
import 'photo_model.dart';
import 'rank_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends Shop {
  final String shopId;

  const ShopModel({
    required this.shopId,
    required String name,
    required PhotoModel photo,
    required RankModel rank,
  }) : super(id: shopId, name: name, photo: photo, rank: rank);

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
