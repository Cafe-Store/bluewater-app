import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

enum NetworkStatus { online, offline }

abstract class NetworkInfo {
  Future<bool> get isConnected => isAvailable();

  @protected
  Future<bool> isAvailable();

  @protected
  NetworkStatus getNetworkStatus(ConnectivityResult status);
}
