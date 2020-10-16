import 'model.dart';
import 'package:meta/meta.dart';

class Video extends Model {
  static String table = "videos_database";

  String id;
  String title;
  //String videoId;
  String channel;
  String duration;

  Video({
    @required this.id,
    this.title,
    //this.videoId,
    this.channel,
    this.duration,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      //"videoId": videoId,
      "channel": channel,
      "duration": duration,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Video fromMap(Map<String, dynamic> map) {
    final v = Video(
      id: map["id"],
      title: map["title"],
      //videoId: map["videoId"],
      channel: map["channel"],
      duration: map["duration"],
    );
    return v;
  }

  // String get videoTitle {
  //   return title;
  // }

  // String get videoChannel {
  //   return channel;
  // }

  // String get videoID {
  //   return id;
  // }

  // String get videoDuration {
  //   return duration;
  // }

  // set videoTitle(String title) {
  //   this.title = title;
  // }

  // set videoChannel(String channel) {
  //   this.channel = channel;
  // }

  // set videoID(String id) {
  //   this.id = id;
  // }

  // set videoURL(String duration) {
  //   this.duration = duration;
  // }
}
