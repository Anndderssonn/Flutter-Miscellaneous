import 'package:sqflite/sqflite.dart';
import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/infrastructure/infrastructure.dart';

class SqfliteLocalDbDatasource extends LocalDbDatasource {
  Future<Database> get _db async => await SqliteDatabase.instance.db;

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final db = await _db;
    await db.insert('pokemon', {
      'id': pokemon.id,
      'name': pokemon.name,
      'sprite_front': pokemon.spriteFront,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final db = await _db;
    final rows = await db.query('pokemon', orderBy: 'id ASC');
    return rows
        .map(
          (row) => Pokemon(
            id: row['id'] as int,
            name: row['name'] as String,
            spriteFront: row['sprite_front'] as String,
          ),
        )
        .toList();
  }

  @override
  Future<int> totalPokemons() async {
    final db = await _db;
    final result = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM pokemon'),
    );
    return result ?? 0;
  }
}
