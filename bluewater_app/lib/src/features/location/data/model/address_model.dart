import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/address.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends Address {
  AddressModel(
      {required String postcode,
      required String street,
      required String detail})
      : super(postcode, street, detail);

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  factory AddressModel.from(Address address) => AddressModel(
        postcode: address.postcode,
        street: address.street,
        detail: address.detail,
      );

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
