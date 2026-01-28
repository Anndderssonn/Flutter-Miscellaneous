import 'package:dio/dio.dart';
import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/infrastructure/infrastructure.dart';

class PokemonsDatasourceImpl implements PokemonsDatasource {
  final Dio dio;

  PokemonsDatasourceImpl()
    : dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    try {
      final response = await dio.get('/pokemon/$id');
      final pokemon = PokemonMapper.pokeApiPokemonToEntity(response.data);
      return (pokemon, 'Success');
    } catch (e) {
      return (null, 'Pokemon not found: $e');
    }
  }
}
