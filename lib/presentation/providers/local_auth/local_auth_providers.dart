import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:miscellaneous/config/config.dart';

final canCheckBiometricsProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

enum LocalAuthStatus { authenticated, unAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthStatus status;
  final String message;

  LocalAuthState({
    this.didAuthenticate = false,
    this.status = LocalAuthStatus.unAuthenticated,
    this.message = '',
  });

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthState(
      didAuthenticate: didAuthenticate ?? this.didAuthenticate,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''
      didAuthenticate: $didAuthenticate
      status: $status
      message: $message
    ''';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticateUser() async {
    final (didAuthenticate, message) = await LocalAuthPlugin.authenticate();
    state = state.copyWith(
      didAuthenticate: didAuthenticate,
      message: message,
      status: didAuthenticate
          ? LocalAuthStatus.authenticated
          : LocalAuthStatus.unAuthenticated,
    );
    return (didAuthenticate, message);
  }
}

final localAuthProvider =
    StateNotifierProvider.autoDispose<LocalAuthNotifier, LocalAuthState>((ref) {
      return LocalAuthNotifier();
    });
