import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';
import 'song.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'api.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

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
  


