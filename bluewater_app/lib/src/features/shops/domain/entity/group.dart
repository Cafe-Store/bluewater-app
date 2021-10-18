import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String id;
  final String name;

  Group({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
