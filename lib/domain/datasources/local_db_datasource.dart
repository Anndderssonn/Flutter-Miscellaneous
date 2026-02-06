import 'package:miscellaneous/domain/domain.dart';

abstract class LocalDbDatasource {
  Future<List<Pokemon>> loadPokemons();
  Future<int> totalPokemons();
  Future<void> insertPokemon(Pokemon pokemon);
}
