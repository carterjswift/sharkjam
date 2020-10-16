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

// class DatabaseProvider {
//   DatabaseProvider._();
//   static final DatabaseProvider db = DatabaseProvider._();

//   static Database _database;

//   Future<Database> get database async {
//     if (_database != null) return _database;

//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "video_database.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Videos ("
//           "id INTEGER PRIMARY KEY,"
//           "title TEXT,"
//           "channel TEXT,"
//           "duration TEXT"
//           ")");
//     });
//   }

//   newVideo(Video newVideo) async {
//     final db = await database;
//     var res = await db.insert("Video", newVideo.toMap());
//     return res;
//   }

//   getVideo(int id) async {
//     final db = await database;
//     var res = await db.query("Video", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Video.fromMap(res.first) : Null;
//   }

//   getAllVideos() async {
//     final db = await database;
//     var res = await db.query("Video");
//     List<Video> list =
//         res.isNotEmpty ? res.map((c) => Video.fromMap(c)).toList() : [];
//     return list;
//   }

//   updateVideo(Video newVideo) async {
//     final db = await database;
//     var res = await db.update("Video", newVideo.toMap(),
//         where: "id = ?", whereArgs: [newVideo.id]);
//     return res;
//   }

//   deleteVideo(int id) async {
//     final db = await database;
//     db.delete("Video", where: "id = ?", whereArgs: [id]);
//   }
