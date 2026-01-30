import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {
  static final LocalAuthentication auth = LocalAuthentication();

  static void availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth
        .getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {}

    if (availableBiometrics.contains(BiometricType.strong)) {}
  }

  static Future<bool> canCheckBiometrics() async {
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show module',
      );
      return (
        didAuthenticate,
        didAuthenticate ? 'Done' : 'Process canceled by user',
      );
    } on LocalAuthException catch (e) {
      if (e.code == LocalAuthExceptionCode.noBiometricsEnrolled) {
        return (false, 'No biometrics enrolled');
      }
      if (e.code == LocalAuthExceptionCode.temporaryLockout) {
        return (false, 'Too many failed attempts');
      }
      if (e.code == LocalAuthExceptionCode.noBiometricHardware) {
        return (false, 'No biometrics available');
      }
      if (e.code == LocalAuthExceptionCode.noCredentialsSet) {
        return (false, 'No passcode or pin available');
      }
      if (e.code == LocalAuthExceptionCode.biometricLockout) {
        return (false, 'Please, try to unblock your phone');
      }
      return (false, e.toString());
    } on PlatformException catch (e) {
      return (false, e.toString());
    }
  }
}
