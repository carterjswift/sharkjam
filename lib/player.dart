import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

List<Video> videosList = [
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
  Video(title: 'On the Run', channel: "VEVO US", id: "asdflsdfkjks", duration: '3:35'),
  Video(title: 'Dont You worry Child', channel: "VEVO Japan", id: "Yksf820Sk1l", duration: '3:23'),
];

class _PlayListState extends State<PlayListMainScreen> {
  //Create a stateful list for now
  // Moved to above so it can be referenced in other classes.

  //Method that creates the row of the name of the song,
  //duration and bump-up button.
  Widget videoInfo(song) {
    Video videoLocal = new Video();
    videoLocal = song;

    return Card(
      color: const Color(0xFF261D1D),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
          GestureDetector(
            child: Container(
              child: Align(
                child: Text(videoLocal.title,
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
              navigateToMusicControl(context, videoLocal.id);
            },
          ),
          Container(
            child: Text(videoLocal.duration,
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
        backgroundColor: const Color(0xFF261D1D),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            //leading: Icon(Icons.arrow_back),
            title: Text(
              'your playlist',
            ),
            backgroundColor: const Color(0xFF261D1D),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  child: GestureDetector(
                      onTap: () {
                        print('+');
                        navigateToSearchMusic(context);
                      },
                      child: Icon(Icons.add)),
                  padding: EdgeInsets.symmetric(horizontal: 16.0))
            ],
          ),
        ),
        body: Scrollbar(
            child: ListView(
          scrollDirection: Axis.vertical,
          children: videosList.map((video) => videoInfo(video)).toList(),
        )));
  }
}

//Method that navigates from playlist screen to searchmusic screen
Future navigateToSearchMusic(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SearchMusic()));
}

//Method that navigates from playlist screen to musiccontrol screen
Future navigateToMusicControl(context, String id) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MusicControl()));
  // TODO: Implement playing/retreiving music from ID.
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

List<YT_API> ytResult = [];
List<Video> results = [];
Future<List<Video>> search(String q, YoutubeAPI api) async {

  ytResult = await api.search(q);   // Perhaps this is taking too long?

  ytResult.forEach((YT_API vid) {
    // print(vid.title);             // Test
    results.add(new Video(        // Add video data to results[]
      title: vid.title,
      channel: vid.channelTitle,
      id: vid.id,
      duration: vid.duration,
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
      backgroundColor: const Color(0xFF261D1D),
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(index, context),   // Not sure why but search result is not affected until second enter.
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
    return Card(
      color: const Color(0xFF261D1D),
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 1.5)),
                        Text(
                          ytResult[index].channelTitle,
                          softWrap: true,
                          style: TextStyle(color: Colors.white),
                        ),
                        // Padding(padding: EdgeInsets.only(bottom: 3.0)),
                      ])),
              // Add Button/ Check
            ],
          ),
        ),
        onTap: () {
          print('Add Song');
          Video video = new Video(title: ytResult[index].title, channel: ytResult[index].channelTitle, id: ytResult[index].id, duration: ytResult[index].duration);
          videosList.add(video);
          print(videosList.elementAt(videosList.length-1).title);

          String vidID = ytResult[index].id;
          navigateToMusicControl(context, vidID);
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
  List<Video> videosList = [
    Video(title: "maple leaf rag", channel: "Jazz VEVO", id: "ZYqy7pBqbw4", duration: "3:44"),
    Video(title: "Medallo City", channel: "Classic VEVO", id: "XKjpVgpXoLI", duration: "5:44"),
    Video(title: "Bohemian Rhapsody", channel: "Rock VEVO", id: "fJ9rUzIMcZQ", duration: "2:44"),
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
      if (songIndex >= videosList.length) {
        songIndex = 0;
      } else if (songIndex < 0) {
        songIndex = videosList.length - 1;
      }
      currentSongIndex = songIndex;
      print(currentSongIndex);
      _controller.cue(videosList[currentSongIndex].id);
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
      initialVideoId: videosList[currentSongIndex].id,
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
                    videoId: videosList[currentSongIndex].id))),
          ),
          Container(
              child: Text(
                  videosList[currentSongIndex]
                      .title, // Will be replaced with music title.
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Roboto",
                    fontSize: 30.0,
                  ))),
          Container(
              child: Text(
                  videosList[currentSongIndex]
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
