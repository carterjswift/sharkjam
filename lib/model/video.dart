import 'model.dart';


class Video extends Model {

  static String table = 'videos_database';

  String title;
  String id;
  String channel;
  String duration;

  Video({
    this.title,
    this.id,
    this.channel,
    this.duration,
  });


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "title": title,
      "id": id,
      "channel": channel,
      "duration": duration,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static Video fromMap(Map<String, dynamic> map) {
    return Video(
      title: map["title"],
      id: map["id"],
      channel: map["channel"],
      duration: map["duration"],
    );
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
