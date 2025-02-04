class PlaylistTracks {
  final List<Track> tracks;

  PlaylistTracks({required this.tracks});

  factory PlaylistTracks.fromJson(Map<String, dynamic> json) {
    return PlaylistTracks(
      tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
    );
  }
}

class Track {
  final String? previewUrl;
  final List<String> availableMarkets;
  final bool explicit;
  final Album album;
  final List<Artist> artists;
  final String name;

  Track({
    required this.previewUrl,
    required this.availableMarkets,
    required this.explicit,
    required this.album,
    required this.artists,
    required this.name,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      previewUrl: json["preview_url"],
      availableMarkets: List<String>.from(json["available_markets"]),
      explicit: json["explicit"],
      album: Album.fromJson(json["album"]),
      artists: List<Artist>.from(
          json["artists"].map((x) => Artist.fromJson(x))),
      name: json["name"],
    );
  }
}

class Album {
  final String name;
  final List<Image> images;

  Album({
    required this.name,
    required this.images,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json["name"],
      images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );
  }
}

class Image {
  final String url;
  final int height;
  final int width;

  Image({
    required this.url,
    required this.height,
    required this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json["url"],
      height: json["height"],
      width: json["width"],
    );
  }
}

class Artist {
  final String name;

  Artist({required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(name: json["name"]);
  }
}
