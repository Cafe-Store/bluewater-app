import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/shop_photo.dart';
import '../shop_photo_model.dart';

class ShopPhotoListSerialiser
    extends JsonConverter<List<ShopPhoto>, List<dynamic>> {
  const ShopPhotoListSerialiser();

  @override
  List<ShopPhoto> fromJson(List<dynamic> json) => json
      .map((e) => ShopPhotoModel.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  List<Map<String, dynamic>> toJson(List<ShopPhoto> photos) =>
      photos.map((e) => ShopPhotoModel.from(e).toJson()).toList();
}
