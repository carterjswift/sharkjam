import 'package:flutter/material.dart';
import 'song.dart';

void main() {
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

class _PlayListState extends State<PlayListMainScreen> {
  //Create a stateful list for now
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
              natigateToMusicControl(context);
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
// Future natigateToSearchMusic(context) async {
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => SearchMusic()));
// }

//Method that navigates from playlist screen to musiccontrol screen
Future natigateToMusicControl(context) async {
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

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "On The Run", // Will be replaced with a list of available music name
    "Wake Me Up",
    "We Are The World"
  ];

  final recentCities = [
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
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? recentCities : cities;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.music_note),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}

//musiccontrol screen
class MusicControl extends StatelessWidget {
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
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: Image(
                image: NetworkImage(
              "https://upload.wikimedia.org/wikipedia/en/3/3b/Dark_Side_of_the_Moon.png",
              scale: 0.9,
            )),
          ),
          Container(
              child: Text("On The Run", // Will be replaced with music title.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 30.0,
                  ))),
          Container(
              child: Text("Pink Floyd", // Will be replaced with music artist.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 20.0,
                  ))),
          Container(
              // child: Slider              // Will implement slider later.
              ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 20.0, 0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/back.png",
                      color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/pause.png",
                      color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/forward.png",
                      color: Colors.white,
                    ),
                    iconSize: 120,
                    onPressed: () {},
                  ),
                ],
              ))
        ],
      ),
    );
  }
}