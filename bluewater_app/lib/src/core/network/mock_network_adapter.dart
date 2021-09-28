import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import '../../features/categories/data/model/category_model.dart';
import '../../features/events/data/model/event_model.dart';

class MockAdapter extends HttpClientAdapter {
  final DefaultHttpClientAdapter _adapter = DefaultHttpClientAdapter();

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) {
    var uri = options.uri;
    var uriPath = uri.path;

    switch (uriPath) {
      case '/events':
        return createMockData(eventModels);
      case '/search':
        return createMockData(categoryModels);
    }

    return _adapter.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) {
    _adapter.close(force: force);
  }

  Future<ResponseBody> createMockData(List<dynamic> datas) {
    return Future.delayed(Duration(seconds: 1)).then(
      (value) => ResponseBody.fromString(
        jsonEncode(datas),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
  }

  List<EventModel> get eventModels {
    return [
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
  }

  List<CategoryModel> get categoryModels {
    return [
      CategoryModel(
          imageUri:
              'https://st4.depositphotos.com/1200570/19802/v/1600/depositphotos_198029772-stock-illustration-vector-seamless-pattern-tropical-jungle.jpg',
          name: '전체'),
      CategoryModel(
          imageUri:
              'https://cdn.pixabay.com/photo/2017/08/01/13/47/light-2565575_1280.jpg',
          name: '신규 가게',
          badgeName: 'new'),
      CategoryModel(
          imageUri:
              'https://www.maxpixel.net/static/photo/2x/Style-Shirt-Outfit-Fashion-Casual-Tshirt-Clothes-2428521.jpg',
          name: '패션'),
      CategoryModel(
          imageUri:
              'https://cdn.pixabay.com/photo/2017/03/03/16/00/lipsticks-2114263_1280.jpg',
          name: '뷰티'),
      CategoryModel(
          imageUri:
              'https://c.pxhere.com/photos/5b/a1/assorted_bright_colorful_colourful_creative_decoration_design_hanging-1548685.jpg!d',
          name: '문화'),
      CategoryModel(
          imageUri:
              'https://p2.piqsels.com/preview/968/501/264/bookshop-books-buy-library.jpg',
          name: '취미/도서'),
      CategoryModel(
          imageUri:
              'https://p1.pxfuel.com/preview/873/548/58/ferris-wheel-fair-folk-festival-rides.jpg',
          name: '여행/체험'),
      CategoryModel(
          imageUri:
              'http://s3-ap-northeast-2.amazonaws.com/stockplus-insight-seoul/articles/pictures/8084/content_www_google_co_kr_20160829_202550.jpg',
          name: '스포츠/레저'),
    ];
  }
}
