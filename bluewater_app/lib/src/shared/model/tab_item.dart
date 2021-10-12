import 'package:equatable/equatable.dart';

abstract class TabItem extends Equatable {
  String get title;
  String get image;
  String? get badgeName;
}
