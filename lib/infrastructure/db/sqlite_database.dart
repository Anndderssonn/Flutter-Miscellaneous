import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  SqliteDatabase._();
  static final SqliteDatabase instance = SqliteDatabase._();
  late final Future<Database> db = _open();

  Future<Database> _open() async {
    final basePath = await getDatabasesPath();
    final path = join(basePath, 'miscellaneous.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE pokemon (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            sprite_front TEXT NOT NULL
            )
          ''');
      },
    );
  }
}
