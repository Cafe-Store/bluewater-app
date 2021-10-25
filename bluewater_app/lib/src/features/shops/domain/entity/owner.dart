import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final String id;
  final String name;

  Owner(this.id, this.name);

  @override
  List<Object?> get props => [id];
}
