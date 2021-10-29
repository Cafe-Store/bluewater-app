import 'package:json_annotation/json_annotation.dart';

import '../../../../categories/data/model/category_model.dart';
import '../../../../categories/domain/entity/category.dart';

class CategoryListSerialiser
    extends JsonConverter<List<Category>, List<dynamic>> {
  const CategoryListSerialiser();

  @override
  List<Category> fromJson(List<dynamic> json) => json
      .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
      .toList();

  @override
  List<Map<String, dynamic>> toJson(List<Category> catagories) =>
      catagories.map((e) => CategoryModel.from(e).toJson()).toList();
}
