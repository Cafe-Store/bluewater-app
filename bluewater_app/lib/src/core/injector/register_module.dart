import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  //TODO 나중에 파베랑 연동해서 파베에서 config 값 가져오도록 하면 어떻게 될까?
  @Named("BaseUrl")
  String get baseUrl => 'My base url';

  // url here will be injected
  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  // same thing works for instances that's gotten asynchronous.
  // all you need to do is wrap your instance with a future and tell injectable how
  // to initialize it
  // @preResolve // if you need to pre resolve the value
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
