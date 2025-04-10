import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Interface for network service operations
abstract class INetworkService {
  Stream<bool> get onConnectivityChanged;
  Future<bool> get isConnected;
  Future<void> initialize();
  void dispose();
}

/// Implementation of network service
class NetworkService implements INetworkService {
  final Connectivity _connectivity;
  final _connectivityController = StreamController<bool>.broadcast();
  StreamSubscription? _connectivitySubscription;

  NetworkService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity() {
    initialize();
  }

  @override
  Stream<bool> get onConnectivityChanged => _connectivityController.stream;

  @override
  Future<bool> get isConnected async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result != ConnectivityResult.none;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> initialize() async {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        _connectivityController.add(result != ConnectivityResult.none);
      },
      onError: (error) {
        _connectivityController.add(false);
      },
    );
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityController.close();
  }
} 