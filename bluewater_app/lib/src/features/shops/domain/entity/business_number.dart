import 'package:equatable/equatable.dart';

class BusinessNumber extends Equatable {
  final String value;

  BusinessNumber(this.value);

  @override
  List<Object?> get props => [value];
}
