import '../../../../shared/model/tab_item.dart';

class Category extends TabItem {
  final String name;
  final String imageUri;
  final String? badgeName;

  Category({required this.name, required this.imageUri, this.badgeName});

  @override
  List<Object?> get props => [name];

  @override
  String get title => name;
}
