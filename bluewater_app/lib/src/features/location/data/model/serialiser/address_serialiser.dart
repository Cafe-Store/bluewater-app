import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/address.dart';
import '../address_model.dart';

class AddressSerialiser extends JsonConverter<Address, Map<String, dynamic>> {
  const AddressSerialiser();

  @override
  Address fromJson(Map<String, dynamic> json) => AddressModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(Address address) =>
      AddressModel.from(address).toJson();
}
