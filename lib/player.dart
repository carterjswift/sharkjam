import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:async';
import 'video.dart';
import 'database_provider.dart';

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

Video currentVideo;

class _PlayListState extends State<PlayListMainScreen> {
  
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
        ),
        body: FutureBuilder<List<Video>>(
            future: DatabaseProvider.db.getAllVideos(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Video item = snapshot.data[index];
                    return ListTile(
                      title: Text(item.title),
                      leading: Text(item.duration.toString()),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

//Method that navigates from playlist screen to musiccontrol screen
Future navigateToMusicControl(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => MusicControl()));
}













List<YT_API> ytResult = [];
List<Video> results = [];
Future<List<Video>> search(String q, YoutubeAPI api) async {
  ytResult = await api.search(q); // Perhaps this is taking too long?

  ytResult.forEach((YT_API vid) {
    // print(vid.title);             // Test
    results.add(new Video(
      // Add video data to results[]
      title: vid.title,
      channel: vid.channelTitle,
      id: vid.id,
      duration: vid.duration,
    ));
  });
  print("ytResult length is " + ytResult.length.toString()); // Test
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
      body: Container(
        child: ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, int index) => listItem(
              index), // Not sure why but search result is not affected until second enter.
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
              GestureDetector(
                  child: Icon(Icons.add),
                  onTap: () {
                    DatabaseProvider.db.newVideo(new Video(
                        title: ytResult[index].description,
                        id: ytResult[index].channelId,
                        channel: ytResult[index].channelTitle,
                        duration: ytResult[index].duration));
                  })
            ],
          ),
        ),
        onTap: () {
          print('Add Song');
          Video video = new Video(
              title: ytResult[index].title, duration: ytResult[index].duration);
          //videos.add(video);
          //print(videos.elementAt(videos.length - 1).title);
          // navigateToMusicControl(context);
        },
      ),
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
  @override
  _MusicControlState createState() => _MusicControlState();
}

class _MusicControlState extends State<MusicControl> {
  List<Video> songs = [
    // Video("maple leaf rag", "ZYqy7pBqbw4", "Scott Joplin", ""),
    // Video("Medallo City", "XKjpVgpXoLI", "Maluma", ""),
    // Video("Bohemian Rhapsody", "fJ9rUzIMcZQ", "Queen", ""),
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
