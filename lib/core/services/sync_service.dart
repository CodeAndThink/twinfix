import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:twinfix/core/services/connection_service.dart';
import 'package:twinfix/domain/repositories/auth_repository.dart';

/// Background sync service that listens to network connectivity changes
/// and automatically syncs pending local data to the server.
@lazySingleton
class SyncService {
  final AuthRepository _authRepository;
  final ConnectionService _connectionService;
  StreamSubscription<bool>? _connectionSubscription;
  bool _isSyncing = false;

  SyncService(this._authRepository, this._connectionService);

  /// Start listening to connectivity changes.
  /// Should be called once during app initialization (e.g., in AppCubit._init).
  void init() {
    _connectionSubscription = _connectionService.onConnectionChanged.listen((
      isConnected,
    ) {
      if (isConnected) {
        syncAll();
      }
    });
  }

  /// Push all pending data to the server.
  /// Safe to call multiple times — concurrent runs are prevented by [_isSyncing].
  Future<void> syncAll() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      if (!_authRepository.isAuthenticated) {
        return;
      }

      await _authRepository.syncPendingData();
      debugPrint('SyncService: Background sync completed successfully.');
    } catch (e) {
      debugPrint('SyncService: Background sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Cancel the connectivity subscription.
  /// Should be called when AppCubit is closed.
  void dispose() {
    _connectionSubscription?.cancel();
    _connectionSubscription = null;
  }
}
