import 'package:flutter_riverpod/legacy.dart';
import 'package:workmanager/workmanager.dart';
import 'package:miscellaneous/config/config.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  void checkCurrentStatus() async {
    state = await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  void toggleProcess() {
    if (state == true) {
      deactivateProcess();
      return;
    }
    activateProcess();
  }

  void activateProcess() async {
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processKeyName,
    );
    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = true;
  }

  void deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgroundPokemonFetchProvider =
    StateNotifierProvider.autoDispose<BackgroundFetchNotifier, bool?>((ref) {
      return BackgroundFetchNotifier(
        processKeyName: fetchPeriodicBackgroundTaskKey,
      );
    });
