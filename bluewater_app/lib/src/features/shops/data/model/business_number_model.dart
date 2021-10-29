import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/business_number.dart';

part 'business_number_model.g.dart';

@JsonSerializable()
class BusinessNumberModel extends BusinessNumber {
  BusinessNumberModel({
    required String value,
  }) : super(value);

  factory BusinessNumberModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessNumberModelFromJson(json);

  factory BusinessNumberModel.from(BusinessNumber businessNumber) =>
      BusinessNumberModel(value: businessNumber.value);

  Map<String, dynamic> toJson() => _$BusinessNumberModelToJson(this);
}
