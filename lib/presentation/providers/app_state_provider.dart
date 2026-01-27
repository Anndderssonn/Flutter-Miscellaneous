import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:flutter_riverpod/legacy.dart';

final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
