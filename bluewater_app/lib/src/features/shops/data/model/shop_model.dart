import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/shop.dart';
import 'photo_model.dart';
import 'rank_model.dart';
import 'serialiser/photos_serialiser.dart';
import 'serialiser/rank_serialiser.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends Shop {
  final String shopId;

  const ShopModel({
    required this.shopId,
    required String name,
    required List<PhotoModel> photos,
    required RankModel rank,
  }) : super(id: shopId, name: name, photos: photos, rank: rank);

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}
