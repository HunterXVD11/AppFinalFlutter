import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:loja_anuncios/model/user.dart';
import 'package:loja_anuncios/model/anuncio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnunciosDatabase {
  static final AnunciosDatabase instance = AnunciosDatabase._init();
  static Database? _database;

  AnunciosDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('anuncios.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stateTypeChar = 'VARCHAR(2) NOT NULL';
    final categoryTypeChar = 'VARCHAR(2) NOT NULL';
    final textType = 'TEXT NOT NULL';
    final doubleType = 'REAL NOT NULL';
    final telephoneTypeChar = 'VARCHAR(20) NOT NULL';


    await db.execute(
        ''' CREATE TABLE $tableAnuncios (
          ${AnunciosFields.id} $idType,
          ${AnunciosFields.state} $stateTypeChar,
          ${AnunciosFields.category} $categoryTypeChar,
          ${AnunciosFields.title} $textType,
          ${AnunciosFields.price} $doubleType,
          ${AnunciosFields.telephone} $telephoneTypeChar,
          ${AnunciosFields.description} $textType    
        )''');
  }
  Future<Anuncio> create(Anuncio anuncio) async {
    final db = await instance.database;
    final id = await db.insert(tableAnuncios, anuncio.toJson());

    return anuncio.copy(id:id);
  }

  Future<Anuncio> readAnuncio(int id) async {
    final db = await instance.database;

    final maps = await db.query(
        tableAnuncios,
        columns: AnunciosFields.values,
        where: '${AnunciosFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty){
      return Anuncio.fromJson(maps.first);
    }else{
      throw Exception('ID $id não encontrado');
    }
  }
  Future<List<Anuncio>> readAllAnuncios() async{
    final db = await instance.database;
    final result = await db.query(tableAnuncios);

    return result.map((json) => Anuncio.fromJson(json)).toList();
  }

  Future<int> updateAnuncio(Anuncio anuncio) async{
    final db = await instance.database;

    return db.update(
        tableAnuncios,
        anuncio.toJson(),
        where: '${AnunciosFields.id} = ?',
        whereArgs: [anuncio.id]
    );
  }

  Future<int> deleteAnuncio(int id) async{
    final db = await instance.database;

    return await db.delete(
        tableAnuncios,
        where: '${AnunciosFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}