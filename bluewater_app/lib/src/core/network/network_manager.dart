import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

enum NetworkStatus { online, offline }

class NetworkManager extends GetxController implements NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  NetworkStatus _status = NetworkStatus.offline;
  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    _initNetworkSate();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  void _initNetworkSate() async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    _updateState(connectivityResult);
  }

  void _updateState(ConnectivityResult result) {
    _status = _getNetworkStatus(result);
    // TODO 요건 좀 더 확인해보고 사용하기로..
    // update();
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }

  @override
  Future<bool> get isConnected => Future.value(_status == NetworkStatus.online);

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi
        ? NetworkStatus.online
        : NetworkStatus.offline;
  }
}
