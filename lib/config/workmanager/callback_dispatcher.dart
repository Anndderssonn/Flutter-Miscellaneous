import 'package:workmanager/workmanager.dart';
import 'package:miscellaneous/infrastructure/infrastructure.dart';

const fetchBackgroundTaskKey =
    'com.faketrue.miscellaneous.fetch-pokemon-background';
const fetchPeriodicBackgroundTaskKey =
    'com.faketrue.miscellaneous.fetch-periodic-pokemon-background';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case fetchBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        break;
    }
    return true;
  });
}

Future loadNextPokemon() async {
  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDbRepository.totalPokemons() + 1;
  try {
    final (pokemon, message) = await pokemonRepository.getPokemon(
      '$lastPokemonId',
    );
    if (pokemon == null) throw message;
    await localDbRepository.insertPokemon(pokemon);
  } catch (e) {
    throw Error();
  }
}
