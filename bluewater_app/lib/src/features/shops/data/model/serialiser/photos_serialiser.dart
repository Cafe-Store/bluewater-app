import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entity/photo.dart';
import '../photo_model.dart';

class PhotoListSerialiser extends JsonConverter<List<Photo>, Object> {
  const PhotoListSerialiser();

  @override
  List<Photo> fromJson(Object json) {
    var photos = <Photo>[];
    if (json is Map<String, dynamic>) {
      photos.add(PhotoModel.fromJson(json));
    } else if (json is List<dynamic>) {
      json.map((e) => PhotoModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    return photos;
  }

  @override
  List<Map<String, dynamic>> toJson(List<Photo> photos) =>
      photos.map((e) => <String, dynamic>{'uri': e.uri}).toList();
}
