import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/photo.dart';
import '../../domain/entity/shop_photo.dart';
import 'serialiser/photo_serialiser.dart';

part 'shop_photo_model.g.dart';

@JsonSerializable()
class ShopPhotoModel extends ShopPhoto {
  ShopPhotoModel({
    required Photo photo,
    required bool main,
  }) : super(photo, main: main);

  factory ShopPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ShopPhotoModelFromJson(json);

  factory ShopPhotoModel.from(ShopPhoto shopPhoto) => ShopPhotoModel(
        photo: shopPhoto.photo,
        main: shopPhoto.main,
      );

  Map<String, dynamic> toJson() => _$ShopPhotoModelToJson(this);
}
