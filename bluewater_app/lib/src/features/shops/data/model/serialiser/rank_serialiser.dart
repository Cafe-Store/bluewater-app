import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/rank.dart';

class RankSerialiser extends JsonConverter<Rank, Map<String, dynamic>> {
  const RankSerialiser();

  @override
  Rank fromJson(Map<String, dynamic> json) {
    return Rank(json['value'] as double, json['count'] as int);
  }

  @override
  Map<String, dynamic> toJson(Rank object) => {
        'value': object.value,
        'count': object.count,
      };
}
