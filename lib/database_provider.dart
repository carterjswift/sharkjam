import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'video.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "video_database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Videos ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "channel TEXT,"
          "duration TEXT"
          ")");
    });
  }

  newVideo(Video newVideo) async {
    final db = await database;
    var res = await db.insert("Video", newVideo.toMap());
    return res;
  }

  getVideo(int id) async {
    final db = await database;
    var res = await db.query("Video", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Video.fromMap(res.first) : Null;
  }

  getAllVideos() async {
    final db = await database;
    var res = await db.query("Video");
    List<Video> list =
        res.isNotEmpty ? res.map((c) => Video.fromMap(c)).toList() : [];
    return list;
  }

  updateVideo(Video newVideo) async {
    final db = await database;
    var res = await db.update("Video", newVideo.toMap(),
        where: "id = ?", whereArgs: [newVideo.id]);
    return res;
  }

  deleteVideo(int id) async {
    final db = await database;
    db.delete("Video", where: "id = ?", whereArgs: [id]);
  }

}
