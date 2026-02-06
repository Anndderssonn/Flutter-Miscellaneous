import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/infrastructure/infrastructure.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDatasource _datasource;

  LocalDbRepositoryImpl([LocalDbDatasource? datasource])
    : _datasource = datasource ?? SqfliteLocalDbDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> totalPokemons() {
    return _datasource.totalPokemons();
  }
}
