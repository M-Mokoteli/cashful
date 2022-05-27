import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityViewModel extends ChangeNotifier {
  ConnectivityResult? result;
  // ignore: cancel_subscriptions, unused_field
  StreamSubscription<ConnectivityResult>? _connectivitySubsciption;

  ConnectivityViewModel() {
    _connectivitySubsciption =
        Connectivity().onConnectivityChanged.listen((result) {
      this.result = result;
      notifyListeners();
    });
  }
}
