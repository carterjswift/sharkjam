import 'package:youtube_api/youtube_api.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//initializes api with auth key
Future<YoutubeAPI> initAPI() async {
  await DotEnv().load(".env");
  String key = DotEnv().env["KEY"];
  return new YoutubeAPI(key, maxResults: 15, type: "video");
}

//A simple class for keeping track of video properties
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

//searches for a query and returns 15 video results in a list
Future<List<Video>> search(String q, YoutubeAPI api) async {
  List<YT_API> ytResult = [];
  List<Video> results = [];

  ytResult = await api.search(q);

  ytResult.forEach((YT_API vid) {
    results.add(new Video(
      vid.title,
      vid.id,
      vid.channelTitle,
      vid.url,
    ));
  });

  return results;
}

class VidResult extends StatefulWidget {
  @override
  _VidResultState createState() => _VidResultState();
}

class _VidResultState extends State<VidResult> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//Test main
void main() async {
  //initialize api
  final ytapi = await initAPI();

  //search and wait for results
  var stuff = await search(
    "despacito",
    ytapi,
  );

  //loop through results and print title to console
  stuff.forEach((element) {
    print(element.title);
  });
}
