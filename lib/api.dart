// import 'package:youtube_api/youtube_api.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// //initializes api with auth key
// Future<YoutubeAPI> initAPI() async {
//   await DotEnv().load(".env");
//   String key = DotEnv().env["KEY"];
//   return new YoutubeAPI(key, maxResults: 15, type: "video");
// }

// //A simple class for keeping track of video properties
// class Video {
//   String title;
//   String id;
//   String channel;
//   String url;

//   Video(
//     this.title,
//     this.id,
//     this.channel,
//     this.url,
//   );
// }

// //searches for a query and returns 15 video results in a list
// Future<List<Video>> search(String q, YoutubeAPI api) async {
//   List<YT_API> ytResult = [];
//   List<Video> results = [];

//   ytResult = await api.search(q);

//   ytResult.forEach((YT_API vid) {
//     results.add(new Video(
//       vid.title,
//       vid.id,
//       vid.channelTitle,
//       vid.url,
//     ));
//   });

//   return results;
// }

// class VidResult extends StatefulWidget {
//   @override
//   _VidResultState createState() => _VidResultState();
// }

// class _VidResultState extends State<VidResult> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// //Test main
// void main() async {
//   //initialize api
//   final ytapi = await initAPI();

//   //search and wait for results
//   var stuff = await search(
//     "despacito",
//     ytapi,
//   );

//   //loop through results and print title to console
//   stuff.forEach((element) {
//     print(element.title);
//   });
// }



// Song(name: 'On the Run', duration: '3:35'),
// Song(name: 'Dont You worry Child', duration: '3:23'),
// Song(name: 'Window', duration: '4:45'),
// Song(name: 'Summer', duration: '3:25'),
// Song(name: 'Blah Blah Blah', duration: '4:52'),
// Song(name: 'Hello World', duration: '5:43'),
// Song(name: 'Ocean', duration: '7:34'),
// Song(name: 'Wallet', duration: '4:32'),
// Song(name: 'Minions', duration: '1:30'),
// Song(name: 'I Dont Care', duration: '3:52'),
// Song(name: 'Powder', duration: '7:11'),
// Song(name: 'Remember', duration: '4:53'),
// Song(name: 'Beautiful People', duration: '6:32'),
// Song(name: 'The Grand Finale', duration: '4:42'),
// Song(name: 'On the Run', duration: '3:35'),
// Song(name: 'Dont You worry Child', duration: '3:23'),
// Song(name: 'Window', duration: '4:45'),
// Song(name: 'Summer', duration: '3:25'),
// Song(name: 'Blah Blah Blah', duration: '4:52'),
// Song(name: 'Hello World', duration: '5:43'),
// Song(name: 'Ocean', duration: '7:34'),
// Song(name: 'Wallet', duration: '4:32'),
// Song(name: 'Minions', duration: '1:30'),
// Song(name: 'I Dont Care', duration: '3:52'),
// Song(name: 'Powder', duration: '7:11'),
// Song(name: 'Remember', duration: '4:53'),
// Song(name: 'Beautiful People', duration: '6:32'),
// Song(name: 'The Grand Finale', duration: '4:42'),
// Song(name: 'On the Run', duration: '3:35'),
// Song(name: 'Dont You worry Child', duration: '3:23'),
// Song(name: 'Window', duration: '4:45'),
// Song(name: 'Summer', duration: '3:25'),
// Song(name: 'Blah Blah Blah', duration: '4:52'),
// Song(name: 'Hello World', duration: '5:43'),
// Song(name: 'Ocean', duration: '7:34'),
// Song(name: 'Wallet', duration: '4:32'),
// Song(name: 'Minions', duration: '1:30'),
// Song(name: 'I Dont Care', duration: '3:52'),
// Song(name: 'Powder', duration: '7:11'),
// Song(name: 'Remember', duration: '4:53'),
// Song(name: 'Beautiful People', duration: '6:32'),
// Song(name: 'The Grand Finale', duration: '4:42'),
// Song(name: 'On the Run', duration: '3:35'),
// Song(name: 'Dont You worry Child', duration: '3:23'),
// Song(name: 'Window', duration: '4:45'),
// Song(name: 'Summer', duration: '3:25'),
// Song(name: 'Blah Blah Blah', duration: '4:52'),
// Song(name: 'Hello World', duration: '5:43'),
// Song(name: 'Ocean', duration: '7:34'),
// Song(name: 'Wallet', duration: '4:32'),
// Song(name: 'Minions', duration: '1:30'),
// Song(name: 'I Dont Care', duration: '3:52'),
// Song(name: 'Powder', duration: '7:11'),
// Song(name: 'Remember', duration: '4:53'),
// Song(name: 'Beautiful People', duration: '6:32'),
// Song(name: 'The Grand Finale', duration: '4:42'),


  //Method that creates the row of the name of the song,
  //duration and bump-up button.
  // Widget VideoInfo(song) {
  //   Video videoLocal = new Video();
  //   videoLocal = song;

  //   return Card(
  //     color: Color(0xFF261D1D),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: <Widget>[
  //         Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
  //         GestureDetector(
  //           child: Container(
  //             child: Align(
  //               child: Text(videoLocal.title,
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                   )),
  //               alignment: Alignment.centerLeft,
  //             ),
  //             width: 320,
  //             height: 50,
  //           ),
  //           onTap: () {
  //             print('play the song');
  //             navigateToMusicControl(context);
  //           },
  //         ),
  //         Container(
  //           child: Text(videoLocal.duration,
  //               style: TextStyle(
  //                 color: Colors.white,
  //               )),
  //         ),
  //         Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
  //         GestureDetector(
  //           child: Icon(
  //             Icons.arrow_drop_up,
  //             color: Colors.white,
  //           ),
  //           onTap: () {
  //             print('bump-up');
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

       // actions: <Widget>[
          //   Padding(
          //       child: GestureDetector(
          //           onTap: () {
          //             print('+');
          //             natigateToSearchMusic(context);
          //           },
          //           child: Icon(Icons.add)),
          //       padding: EdgeInsets.symmetric(horizontal: 16.0))
          // ],


// body: Scrollbar(
//     child: ListView(
//   scrollDirection: Axis.vertical,
//   children: videos.map((song) => VideoInfo(song)).toList(),
// )));

//Method that navigates from playlist screen to searchmusic screen
// Future navigateToSearchMusic(context) async {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => SearchMusic()));
// }

//searchmusic screen
// class SearchMusic extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF261D1D),
//       appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: const Color(0xFF261D1D),
//           leading: BackButton(
//             color: Colors.white,
//           ),
//           title: Text("Add Music",
//               style: TextStyle(color: Colors.white, fontSize: 25.0)),
//           centerTitle: true,
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   showSearch(context: context, delegate: DataSearch());
//                 })
//           ]),
//     );
//   }
// }

// class Video {
//   String title;
//   String id;
//   String channel;
//   String url;

//   Video(
//     this.title,
//     this.id,
//     this.channel,
//     this.url,
//   );
// }

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