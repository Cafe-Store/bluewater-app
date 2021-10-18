import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import '../injector/injection.dart';
import 'network_info.dart';

@LazySingleton(env: [Env.test], as: NetworkInfo)
class MockNetworkOnlineInfoImp extends NetworkInfo {
  @override
  NetworkStatus getNetworkStatus(ConnectivityResult status) {
    return NetworkStatus.online;
  }

  @override
  Future<bool> isAvailable() {
    return Future.value(true);
  }
}
