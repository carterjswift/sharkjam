import 'package:flutter/material.dart';
import 'song.dart';

void main() {
  runApp(MaterialApp(
    home: PlayList(),
  ));
}

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  //create a stateful list for now
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

  //method that creates the row of the name of the song, 
  //duration and bump-up button
  Widget songInfo(song) {
    Song songLocal = new Song();
    songLocal = song;

    return Card(
      color: Colors.blueGrey[900],
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
        backgroundColor: Colors.blueGrey[900],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            //leading: Icon(Icons.arrow_back),
            title: Text(
              'your playlist',
            ),
            backgroundColor: Colors.blueGrey[900],
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  child: GestureDetector(
                      onTap: () {
                        print('+');
                      },
                      child: Icon(Icons.add)),
                  padding: EdgeInsets.symmetric(horizontal: 16.0))
            ],
          ),
        ),
        body: Scrollbar(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: songs.map((song) => songInfo(song)).toList(),
        )));
  }
}
