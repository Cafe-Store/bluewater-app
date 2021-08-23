import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../logger/logger_utils.dart';
import '../network/mock_network_adapter.dart';

@module
abstract class RegisterModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://dev-bluewater-web-app.azurewebsites.net';

  @lazySingleton
  Dio dio(@Named('BaseUrl') String url) {
    final dio = Dio(BaseOptions(baseUrl: url));
    dio.httpClientAdapter = MockAdapter();

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      Logger.logNoStack.i(options.extra);
      Logger.logNoStack.i(options.baseUrl);
      Logger.logNoStack.i(options.method);
      Logger.logNoStack.i(options.headers);
      handler.next(options);
    }));
    return dio;
  }

  // @preResolve // if you need to pre resolve the value
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
