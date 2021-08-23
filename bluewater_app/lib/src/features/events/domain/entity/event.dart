import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String url;
  final DateTime? endDate;

  Event({required this.url, this.endDate});

  @override
  List<Object?> get props => [url];
}
