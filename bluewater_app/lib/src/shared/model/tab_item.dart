import 'package:equatable/equatable.dart';

abstract class TabItem extends Equatable {
  String get title;
  String get imageUri;
  String? get badgeName;
}
