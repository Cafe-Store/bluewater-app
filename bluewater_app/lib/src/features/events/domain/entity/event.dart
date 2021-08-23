import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String url;

  Event({required this.url});

  @override
  List<Object?> get props => [url];
}
