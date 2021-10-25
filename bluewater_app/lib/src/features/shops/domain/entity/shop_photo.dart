import 'package:bluewater_app/src/features/shops/data/model/serialiser/photo_serialiser.dart';

import 'photo.dart';

class ShopPhoto {
  final bool main;

  @PhotoSerialiser()
  final Photo photo;

  ShopPhoto(this.photo, {this.main = false});
}
