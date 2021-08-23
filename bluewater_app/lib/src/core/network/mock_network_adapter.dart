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
                'http://english.seoul.go.kr/july-2021-cultural-events/?cat=17'),
        EventModel(
            url:
                'http://english.seoul.go.kr/july-2021-cultural-events/?cat=17'),
        EventModel(
            url:
                'http://english.seoul.go.kr/july-2021-cultural-events/?cat=17'),
        EventModel(
            url:
                'http://english.seoul.go.kr/july-2021-cultural-events/?cat=17'),
      ];

      return Future(
        () => ResponseBody.fromString(
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
