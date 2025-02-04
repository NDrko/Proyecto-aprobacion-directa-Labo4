// To parse this JSON data, do
//
//     final releases = releasesFromJson(jsonString);

import 'dart:convert';

Releases releasesFromJson(String str) => Releases.fromJson(json.decode(str));

String releasesToJson(Releases data) => json.encode(data.toJson());

class Releases {
  String status;
  List<Datum> data;

  Releases({
    required this.status,
    required this.data,
  });

  factory Releases.fromJson(Map<String, dynamic> json) => Releases(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  AlbumTypeEnum albumType;
  List<Artist> artists;
  List<String> availableMarkets;
  ExternalUrls externalUrls;
  String href;
  String id;
  List<Image> images;
  String name;
  DateTime releaseDate;
  ReleaseDatePrecision releaseDatePrecision;
  int totalTracks;
  AlbumTypeEnum type;
  String uri;

  Datum({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    albumType: albumTypeEnumValues.map[json["album_type"]]!,
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    name: json["name"],
    releaseDate: DateTime.parse(json["release_date"]),
    releaseDatePrecision: releaseDatePrecisionValues.map[json["release_date_precision"]]!,
    totalTracks: json["total_tracks"],
    type: albumTypeEnumValues.map[json["type"]]!,
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "album_type": albumTypeEnumValues.reverse[albumType],
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "available_markets": List<dynamic>.from(availableMarkets.map((x) => x)),
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "name": name,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
    "total_tracks": totalTracks,
    "type": albumTypeEnumValues.reverse[type],
    "uri": uri,
  };
}

enum AlbumTypeEnum {
  ALBUM,
  COMPILATION,
  EP,
  SINGLE
}

final albumTypeEnumValues = EnumValues({
  "album": AlbumTypeEnum.ALBUM,
  "compilation": AlbumTypeEnum.COMPILATION,
  "ep": AlbumTypeEnum.EP,
  "single": AlbumTypeEnum.SINGLE
});

class Artist {
  ExternalUrls externalUrls;
  String href;
  String id;
  String name;
  ArtistType type;
  String uri;

  Artist({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    externalUrls: ExternalUrls.fromJson(json["external_urls"]),
    href: json["href"],
    id: json["id"],
    name: json["name"],
    type: artistTypeValues.map[json["type"]]!,
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "external_urls": externalUrls.toJson(),
    "href": href,
    "id": id,
    "name": name,
    "type": artistTypeValues.reverse[type],
    "uri": uri,
  };
}

class ExternalUrls {
  String spotify;

  ExternalUrls({
    required this.spotify,
  });

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
    spotify: json["spotify"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify,
  };
}

enum ArtistType {
  ARTIST
}

final artistTypeValues = EnumValues({
  "artist": ArtistType.ARTIST
});

class Image {
  int height;
  String url;
  int width;

  Image({
    required this.height,
    required this.url,
    required this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    height: json["height"],
    url: json["url"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "url": url,
    "width": width,
  };
}

enum ReleaseDatePrecision {
  DAY
}

final releaseDatePrecisionValues = EnumValues({
  "day": ReleaseDatePrecision.DAY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
