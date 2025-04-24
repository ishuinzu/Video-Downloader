import 'dart:convert';

SoundCloud soundCloudFromJson(String str) => SoundCloud.fromJson(json.decode(str));

String soundCloudToJson(SoundCloud data) => json.encode(data.toJson());

class SoundCloud {
  SoundCloud({
    this.url,
    this.videos,
  });

  String? url;
  List<Video>? videos;

  factory SoundCloud.fromJson(Map<String, dynamic> json) => SoundCloud(
        url: json["url"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    this.abr,
    this.commentCount,
    this.description,
    this.displayId,
    this.duration,
    this.ext,
    this.extractor,
    this.extractorKey,
    this.format,
    this.formatId,
    this.formats,
    this.genre,
    this.httpHeaders,
    this.id,
    this.license,
    this.likeCount,
    this.playlist,
    this.playlistIndex,
    this.preference,
    this.protocol,
    this.repostCount,
    this.requestedSubtitles,
    this.thumbnail,
    this.thumbnails,
    this.timestamp,
    this.title,
    this.uploadDate,
    this.uploader,
    this.uploaderId,
    this.uploaderUrl,
    this.url,
    this.vcodec,
    this.viewCount,
    this.webpageUrl,
    this.webpageUrlBasename,
  });

  int? abr;
  int? commentCount;
  String? description;
  String? displayId;
  double? duration;
  String? ext;
  String? extractor;
  String? extractorKey;
  String? format;
  String? formatId;
  List<Format>? formats;
  String? genre;
  HttpHeaders? httpHeaders;
  String? id;
  String? license;
  int? likeCount;
  dynamic playlist;
  dynamic playlistIndex;
  dynamic preference;
  String? protocol;
  int? repostCount;
  dynamic requestedSubtitles;
  String? thumbnail;
  List<Thumbnail>? thumbnails;
  int? timestamp;
  String? title;
  String? uploadDate;
  String? uploader;
  String? uploaderId;
  String? uploaderUrl;
  String? url;
  String? vcodec;
  int? viewCount;
  String? webpageUrl;
  String? webpageUrlBasename;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        abr: json["abr"],
        commentCount: json["comment_count"],
        description: json["description"],
        displayId: json["display_id"],
        duration: json["duration"].toDouble(),
        ext: json["ext"],
        extractor: json["extractor"],
        extractorKey: json["extractor_key"],
        format: json["format"],
        formatId: json["format_id"],
        formats: List<Format>.from(json["formats"].map((x) => Format.fromJson(x))),
        genre: json["genre"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        id: json["id"],
        license: json["license"],
        likeCount: json["like_count"],
        playlist: json["playlist"],
        playlistIndex: json["playlist_index"],
        preference: json["preference"],
        protocol: json["protocol"],
        repostCount: json["repost_count"],
        requestedSubtitles: json["requested_subtitles"],
        thumbnail: json["thumbnail"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        timestamp: json["timestamp"],
        title: json["title"],
        uploadDate: json["upload_date"],
        uploader: json["uploader"],
        uploaderId: json["uploader_id"],
        uploaderUrl: json["uploader_url"],
        url: json["url"],
        vcodec: json["vcodec"],
        viewCount: json["view_count"],
        webpageUrl: json["webpage_url"],
        webpageUrlBasename: json["webpage_url_basename"],
      );

  Map<String, dynamic> toJson() => {
        "abr": abr,
        "comment_count": commentCount,
        "description": description,
        "display_id": displayId,
        "duration": duration,
        "ext": ext,
        "extractor": extractor,
        "extractor_key": extractorKey,
        "format": format,
        "format_id": formatId,
        "formats": List<dynamic>.from(formats!.map((x) => x.toJson())),
        "genre": genre,
        "http_headers": httpHeaders!.toJson(),
        "id": id,
        "license": license,
        "like_count": likeCount,
        "playlist": playlist,
        "playlist_index": playlistIndex,
        "preference": preference,
        "protocol": protocol,
        "repost_count": repostCount,
        "requested_subtitles": requestedSubtitles,
        "thumbnail": thumbnail,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "timestamp": timestamp,
        "title": title,
        "upload_date": uploadDate,
        "uploader": uploader,
        "uploader_id": uploaderId,
        "uploader_url": uploaderUrl,
        "url": url,
        "vcodec": vcodec,
        "view_count": viewCount,
        "webpage_url": webpageUrl,
        "webpage_url_basename": webpageUrlBasename,
      };
}

class Format {
  Format({
    this.abr,
    this.ext,
    this.format,
    this.formatId,
    this.httpHeaders,
    this.preference,
    this.protocol,
    this.url,
    this.vcodec,
  });

  int? abr;
  String? ext;
  String? format;
  String? formatId;
  HttpHeaders? httpHeaders;
  dynamic preference;
  String? protocol;
  String? url;
  String? vcodec;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        abr: json["abr"],
        ext: json["ext"],
        format: json["format"],
        formatId: json["format_id"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        preference: json["preference"],
        protocol: json["protocol"],
        url: json["url"],
        vcodec: json["vcodec"],
      );

  Map<String, dynamic> toJson() => {
        "abr": abr,
        "ext": ext,
        "format": format,
        "format_id": formatId,
        "http_headers": httpHeaders!.toJson(),
        "preference": preference,
        "protocol": protocol,
        "url": url,
        "vcodec": vcodec,
      };
}

class HttpHeaders {
  HttpHeaders({
    this.accept,
    this.acceptCharset,
    this.acceptEncoding,
    this.acceptLanguage,
    this.userAgent,
  });

  String? accept;
  String? acceptCharset;
  String? acceptEncoding;
  String? acceptLanguage;
  String? userAgent;

  factory HttpHeaders.fromJson(Map<String, dynamic> json) => HttpHeaders(
        accept: json["Accept"],
        acceptCharset: json["Accept-Charset"],
        acceptEncoding: json["Accept-Encoding"],
        acceptLanguage: json["Accept-Language"],
        userAgent: json["User-Agent"],
      );

  Map<String, dynamic> toJson() => {
        "Accept": accept,
        "Accept-Charset": acceptCharset,
        "Accept-Encoding": acceptEncoding,
        "Accept-Language": acceptLanguage,
        "User-Agent": userAgent,
      };
}

class Thumbnail {
  Thumbnail({
    this.height,
    this.id,
    this.resolution,
    this.url,
    this.width,
    this.preference,
  });

  int? height;
  String? id;
  String? resolution;
  String? url;
  int? width;
  int? preference;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        height: json["height"],
        id: json["id"],
        resolution: json["resolution"],
        url: json["url"],
        width: json["width"],
        preference: json["preference"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "id": id,
        "resolution": resolution,
        "url": url,
        "width": width,
        "preference": preference,
      };
}
