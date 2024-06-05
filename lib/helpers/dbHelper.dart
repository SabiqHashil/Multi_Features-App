import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static late Database _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  static DBHelper get instance => _instance;

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    final String path = join(await getDatabasesPath(), 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS weather(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          cityName TEXT,
          temperature REAL,
          description TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS movie(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          releaseDate TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS timezone(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          timeZone TEXT,
          currentTime TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS news(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          url TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS jokes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          joke TEXT
        )
      ''');
    } catch (e) {
      print('Error creating tables: $e');
    }
  }

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    final db = await instance.database;
    try {
      return await db.insert(tableName, row);
    } catch (e) {
      print('Error inserting data into $tableName table: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    final db = await instance.database;
    try {
      return await db.query(tableName);
    } catch (e) {
      print('Error querying data from $tableName table: $e');
      return [];
    }
  }
}
