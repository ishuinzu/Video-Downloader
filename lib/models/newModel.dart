// ignore: file_names
import 'dart:convert';

NewApiParser NewApiParserFromJson(String str) => NewApiParser.fromJson(json.decode(str));

String NewApiParserToJson(NewApiParser data) => json.encode(data.toJson());

class NewApiParser {
  NewApiParser({
    this.url,
    this.videos,
  });

  var url;
  List<Video>? videos;

  factory NewApiParser.fromJson(Map<String, dynamic> json) => NewApiParser(
        url: json["url"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  Video({this.ext, this.extractor, this.extractorKey, this.filesize, this.format, this.formatId, this.formatNote, this.formats, this.thumbnail, this.title, this.uploadDate, this.url, this.duration});

  var duration;
  var ext;
  var extractor;
  var extractorKey;
  var filesize;
  var format;
  var formatId;
  var formatNote;
  List<Format>? formats;
  var thumbnail;
  var title;
  var uploadDate;
  var url;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        ext: json["ext"],
        extractor: json["extractor"],
        extractorKey: json["extractor_key"],
        filesize: json["filesize"],
        format: json["format"],
        formatId: json["format_id"],
        formatNote: json["format_note"],
        formats: List<Format>.from(json["formats"].map((x) => Format.fromJson(x))),
        thumbnail: json["thumbnail"],
        title: json["title"],
        duration: json["duration"],
        uploadDate: json["upload_date"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "extractor": extractor,
        "extractor_key": extractorKey,
        "filesize": filesize,
        "format": format,
        "format_id": formatId,
        "format_note": formatNote,
        "formats": List<dynamic>.from(formats!.map((x) => x.toJson())),
        "thumbnail": thumbnail,
        "title": title,
        "duration": duration,
        "upload_date": uploadDate,
        "url": url,
      };
}

Format formatFromJson(String str) => Format.fromJson(json.decode(str));

String formatToJson(Format data) => json.encode(data.toJson());

class Format {
  Format({
    this.ext,
    this.filesize,
    this.format,
    this.formatNote,
    this.protocol,
    this.url,
  });

  var ext;
  var filesize;
  var format;
  var formatNote;
  var protocol;
  var url;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        ext: json["ext"],
        filesize: json["filesize"],
        format: json["format"],
        formatNote: json["format_note"],
        protocol: json["protocol"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "filesize": filesize,
        "format": format,
        "format_note": formatNote,
        "protocol": protocol,
        "url": url,
      };
}
