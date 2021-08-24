import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUri;
  final String? badgeName;

  Category({required this.name, required this.imageUri, this.badgeName});

  @override
  List<Object?> get props => [name, imageUri];
}
