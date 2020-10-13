import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'song.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'api.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

// class Video {
//   String title;
//   String id;
//   String channel;
//   String duration;

//   Video({this.title, this.channel, this.id, this.duration});

//   String get videoTitle {
//     return title;
//   }

//   String get videoChannel {
//     return channel;
//   }

//   String get videoID {
//     return id;
//   }

//   String get videoDuration{
//     return duration;
//   }

//   set videoTitle(String title) {
//     this.title = title;
//   }

//   set videoChannel(String channel) {
//     this.channel = channel;
//   }

//   set videoID(String id) {
//     this.id = id;
//   }

//   set videoURL(String duration) {
//     this.duration = duration;
//   }
// }

Video videoFromMap(String str) => Video.fromMap(json.decode(str));

String videoToMap(Video data) => json.encode(data.toMap());

class Video {

  Video({
    this.title,
    this.id,
    this.channel,
    this.duration,
  });

  String title;
  String id;
  String channel;
  String duration;
  

  factory Video.fromMap(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        channel: json["channel"],
        duration: json["duration"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "channel": channel,
        "duration": duration,
      };

  String get videoTitle {
    return title;
  }

  String get videoChannel {
    return channel;
  }

  String get videoID {
    return id;
  }

  String get videoDuration{
    return duration;
  }

  set videoTitle(String title) {
    this.title = title;
  }

  set videoChannel(String channel) {
    this.channel = channel;
  }

  set videoID(String id) {
    this.id = id;
  }

  set videoURL(String duration) {
    this.duration = duration;
  }
}
  

  // List<YT_API> ytResult = [];
  // List<Video> results = [];
  // Future<List<Video>> search(String q, YoutubeAPI api) async {
  // ytResult = await api.search(q); // Perhaps this is taking too long?

  // ytResult.forEach((YT_API vid) {
  //   // print(vid.title);             // Test
  //   results.add(new Video(
  //     // Add video data to results[]
  //     vid.title,
  //     vid.id,
  //     vid.channelTitle,
  //     vid.url,
  //   ));
  // });
  // print("ytResult length is " + ytResult.length.toString()); // Test
  // return results;


