import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(path, onCreate: _createTables, version: 1);
  }

  Future<void> _createTables(Database db, int version) async {
    // await db.execute('''
    //   CREATE TABLE table2(
    //     id INTEGER PRIMARY KEY,
    //     description TEXT
    //   )
    // ''');
  }
}
