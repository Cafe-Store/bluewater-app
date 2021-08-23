import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../features/events/data/model/event_model.dart';

class MockAdapter extends HttpClientAdapter {
  final DefaultHttpClientAdapter _adapter = DefaultHttpClientAdapter();

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) {
    var uri = options.uri;
    var uriPath = uri.path;

    if (uriPath == '/events') {
      var evnets = [
        EventModel(
          url:
              'http://english.seoul.go.kr/wp-content/uploads/2021/06/CulturalCalendar_840x150px_ENG.png',
        ),
        EventModel(
          url:
              'https://i.pinimg.com/564x/b1/e8/24/b1e824ab1e4ce470e9d1f9b8489e09f4.jpg',
          endDate: DateTime(2021, 09, 04),
        ),
        EventModel(
          url:
              'https://i.pinimg.com/564x/38/26/5e/38265e93e98e4992c18e5f3e2864f89b.jpg',
          endDate: DateTime(2021, 09, 04),
        ),
        EventModel(
          url:
              'https://i.pinimg.com/564x/19/b2/03/19b203cf22f387270604e821ea5ec06e.jpg',
          endDate: DateTime(2021, 09, 04),
        ),
      ];

      return Future.delayed(Duration(seconds: 1)).then(
        (value) => ResponseBody.fromString(
          jsonEncode(evnets),
          200,
          headers: {
            Headers.contentTypeHeader: [Headers.jsonContentType],
          },
        ),
      );
    }
    return _adapter.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }
}
