import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';
import 'database_provider.dart';
import 'model/video.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseProvider.init();

  runApp(MaterialApp(
    home: PlayListMainScreen(),
  ));
}

String _videoId;
String _title;
String _channel;
String _duration;
int videoIndex;

Future<bool> checkSong(YT_API vid) async {
  List<Map<String, dynamic>> results =
      await DatabaseProvider.query(Video.table);
  List playList = results.map((video) => Video.fromMap(video)).toList();

  bool hadSong;

  playList.forEach((element) {
    if (vid.id == element.id) {
      hadSong = true;
    } else {
      hadSong = false;
    }
  });

  return hadSong;
}

//Create the main screen which is a playlist with add button
//that can nagivate users to searchMusic screen; if users click
//on the songs, the page will go to musicControl screen; a bump-up
//button that can prioritize song that users click on
class PlayListMainScreen extends StatefulWidget {
  PlayListMainScreen({Key key}) : super(key: key);

  @override
  _PlayListState createState() => _PlayListState();
}

//Method that creates the row of the name of the song,
//duration and bump-up button.
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
            navigateToMusicControl(context, video.id, video.playListIndex);
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

class _PlayListState extends State<PlayListMainScreen> {
  List<Video> videoPlaylist = [];
  List<Widget> videos = [];

  @override
  void initState() {
    updateVideoPlaylist();
    super.initState();
  }

  void addVideoToList() async {
    Video videoToAdd = Video(
        id: _videoId, title: _title, channel: _channel, duration: _duration, playListIndex: videoIndex);

    await DatabaseProvider.insert(Video.table, videoToAdd);

    _videoId = '';
    _title = '';
    _channel = '';
    _duration = '';

    updateVideoPlaylist();
  }

  void deleteVideoFromList(Video videoDeleted) async {
    await DatabaseProvider.delete(Video.table, videoDeleted);
    updateVideoPlaylist();
  }

  void updateVideoPlaylist() async {
    List<Map<String, dynamic>> results =
        await DatabaseProvider.query(Video.table);
    setState(() {
      videoPlaylist = results.map((video) {
        final v = Video.fromMap(video);
        return v;
      }).toList();
      videos = videoPlaylist.map((video) => singleVidWidget(video)).toList();
    });
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

  List<Video> VideoPlaylist() {
    // List<Map<String, dynamic>> results =
    //     await DatabaseProvider.query(Video.table);
    // setState(() {
    //   videoPlaylist = results.map((video) {
    //     final v = Video.fromMap(video);
    //     return v;
    //   }).toList();
    //   videos = videoPlaylist.map((video) => singleVidWidget(video)).toList();
    // });
    return videoPlaylist;
  }
}

//Method that navigates from playlist screen to musiccontrol screen
Future navigateToMusicControl(context, String id, int index) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MusicControl(index)));
}

class DataSearch extends SearchDelegate<String> {
  bool added = false;
  List<YT_API> ytResult = [];
  List<Video> results = [];

  final VoidCallback onAdded;

  DataSearch({@required this.onAdded});

  Future<List<Video>> search(String q, YoutubeAPI api) async {
    ytResult = await api.search(q); // Perhaps this is taking too long?

    ytResult.forEach((YT_API vid) {
      // print(vid.title);             // Test
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

  static String key = "AIzaSyDh-dsq8nTAqLnAsf3fTPIXssCchV4lmT0";
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
    // Future<List<Video>> results = search(query, ytApi);
    search(query, ytApi);
    print(
        "Submission successfully returned buildResults"); // Should be printed everytime query is entered.
    ytResult.forEach((YT_API vid) {
      print(vid
          .title); // Test whether ytResult is updated at this point => Nope it's not. The size is correct though.
    });
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Youtube API'),
      // ),
      backgroundColor: const Color(0xFF261D1D),
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(index,
              context), // Not sure why but search result is not affected until second enter.
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
                        // Text(
                        //   ytResult[index].url,
                        //   softWrap: true,
                        // ),
                      ])),
                  Padding(padding: EdgeInsets.all(5)),
                  RaisedButton(
                    //onPressed: () {
                    //if (await checkSong(ytResult[index]) ) {
                    //print("no song");
                    child: Icon(Icons.add),
                    onPressed: () {
                      _title = ytResult[index].title;
                      _videoId = ytResult[index].id;
                      _channel = ytResult[index].channelTitle;
                      _duration = ytResult[index].duration;
                      videoIndex = PlayListMainScreen()
                              .createState()
                              .videoPlaylist
                              .length + 1;
                      onAdded();
                      setState(() {
                        new Icon(Icons.check);
                      });
                    },
                    // }
                  ),
                  // } else if (await checkSong(ytResult[index]) == true) {
                  //   setState(() {
                  //   added = false;
                  //  });
                  // }
                  // },
                  //child:
                  //added ? new Icon(Icons.check) : new Icon(Icons.add))
                ],
              ),
            ),
            onTap: () {
              // print('Add Song');
              // Video video = new Video(
              //     id:
              //     title: ytResult[index].title,
              //     duration: ytResult[index].duration);
              // //videos.add(video);
              // //print(videos.elementAt(videos.length - 1).title);
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
    // search(query, ytApi);       // If this doesn't work, I don't know what else would.
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

//musiccontrol screen
class MusicControl extends StatefulWidget {
  int index;
  MusicControl(this.index);

  @override
  _MusicControlState createState() => _MusicControlState(index);
}

class _MusicControlState extends State<MusicControl> {
  int currentSongIndex;

  List<Video> videoList = PlayListMainScreen().createState().videoPlaylist;

  _MusicControlState(this.currentSongIndex) {
    _controller = YoutubePlayerController(
      initialVideoId: videoList[currentSongIndex].id,
      flags: flags,
    );
    _player = YoutubePlayer(
        controller: _controller,
        width: 0,
        onReady: () {
          setState(() {});
        });
  }

  YoutubePlayerController _controller;
  YoutubePlayer _player;
  YoutubePlayerFlags flags = YoutubePlayerFlags(autoPlay: false);
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

  void playAfterEnd(YoutubeMetaData _) {
    playNext();
  }

  void playNext() {
    playNewSong(currentSongIndex + 1);
  }

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