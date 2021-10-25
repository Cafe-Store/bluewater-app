import 'package:json_annotation/json_annotation.dart';

import '../../../location/domain/entity/adress.dart';

part 'adress_model.g.dart';

@JsonSerializable()
class AdressModel extends Adress {
  AdressModel(
      {required String postcode,
      required String street,
      required String detail})
      : super(postcode, street, detail);

  factory AdressModel.fromJson(Map<String, dynamic> json) =>
      _$AdressModelFromJson(json);

  factory AdressModel.from(Adress adress) => AdressModel(
        postcode: adress.postcode,
        street: adress.street,
        detail: adress.detail,
      );

  Map<String, dynamic> toJson() => _$AdressModelToJson(this);
}
