import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/price.dart';

part 'price_model.g.dart';

@JsonSerializable()
class PriceModel extends Price {
  PriceModel({required int value}) : super(value);

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PriceModelToJson(this);
}
