import 'package:flutter_riverpod/legacy.dart';

final pokemonIdsProvider = StateProvider.autoDispose<List<int>>((ref) {
  return List.generate(30, (index) => index + 1);
});
