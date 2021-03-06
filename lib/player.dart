import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'database_provider.dart';
import 'model/video.dart';

//Global key to allow access to Playlist Screen instance variables
final playListKey = new GlobalKey<_PlayListState>();

//Key for the Youtube Data API v3
var apiKey;

void main() async {
  //Method that ensures the Flutter app initializes properly while initializing
  //the database with await DB.init()
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseProvider.init();

  //Load api key from .env
  await DotEnv().load(".env");
  apiKey = DotEnv().env["KEY"];

  runApp(MaterialApp(
      home: PlayListMainScreen(
    key: playListKey,
  )));
}

//Instance variables that can be accessed from different classes, especially
//used in Datasearch class when calling addVidToList() method
String _videoId;
String _title;
String _channel;
String _duration;
int _videoIndex;

//Class that creates the main screen which is a playlist with add-button that
//can nagivate users to searchMusic screen; if users click on the songs, the
//page will go to musicControl screen; a bump-up button that can prioritize
//songs that users click on
class PlayListMainScreen extends StatefulWidget {
  PlayListMainScreen({Key key}) : super(key: key);

  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayListMainScreen> {
  List<Video> _videoPlaylist = [];
  List<Widget> videos = [];
  List<Video> get videoPlaylist => _videoPlaylist;

//Method that ensures the playlist can update all the time the app is running
  @override
  void initState() {
    updateVideoPlaylist();
    super.initState();
  }

//Method that adds one video object to the database
  void addVideoToList() async {
    Video videoToAdd = Video(
        id: _videoId,
        title: _title,
        channel: _channel,
        duration: _duration,
        playListIndex: _videoIndex);

    await DatabaseProvider.insert(Video.table, videoToAdd);

    _videoId = '';
    _title = '';
    _channel = '';
    _duration = '';

    updateVideoPlaylist();
  }

//Method that deletes one video object from the database
  void deleteVideoFromList(Video videoDeleted) async {
    await DatabaseProvider.delete(Video.table, videoDeleted);
    updateVideoPlaylist();
  }

//Method that updates the playlist List by importing data from the database
  void updateVideoPlaylist() async {
    List<Map<String, dynamic>> results =
        await DatabaseProvider.query(Video.table);
    setState(() {
      _videoPlaylist = results.map((video) {
        final v = Video.fromMap(video);
        return v;
      }).toList();
      videos = videoPlaylist.map((video) => singleVidWidget(video)).toList();
    });
  }

  //Method that creates one row of the name of the song, duration and bump-up
  //button
  Widget singleVidWidget(video) {
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
                child: Text(video.title,
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
              // dont know how to get "Buildcontext"
              navigateToMusicControl(context, video.id, video.playListIndex);
              print(video.id);
              print(video.playListIndex);
            },
          ),
          Container(
            child: Text(video.duration == null ? "-00:00" : video.duration,
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
                      showSearch(
                          context: context,
                          delegate: DataSearch(onAdded: this.addVideoToList));
                    })
              ]),
        ),
        body: Scrollbar(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: videos,
        )));
  }
}

//Method that navigates from playlist screen to musicControl screen
Future navigateToMusicControl(context, String id, int index) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MusicControl(index)));
}

//Class that creates a search page with search box, which is the searchMusic
//screen
class DataSearch extends SearchDelegate<String> {
  bool added = false;
  List<YT_API> ytResult = [];
  List<Video> results = [];

  final VoidCallback onAdded;

  DataSearch({@required this.onAdded});

  Future<List<Video>> search(String q, YoutubeAPI api) async {
    ytResult = await api.search(q); // Perhaps this is taking too long?

    ytResult.forEach((YT_API vid) {
      results.add(new Video(
        // Add video data to results[]
        id: vid.id,
        title: vid.title,
        channel: vid.channelTitle,
        duration: vid.duration,
      ));
    });
    print("ytResult length is " + ytResult.length.toString()); // Test
    return results;
  }

  static String key = apiKey;
  YoutubeAPI ytApi = YoutubeAPI(key);

  final music = ["On The Run", "Wake Me Up", "We Are The World"];

  final recentMusic = ["On The Run", "Wake Me Up", "We Are The World"];

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

  //Widget that create a list of cards by looping through the list, retrieving
  //information and arranging them.
  @override
  Widget buildResults(BuildContext context) {
    search(query, ytApi);
    print("Submission successfully returned buildResults");
    ytResult.forEach((YT_API vid) {
      print(vid.title);
    });
    return Scaffold(
      backgroundColor: const Color(0xFF261D1D),
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(index, context),
        ),
      ),
    );
  }

  ///
  /// Code referenced from youtube_api example page.
  ///
  Widget listItem(index, context) {
    print("code run has reached listItem");

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Card(
          child: GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 7.0),
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 15.0)),
                  Image.network(
                    ytResult[index].thumbnail['default']['url'],
                  ),
                  Padding(padding: EdgeInsets.all(8)),
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
                      ])),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _title = ytResult[index].title;
                      _videoId = ytResult[index].id;
                      _channel = ytResult[index].channelTitle;
                      _duration = ytResult[index].duration;
                      _videoIndex =
                          playListKey.currentState.videoPlaylist.length;
                      print(_videoIndex);
                      onAdded();
                      setState(() {
                        new Icon(Icons.check);
                      });
                    },
                  ),
                ],
              ),
            ),
            onTap: () {
              navigateToMusicControl(context, ytResult[index].id, index);
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentMusic
        : music.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.music_note),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

//Class that creates a musicControl screen
class MusicControl extends StatefulWidget {
  int index;
  MusicControl(this.index);

  @override
  _MusicControlState createState() => _MusicControlState(index);
}

class _MusicControlState extends State<MusicControl> {
  int currentSongIndex;

  // get the playlist from the playlist screen
  List<Video> videoList = playListKey.currentState.videoPlaylist;

  //Start the player at the selected song index
  _MusicControlState(index) {
    //change here
    this.currentSongIndex = index;
    print(index);
    _controller = YoutubePlayerController(
      initialVideoId: videoList[currentSongIndex].id,
      flags: flags,
    );

    //Initialize the video player
    _player = YoutubePlayer(
        controller: _controller,
        width: 0, // don't display video
        onReady: () {
          setState(() {});
        });
  }

  YoutubePlayerController _controller;
  YoutubePlayer _player;
  YoutubePlayerFlags flags = YoutubePlayerFlags(autoPlay: false);
  bool isPlaying = false;

  //Toggle between playing and pausing
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

  //Play a song given the index in the playlist
  void playNewSong(int songIndex) {
    setState(() {
      if (songIndex >= videoList.length) {
        songIndex = 0;
      } else if (songIndex < 0) {
        songIndex = videoList.length - 1;
      }
      currentSongIndex = songIndex;
      print(currentSongIndex);
      _controller.cue(videoList[currentSongIndex].id);
    });

    if (isPlaying) {
      _controller.play();
    } else {
      _controller.pause();
    }
  }

  //Automatically play next song after current song ends
  void playAfterEnd(YoutubeMetaData _) {
    playNext();
  }

  //Play next song
  void playNext() {
    playNewSong(currentSongIndex + 1);
  }

  //Play previous song
  void playPrev() {
    playNewSong(currentSongIndex - 1);
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
                    videoId: videoList[currentSongIndex].id))),
          ),
          Container(
              child: Text(
                  videoList[currentSongIndex]
                      .title, // Will be replaced with music title.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 30.0,
                  ))),
          Container(
              child: Text(
                  videoList[currentSongIndex]
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
