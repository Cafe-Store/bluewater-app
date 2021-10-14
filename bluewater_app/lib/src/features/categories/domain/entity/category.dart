import '../../../../shared/model/tab_item.dart';

class Category extends TabItem {
  final String code;
  final String name;
  final String image;
  final String? badgeName;

  Category(
      {required this.code,
      required this.name,
      required this.image,
      this.badgeName});

  @override
  List<Object?> get props => [code, name];

  @override
  String get title => name;
}
