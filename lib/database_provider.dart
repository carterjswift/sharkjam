import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'song.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'video.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "song_database.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "channel TEXT,"
          "url TEXT"
          ")");
    });
  }

  newVideo(Video newVideo) async {
    final db = await database;
    var res = await db.insert("Client", newVideo.toMap());
    return res;
  }

  getVideo(int id) async {
    final db = await database;
    var res =await  db.query("Video", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Video.fromMap(res.first) : Null ;
  }

  getAllVideos() async {
    final db = await database;
    var res = await db.query("Client");
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

//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.

//   WidgetsFlutterBinding.ensureInitialized();

//   // Open the database and store the reference.

//   final Future<Database> database = openDatabase(

//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.

//     join(await getDatabasesPath(), 'song_database.db'),
//     onCreate: (db, version) {
//       return db.execute(
//         "CREATE TABLE songs (name TEXT, duration TEXT)",
//       );
//     },
//     version: 1,
//   );

//   // Define a function that inserts songs into the database
//   Future<void> insertSong(Song song) async {
//     // Get a reference to the database.
//     final Database db = await database;

//     // Insert the Song into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same song is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'songs',
//       song.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

// // A method that retrieves all the songs from the songs table.
//   Future<List<Song>> songs() async {
//     // Get a reference to the database.
//     final Database db = await database;

//     // Query the table for all The Songs.
//     final List<Map<String, dynamic>> maps = await db.query('songs');

//     // Convert the List<Map<String, dynamic> into a List<Song>.
//     return List.generate(maps.length, (i) {
//       return Song(
//         //id: maps[i]['id'],
//         name: maps[i]['name'],
//         duration: maps[i]['duration'],
//       );
//     });
//   }

//   Future<void> updateSong(Song song) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Update the given Song.
//     await db.update(
//       'songs',
//       song.toMap(),
//       // Ensure that the Dog has a matching id.
//       where: "id = ?",
//       // Pass the Song's name as a whereArg to prevent SQL injection.
//       whereArgs: [song.name],
//     );
//   }

//   Future<void> deleteSong(String name) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Remove the Song from the Database.
//     await db.delete(
//       'songs',
//       // Use a `where` clause to delete a specific dog.
//       where: "id = ?",
//       // Pass the Song's name as a whereArg to prevent SQL injection.
//       whereArgs: [name],
//     );
//   }
}
