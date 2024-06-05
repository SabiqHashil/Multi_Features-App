import 'dart:async';
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

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cityName TEXT,
        temperature REAL,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE movie(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        director TEXT,
        releaseDate TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE timezone(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timeZone TEXT,
        currentTime TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE news(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        url TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE jokes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        joke TEXT
      )
    ''');
  }

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    final db = await instance.database;
    return await db.query(tableName);
  }
}
