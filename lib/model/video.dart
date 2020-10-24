import 'model.dart';
import 'package:meta/meta.dart';

class Video extends Model {
  static String table = "videos_database";

  String id;
  String title;
  String channel;
  String duration;
  int playListIndex;

  Video(
      {@required this.id,
      this.title,
      this.channel,
      this.duration,
      this.playListIndex});

  String get videoTitle {
    return title;
  }

  String get videoChannel {
    return channel;
  }

  String get videoID {
    return id;
  }

  String get videoDuration {
    return duration;
  }

  int get videoPlayListIndex {
    return playListIndex;
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

  set videoPlayListIndex(int index) {
    this.playListIndex = index;
  }

  //Method that returns a map that will be used in player class
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "channel": channel,
      "duration": duration,
      "playListIndex": playListIndex
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  //Method that returns a video Object from a map that will be used in player
  //class
  static Video fromMap(Map<String, dynamic> map) {
    final v = Video(
        id: map["id"],
        title: map["title"],
        channel: map["channel"],
        duration: map["duration"],
        playListIndex: map["playListIndex"]);
    return v;
  }
}
