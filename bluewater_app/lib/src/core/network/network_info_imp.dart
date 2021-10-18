import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import '../injector/injection.dart';
import 'network_info.dart';

@LazySingleton(env: [Env.dev, Env.prod], as: NetworkInfo)
class NetworkInfoImp extends NetworkInfo {
  NetworkInfoImp._();

  static final NetworkInfoImp _instance = NetworkInfoImp._();

  factory NetworkInfoImp() {
    return _instance;
  }
  @override
  Future<bool> get isConnected => isAvailable();

  @override
  Future<bool> isAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var networkStatus = getNetworkStatus(connectivityResult);

    return Future.value(networkStatus == NetworkStatus.online);
  }

  @override
  NetworkStatus getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
