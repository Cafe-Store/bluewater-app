import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUri;

  Category({required this.name, required this.imageUri});

  @override
  List<Object?> get props => [name, imageUri];
}
