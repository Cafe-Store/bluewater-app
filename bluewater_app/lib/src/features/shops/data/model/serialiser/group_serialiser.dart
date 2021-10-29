import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/group.dart';
import '../group_model.dart';

class GroupsSerialiser extends JsonConverter<List<Group>, List<dynamic>> {
  const GroupsSerialiser();

  @override
  List<Group> fromJson(List<dynamic> json) =>
      json.map((e) => GroupModel.fromJson(e as Map<String, dynamic>)).toList();

  @override
  List<Map<String, dynamic>> toJson(List<Group> groups) => groups
      .map((e) => <String, dynamic>{
            'code': e.code,
            'name': e.name,
          })
      .toList();
}
