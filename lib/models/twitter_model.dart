// To parse this JSON data, do
//
//     final twitterModel = twitterModelFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

TwitterModel twitterModelFromJson(String str) =>
    TwitterModel.fromJson(json.decode(str));

String twitterModelToJson(TwitterModel data) => json.encode(data.toJson());

class TwitterModel {
  TwitterModel({
    @required this.videos,
    @required this.state,
  });

  var videos;
  var state;

  factory TwitterModel.fromJson(Map<String, dynamic> json) => TwitterModel(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "state": state,
      };
}

class Video {
  Video({
    @required this.source,
    @required this.text,
    @required this.thumb,
    @required this.type,
    @required this.duration,
    @required this.bitrate,
    @required this.url,
    @required this.size,
  });

  var source;
  var text;
  var thumb;
  var type;
  int? duration;
  int? bitrate;
  var url;
  int? size;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        source: json["source"],
        text: json["text"],
        thumb: json["thumb"],
        type: json["type"],
        duration: json["duration"],
        bitrate: json["bitrate"],
        url: json["url"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "source": source,
        "text": text,
        "thumb": thumb,
        "type": type,
        "duration": duration,
        "bitrate": bitrate,
        "url": url,
        "size": size,
      };
}
