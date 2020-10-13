class Video {
  String title;
  String id;
  String channel;
  String duration;

  Video({this.title, this.channel, this.id, this.duration});

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
