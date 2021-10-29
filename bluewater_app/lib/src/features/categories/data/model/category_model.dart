import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/category.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends Category {
  CategoryModel({
    required String code,
    required String image,
    required String name,
    String? badgeName,
  }) : super(code: code, image: image, name: name, badgeName: badgeName);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  factory CategoryModel.from(Category category) => CategoryModel(
      code: category.code, image: category.image, name: category.name);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
