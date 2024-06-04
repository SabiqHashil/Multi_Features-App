import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() {
    return _instance;
  }

  DBHelper._internal();

  static DBHelper get instance => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, instantiate it
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');

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

  // Methods for Weather table
  Future<int> insertWeather(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('weather', row);
  }

  Future<List<Map<String, dynamic>>> queryAllWeather() async {
    Database db = await instance.database;
    return await db.query('weather');
  }

  // Methods for Movie table
  Future<int> insertMovie(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('movie', row);
  }

  Future<List<Map<String, dynamic>>> queryAllMovies() async {
    Database db = await instance.database;
    return await db.query('movie');
  }

  // Methods for TimeZone table
  Future<int> insertTimeZone(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('timezone', row);
  }

  Future<List<Map<String, dynamic>>> queryAllTimeZones() async {
    Database db = await instance.database;
    return await db.query('timezone');
  }

  // Methods for News table
  Future<int> insertNews(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('news', row);
  }

  Future<List<Map<String, dynamic>>> queryAllNews() async {
    Database db = await instance.database;
    return await db.query('news');
  }

  // Methods for Jokes table
  Future<int> insertJoke(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('jokes', row);
  }

  Future<List<Map<String, dynamic>>> queryAllJokes() async {
    Database db = await instance.database;
    return await db.query('jokes');
  }
}
