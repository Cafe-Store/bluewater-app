import '../../data/model/serialiser/photo_serialiser.dart';

@PhotoSerialiser()
class Photo {
  final String uri;

  Photo(this.uri);
}
