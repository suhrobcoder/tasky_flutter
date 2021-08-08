import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFactory {
  DbFactory._();

  static Database? _database;

  static Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    String path = join(docsDir.path, databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tasksTableName(
        id INTEGER NOT NULL PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        date INTEGER NOT NULL,
        notification INTEGER NOT NULL,
        priority_high INTEGER NOT NULL,
        done INTEGER NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $categoryTableName(
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        color TEXT NOT NULL
      )
    ''');
    await db.insert(
      "category",
      {"id": 1, "name": "Personal", "color": "#00E1B5"},
    );
  }
}

const databaseName = "tasky.db";
const databaseVersion = 1;
const tasksTableName = "tasks";
const categoryTableName = "category";
