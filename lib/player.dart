import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'song.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'api.dart';

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'song_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE songs (name TEXT, duration TEXT)",
      );
    },
    version: 1,
  );

  // Define a function that inserts songs into the database
  Future<void> insertSong(Song song) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Song into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same song is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'songs',
      song.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// A method that retrieves all the songs from the songs table.
  Future<List<Song>> songs() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Songs.
    final List<Map<String, dynamic>> maps = await db.query('songs');

    // Convert the List<Map<String, dynamic> into a List<Song>.
    return List.generate(maps.length, (i) {
      return Song(
        //id: maps[i]['id'],
        name: maps[i]['name'],
        duration: maps[i]['duration'],
      );
    });
  }

  Future<void> updateSong(Song song) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Song.
    await db.update(
      'songs',
      song.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Song's name as a whereArg to prevent SQL injection.
      whereArgs: [song.name],
    );
  }

  Future<void> deleteSong(String name) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Song from the Database.
    await db.delete(
      'songs',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Song's name as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }

  runApp(MaterialApp(
    home: PlayListMainScreen(),
  ));
}

//Create the main screen which is a playlist with add button
//that can nagivate users to searchMusic screen; if users click
//on the songs, the page will go to musicControl screen; a bump-up
//button that can prioritize song that users click on
class PlayListMainScreen extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

List<Song> songs = [
  Song(name: 'On the Run', duration: '3:35'),
  Song(name: 'Dont You worry Child', duration: '3:23'),
  Song(name: 'Window', duration: '4:45'),
  Song(name: 'Summer', duration: '3:25'),
  Song(name: 'Blah Blah Blah', duration: '4:52'),
  Song(name: 'Hello World', duration: '5:43'),
  Song(name: 'Ocean', duration: '7:34'),
  Song(name: 'Wallet', duration: '4:32'),
  Song(name: 'Minions', duration: '1:30'),
  Song(name: 'I Dont Care', duration: '3:52'),
  Song(name: 'Powder', duration: '7:11'),
  Song(name: 'Remember', duration: '4:53'),
  Song(name: 'Beautiful People', duration: '6:32'),
  Song(name: 'The Grand Finale', duration: '4:42'),
  Song(name: 'On the Run', duration: '3:35'),
  Song(name: 'Dont You worry Child', duration: '3:23'),
  Song(name: 'Window', duration: '4:45'),
  Song(name: 'Summer', duration: '3:25'),
  Song(name: 'Blah Blah Blah', duration: '4:52'),
  Song(name: 'Hello World', duration: '5:43'),
  Song(name: 'Ocean', duration: '7:34'),
  Song(name: 'Wallet', duration: '4:32'),
  Song(name: 'Minions', duration: '1:30'),
  Song(name: 'I Dont Care', duration: '3:52'),
  Song(name: 'Powder', duration: '7:11'),
  Song(name: 'Remember', duration: '4:53'),
  Song(name: 'Beautiful People', duration: '6:32'),
  Song(name: 'The Grand Finale', duration: '4:42'),
  Song(name: 'On the Run', duration: '3:35'),
  Song(name: 'Dont You worry Child', duration: '3:23'),
  Song(name: 'Window', duration: '4:45'),
  Song(name: 'Summer', duration: '3:25'),
  Song(name: 'Blah Blah Blah', duration: '4:52'),
  Song(name: 'Hello World', duration: '5:43'),
  Song(name: 'Ocean', duration: '7:34'),
  Song(name: 'Wallet', duration: '4:32'),
  Song(name: 'Minions', duration: '1:30'),
  Song(name: 'I Dont Care', duration: '3:52'),
  Song(name: 'Powder', duration: '7:11'),
  Song(name: 'Remember', duration: '4:53'),
  Song(name: 'Beautiful People', duration: '6:32'),
  Song(name: 'The Grand Finale', duration: '4:42'),
  Song(name: 'On the Run', duration: '3:35'),
  Song(name: 'Dont You worry Child', duration: '3:23'),
  Song(name: 'Window', duration: '4:45'),
  Song(name: 'Summer', duration: '3:25'),
  Song(name: 'Blah Blah Blah', duration: '4:52'),
  Song(name: 'Hello World', duration: '5:43'),
  Song(name: 'Ocean', duration: '7:34'),
  Song(name: 'Wallet', duration: '4:32'),
  Song(name: 'Minions', duration: '1:30'),
  Song(name: 'I Dont Care', duration: '3:52'),
  Song(name: 'Powder', duration: '7:11'),
  Song(name: 'Remember', duration: '4:53'),
  Song(name: 'Beautiful People', duration: '6:32'),
  Song(name: 'The Grand Finale', duration: '4:42'),
];

class _PlayListState extends State<PlayListMainScreen> {
  //Create a stateful list for now
  // Moved to above so it can be referenced in other classes.

  //Method that creates the row of the name of the song,
  //duration and bump-up button.
  Widget songInfo(song) {
    Song songLocal = new Song();
    songLocal = song;

    return Card(
      color: Color(0xFF261D1D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          GestureDetector(
            child: Container(
              child: Align(
                child: Text(songLocal.name,
                    style: TextStyle(
                      color: Colors.white,
                    )),
                alignment: Alignment.centerLeft,
              ),
              width: 320,
              height: 50,
            ),
            onTap: () {
              print('play the song');
              navigateToMusicControl(context);
            },
          ),
          Container(
            child: Text(songLocal.duration,
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          GestureDetector(
            child: Icon(
              Icons.arrow_drop_up,
              color: Colors.white,
            ),
            onTap: () {
              print('bump-up');
            },
          ),
        ],
      ),
    );
  }

  //playlist screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF261D1D),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            //leading: Icon(Icons.arrow_back),
            title: Text(
              'your playlist',
            ),
            backgroundColor: Color(0xFF261D1D),
            centerTitle: true,
            actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
            ]),
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
          ),
        
        body: Scrollbar(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: songs.map((song) => songInfo(song)).toList(),
        )));
  }
}

//Method that navigates from playlist screen to searchmusic screen
// Future navigateToSearchMusic(context) async {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => SearchMusic()));
// }

//Method that navigates from playlist screen to musiccontrol screen
Future navigateToMusicControl(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MusicControl()));
}

//searchmusic screen
class SearchMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261D1D),
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFF261D1D),
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text("Add Music",
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ]),
    );
  }
}

class Video {
  String title;
  String id;
  String channel;
  String url;

  Video(
      this.title,
      this.id,
      this.channel,
      this.url,
      );
}
List<YT_API> ytResult = [];
List<Video> results = [];
Future<List<Video>> search(String q, YoutubeAPI api) async {

  ytResult = await api.search(q);   // Perhaps this is taking too long?

  ytResult.forEach((YT_API vid) {
    // print(vid.title);             // Test
    results.add(new Video(        // Add video data to results[]
      vid.title,
      vid.id,
      vid.channelTitle,
      vid.url,
    ));
  });
  print("ytResult length is " + ytResult.length.toString());  // Test
  return results;
}

class DataSearch extends SearchDelegate<String> {
  static String key = "AIzaSyDtm8y4FrVMUEeTSFV1e98D1OHB7MeLb9k";
  YoutubeAPI ytApi = YoutubeAPI(key);

  final music = [
    "On The Run", // Should be replaced with a list of available youTube video names
    "Wake Me Up",
    "We Are The World"
  ];

  final recentMusic = [
    "On The Run", // Will be replaced with recent music names
    "Wake Me Up",
    "We Are The World"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // Future<List<Video>> results = search(query, ytApi);
    search(query, ytApi);
    print("Submission successfully returned buildResults");   // Should be printed everytime query is entered.
    ytResult.forEach((YT_API vid) {
      print(vid.title); // Test whether ytResult is updated at this point => Nope it's not. The size is correct though.
    });
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Youtube API'),
      // ),
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(index),   // Not sure why but search result is not affected until second enter.
        ),
      ),
    );
    // Create a list of cards by looping through the list, retrieving information and arranging them.
    // for (Video vid in results)
    // print(results);
  }

  ///
  /// Code copied from youtube_api page.
  ///
  Widget listItem(index) {
    print("code run has reached listItem");
    return Card(
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 20.0)),
              Image.network(
                ytResult[index].thumbnail['default']['url'],
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          ytResult[index].title,
                          softWrap: true,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 1.5)),
                        Text(
                          ytResult[index].channelTitle,
                          softWrap: true,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 3.0)),
                        Text(
                          ytResult[index].url,
                          softWrap: true,
                        ),
                      ]))
            ],
          ),
        ),
        onTap: () {
          print('Add Song');
          Song song = new Song(name: ytResult[index].title, duration: ytResult[index].duration);
          songs.add(song);
          print(songs.elementAt(songs.length-1).songName);
          // navigateToMusicControl(context);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentMusic : music.where((p) => p.startsWith(query)).toList();
    // search(query, ytApi);       // If this doesn't work, I don't know what else would.
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: (){
            showResults(context);
          },

          leading: Icon(Icons.music_note),
          title: RichText(text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(color: Colors.grey)
              )
            ]
          ),
        ),
      ),
    itemCount: suggestionList.length,
    );
  }
}

//musiccontrol screen
class MusicControl extends StatefulWidget {
  @override
  _MusicControlState createState() => _MusicControlState();
}

class _MusicControlState extends State<MusicControl> {
  List<Video> songs = [
    Video("maple leaf rag", "ZYqy7pBqbw4", "Scott Joplin", ""),
    Video("Medallo City", "XKjpVgpXoLI", "Maluma", ""),
    Video("Bohemian Rhapsody", "fJ9rUzIMcZQ", "Queen", ""),
  ];
  YoutubePlayerController _controller;
  YoutubePlayer _player;
  YoutubePlayerFlags flags = YoutubePlayerFlags(autoPlay: false);
  int currentSongIndex = 0;
  bool isPlaying = false;

  void toggle() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  void playNewSong(int songIndex) {
    setState(() {
      if (songIndex >= songs.length) {
        songIndex = 0;
      } else if (songIndex < 0) {
        songIndex = songs.length - 1;
      }
      currentSongIndex = songIndex;
      print(currentSongIndex);
      _controller.cue(songs[currentSongIndex].id);
    });

    if (isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  void playAfterEnd(YoutubeMetaData _) {
    playNext();
  }

  void playNext() {
    playNewSong(currentSongIndex + 1);
  }

  void playPrev() {
    playNewSong(currentSongIndex - 1);
  }

  _MusicControlState() {
    _controller = YoutubePlayerController(
      initialVideoId: songs[currentSongIndex].id,
      flags: flags,
    );
    _player = YoutubePlayer(
        controller: _controller,
        width: 0,
        onReady: () {
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261D1D),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF261D1D),
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text("Music Player", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _player,
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Image(
                image: NetworkImage(YoutubePlayer.getThumbnail(
                    videoId: songs[currentSongIndex].id))),
          ),
          Container(
              child: Text(
                  songs[currentSongIndex]
                      .title, // Will be replaced with music title.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 30.0,
                  ))),
          Container(
              child: Text(
                  songs[currentSongIndex]
                      .channel, // Will be replaced with music artist.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 20.0,
                  ))),
          Container(
              // child: Slider              // Will implement slider later.
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: IconButton(
                  icon: Image.asset(
                    "assets/back.png",
                    color: Colors.white,
                  ),
                  iconSize: 120,
                  onPressed: () {
                    playPrev();
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Image.asset(
                    isPlaying ? "assets/pause.png" : "assets/play.png",
                    color: Colors.white,
                  ),
                  iconSize: 120,
                  onPressed: () {
                    toggle();
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Image.asset(
                    "assets/forward.png",
                    color: Colors.white,
                  ),
                  iconSize: 120,
                  onPressed: () {
                    playNext();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
