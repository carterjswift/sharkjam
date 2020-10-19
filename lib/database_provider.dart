import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'model/model.dart';

abstract class DatabaseProvider {
  static Database db;

  static int get _version => 1;

  static Future<void> init() async {
    if (db != null) {
      return;
    }

    try {
      String _path = await getDatabasesPath() + 'videos';
      //line to delete the videos in the database:
      //await deleteDatabase(_path);
      
      db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE videos_database (id VARCHAR(255) PRIMARY KEY NOT NULL, title TEXT , channel TEXT, duration TEXT)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      db.query(table);

  static Future<int> insert(String table, Model model) async =>
      await db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await db.delete(table, where: 'id = ?', whereArgs: [model.id]);
}