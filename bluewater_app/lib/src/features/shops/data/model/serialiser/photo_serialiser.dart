import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entity/photo.dart';

class PhotoSerialiser extends JsonConverter<Photo, Map<String, dynamic>> {
  const PhotoSerialiser();

  @override
  Photo fromJson(Map<String, dynamic> json) => Photo(json['uri'] as String);

  @override
  Map<String, dynamic> toJson(Photo object) => {'uri': object.uri};
}
