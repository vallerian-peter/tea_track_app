import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Watches connectivity changes and verifies real internet reachability.
class NetworkStatusProvider extends ChangeNotifier {
  bool _isOffline = false;
  bool get isOffline => _isOffline;
  bool get isOnline => !_isOffline;

  bool _isCheckingConnectivity = false;
  bool get isCheckingConnectivity => _isCheckingConnectivity;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;
  Future<bool>? _refreshInFlight;
  int _connectivityEvidenceVersion = 0;
  bool _disposed = false;

  NetworkStatusProvider() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((_) => unawaited(refreshStatus()));
    _internetSubscription = InternetConnection()
        .onStatusChange
        .listen((_) => unawaited(refreshStatus()));
    unawaited(refreshStatus());
  }

  /// Call after a successful API request to mark the device online at once.
  void confirmOnline() {
    _connectivityEvidenceVersion++;
    _setOffline(false);
  }

  /// Rechecks reachability. Concurrent callers share one check.
  Future<bool> refreshStatus() {
    final existing = _refreshInFlight;
    if (existing != null) return existing;

    final operation = _performStatusRefresh();
    _refreshInFlight = operation;
    operation.whenComplete(() {
      if (identical(_refreshInFlight, operation)) _refreshInFlight = null;
    });
    return operation;
  }

  Future<bool> _performStatusRefresh() async {
    final evidenceVersionAtStart = _connectivityEvidenceVersion;
    _isCheckingConnectivity = true;
    _notifySafely();

    try {
      final isOfflineNow = await _checkIfOffline();
      if (evidenceVersionAtStart != _connectivityEvidenceVersion) {
        return !_isOffline;
      }
      _setOffline(isOfflineNow);
      return !isOfflineNow;
    } finally {
      _isCheckingConnectivity = false;
      _notifySafely();
    }
  }

  Future<bool> _checkIfOffline() async {
    try {
      final results = await Connectivity().checkConnectivity();
      if (results.isEmpty || results.contains(ConnectivityResult.none)) {
        return true;
      }

      if (await InternetConnection().hasInternetAccess) return false;

      // Retry once to ride out brief network handoffs.
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      return !await InternetConnection().hasInternetAccess;
    } catch (e) {
      debugPrint('Network status check error: $e');
      return false;
    }
  }

  void _setOffline(bool value) {
    if (_isOffline == value) return;
    _isOffline = value;
    _notifySafely();
  }

  void _notifySafely() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    super.dispose();
  }
}
