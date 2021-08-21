import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/rank.dart';

part 'rank_model.g.dart';

@JsonSerializable()
class RankModel extends Rank {
  RankModel({required double value, required int count}) : super(value, count);

  factory RankModel.fromJson(Map<String, dynamic> json) =>
      _$RankModelFromJson(json);

  Map<String, dynamic> toJson() => _$RankModelToJson(this);
}
