import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String code;
  final String name;

  Group(this.code, this.name);

  @override
  List<Object?> get props => [code, name];
}
