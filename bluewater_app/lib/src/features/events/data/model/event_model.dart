import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/event.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel extends Event {
  EventModel({required String url, DateTime? endDate})
      : super(url: url, endDate: endDate);

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
