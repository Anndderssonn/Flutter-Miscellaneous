import 'package:miscellaneous/domain/domain.dart';

abstract class LocalDbRepository {
  Future<List<Pokemon>> loadPokemons();
  Future<int> totalPokemons();
  Future<void> insertPokemon(Pokemon pokemon);
}
