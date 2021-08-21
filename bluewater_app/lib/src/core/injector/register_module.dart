import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../logger/logger_utils.dart';

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://dev-bluewater-web-app.azurewebsites.net';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) {
    final dio = Dio(BaseOptions(baseUrl: url));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      Logger.logNoStack.i(options.extra);
      Logger.logNoStack.i(options.baseUrl);
      Logger.logNoStack.i(options.method);
      Logger.logNoStack.i(options.headers);
      handler.next(options);
    }));
    return dio;
  }

  // same thing works for instances that's gotten asynchronous.
  // all you need to do is wrap your instance with a future and tell injectable how
  // to initialize it
  // @preResolve // if you need to pre resolve the value
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
