import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Category {
  CategoryModel({
    required String imageUri,
    required String name,
  }) : super(imageUri: imageUri, name: name);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
