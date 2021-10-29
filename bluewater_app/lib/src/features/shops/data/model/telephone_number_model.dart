import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/telephone_homber.dart';

part 'telephone_number_model.g.dart';

@JsonSerializable()
class TelephoneNumberModel extends TelephoneNumber {
  TelephoneNumberModel({
    required String value,
  }) : super(value);

  factory TelephoneNumberModel.fromJson(Map<String, dynamic> json) =>
      _$TelephoneNumberModelFromJson(json);

  factory TelephoneNumberModel.from(TelephoneNumber tel) =>
      TelephoneNumberModel(value: tel.value);

  Map<String, dynamic> toJson() => _$TelephoneNumberModelToJson(this);
}
