import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/infrastructure/infrastructure.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource datasource;

  PokemonsRepositoryImpl({PokemonsDatasource? datasource})
    : datasource = datasource ?? PokemonsDatasourceImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) {
    return datasource.getPokemon(id);
  }
}
