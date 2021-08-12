import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

enum NetworkStatus { online, offline }

@LazySingleton()
class NetworkInfo {
  NetworkInfo._();

  static final NetworkInfo _instance = NetworkInfo._();

  factory NetworkInfo() {
    return _instance;
  }

  Future<bool> get isConnected => _isAvailable();

  Future<bool> _isAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var getNetworkStatus = _getNetworkStatus(connectivityResult);

    return Future.value(getNetworkStatus == NetworkStatus.online);
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
