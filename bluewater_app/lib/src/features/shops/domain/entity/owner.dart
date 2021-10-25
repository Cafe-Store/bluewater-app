import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Owner extends Equatable {
  @JsonKey(name: 'ownerId')
  final String id;

  final String name;

  Owner(this.id, this.name);

  @override
  List<Object?> get props => [id];
}
