import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/owner.dart';

part 'owner_model.g.dart';

@JsonSerializable()
class OwnerModel extends Owner {
  OwnerModel({
    required String id,
    required String name,
  }) : super(id, name);

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);

  factory OwnerModel.from(Owner owner) =>
      OwnerModel(id: owner.id, name: owner.name);

  Map<String, dynamic> toJson() => _$OwnerModelToJson(this);
}
