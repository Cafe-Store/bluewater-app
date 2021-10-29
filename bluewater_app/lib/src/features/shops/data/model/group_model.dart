import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/group.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel extends Group {
  GroupModel({required String code, required String name}) : super(code, name);

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);
}
