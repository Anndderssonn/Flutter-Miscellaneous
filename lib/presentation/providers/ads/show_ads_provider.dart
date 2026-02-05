import 'package:flutter_riverpod/legacy.dart';
import 'package:miscellaneous/config/config.dart';

const storeKey = 'showAds';

class ShowAdsNotifier extends StateNotifier<bool> {
  ShowAdsNotifier() : super(false) {
    checkAdsState();
  }

  void checkAdsState() async {
    state = await SharedPreferencesPlugin.getBool(storeKey) ?? true;
  }

  void removeAds() {
    SharedPreferencesPlugin.setBool(storeKey, false);
    state = false;
  }

  void showAds() {
    SharedPreferencesPlugin.setBool(storeKey, true);
    state = true;
  }

  void toggleAds() {
    state ? removeAds() : showAds();
  }
}

final showAdsProvider =
    StateNotifierProvider.autoDispose<ShowAdsNotifier, bool>((ref) {
      return ShowAdsNotifier();
    });
