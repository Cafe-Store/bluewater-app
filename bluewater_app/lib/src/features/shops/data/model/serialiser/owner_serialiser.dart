import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/owner.dart';
import '../owner_model.dart';

class OwnerSerialiser extends JsonConverter<Owner, Map<String, dynamic>> {
  const OwnerSerialiser();

  @override
  Owner fromJson(Map<String, dynamic> json) => OwnerModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(Owner owner) => OwnerModel.from(owner).toJson();
}
