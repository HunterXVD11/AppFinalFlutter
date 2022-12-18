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

class UsersDatabase {
  static final UsersDatabase instance = UsersDatabase._init();
  static Database? _database;

  UsersDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final charType = 'VARCHAR NOT NULL';

    await db.execute(
        ''' CREATE TABLE $tableUsers (
          ${UsersFields.id} $idType,
          ${UsersFields.name} $charType,
          ${UsersFields.email} $charType,
          ${UsersFields.password} $charType
          
        )''');
  }
  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(tableUsers, user.toJson());

    return user.copy(id:id);
  }

  Future<User> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
        tableUsers,
        columns: UsersFields.values,
        where: '${UsersFields.id} = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty){
      return User.fromJson(maps.first);
    }else{
      throw Exception('ID $id não encontrado');
    }
  }
  Future<List<User>> readAllNotes() async{
    final db = await instance.database;
    final result = await db.query(tableUsers);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> updateNotes(User user) async{
    final db = await instance.database;

    return db.update(
        tableUsers,
        user.toJson(),
        where: '${UsersFields.id} = ?',
        whereArgs: [user.id]
    );
  }

  Future<int> deleteNotes(int id) async{
    final db = await instance.database;

    return await db.delete(
        tableUsers,
        where: '${UsersFields.id} = ?',
        whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}