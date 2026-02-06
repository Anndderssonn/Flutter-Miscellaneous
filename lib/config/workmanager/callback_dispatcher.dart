import 'package:workmanager/workmanager.dart';

const fetchBackgroundTaskKey =
    'com.faketrue.miscellaneous.fetch-pokemon-background';
const fetchPeriodicBackgroundTaskKey =
    'com.faketrue.miscellaneous.fetch-periodic-pokemon-background';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case fetchBackgroundTaskKey:
        print('fetchBackgroundTaskKey');
        break;
      case fetchPeriodicBackgroundTaskKey:
        print('fetchPeriodicBackgroundTaskKey');
        break;
      case Workmanager.iOSBackgroundTask:
        print('Workmanager.iOSBackgroundTask');
        break;
    }
    return true;
  });
}
