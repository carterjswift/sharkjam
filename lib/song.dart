class Song {
  final String name;
  final String duration; // String type for now

  String get songname {
    return name;
  }

  String get songduration {
    return duration;
  }

  set songname(String name) {
    this.songname = name;
  }

  set songduration(String duration) {
    this.songduration = duration;
  }

  Song({this.name, this.duration});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
    };
  }
}
