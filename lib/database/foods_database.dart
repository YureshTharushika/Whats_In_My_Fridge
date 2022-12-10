import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:whats_in_my_fridge/model/food.dart';

class FoodsDatabase {
  static final FoodsDatabase instance = FoodsDatabase._init();
  static Database? _database;
  FoodsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('foods.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolTpye = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $tableFoods (
  ${FoodFields.id} $idType,
  ${FoodFields.title} $textType,
  ${FoodFields.category} $textType,
  ${FoodFields.isExpired} $boolTpye,
  ${FoodFields.createdTime} $textType,
  ${FoodFields.expiryTime} $textType
  )
''');
  }

  Future<Food> create(Food food) async {
    final db = await instance.database;

    final id = await db.insert(tableFoods, food.toJson());
    return food.copy(id: id);
  }

  Future<List<Food>> retriveAllFood() async {
    final db = await instance.database;

    final result = await db.query(tableFoods);

    return result.map((json) => Food.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
