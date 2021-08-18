import 'package:bluewater_app/src/features/shop/domain/entity/photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel extends Photo {
  PhotoModel({required String uri}) : super(uri);

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}