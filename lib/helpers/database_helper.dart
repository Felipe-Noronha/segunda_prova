import 'dart:async';
import 'package:path/path.dart';
import 'package:segunda_prova/domain/cidade.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'cidades';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'cidade_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          idioma TEXT,
          populacao INTEGER,
          area REAL,
          anoFundacao INTEGER,
          possuiAeroporto INTEGER
        )
      ''');
      },
    );
  }

  Future<int> insertCidade(Map<String, dynamic> cidade) async {
    final Database db = await database;
    return await db.insert(tableName, cidade);
  }

  Future<int> updateCidade(Map<String, dynamic> cidade) async {
    final Database db = await database;
    return await db.update(
      tableName,
      cidade,
      where: 'id = ?',
      whereArgs: [cidade['id']],
    );
  }

  Future<List<Cidade>> getAllCidades() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Cidade(
        id: maps[i]['id'],
        nome: maps[i]['nome'],
        idioma: maps[i]['idioma'],
        populacao: maps[i]['populacao'],
        area: maps[i]['area'],
        anoFundacao: maps[i]['anoFundacao'],
        possuiAeroporto: maps[i]['possuiAeroporto'] == 1 ? true : false,
      );
    });
  }

  Future<Map<String, dynamic>?> getCidadeById(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? maps.first : null;
  }

  Future<int> deleteCidade(int id) async {
    final Database db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
