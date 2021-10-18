import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/price.dart';

class PriceSerialiser extends JsonConverter<Price, Map<String, dynamic>> {
  const PriceSerialiser();

  @override
  Price fromJson(Map<String, dynamic> json) => Price(json['value'] as int);

  @override
  Map<String, dynamic> toJson(Price object) => {'value': object.value};
}
