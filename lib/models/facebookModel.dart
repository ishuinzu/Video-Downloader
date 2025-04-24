import 'dart:convert';

Facebook facebookFromJson(String str) => Facebook.fromJson(json.decode(str));

String facebookToJson(Facebook data) => json.encode(data.toJson());

class Facebook {
  Facebook({
    this.url,
    this.videos,
  });

  String? url;
  List<Video>? videos;

  factory Facebook.fromJson(Map<String, dynamic> json) => Facebook(
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
    this.displayId,
    this.ext,
    this.extractor,
    this.extractorKey,
    this.format,
    this.formatId,
    this.formats,
    this.httpHeaders,
    this.id,
    this.playlist,
    this.playlistIndex,
    this.preference,
    this.protocol,
    this.requestedSubtitles,
    this.subtitles,
    this.thumbnail,
    this.thumbnails,
    this.timestamp,
    this.title,
    this.uploadDate,
    this.uploader,
    this.url,
    this.viewCount,
    this.webpageUrl,
    this.webpageUrlBasename,
  });

  String? displayId;
  String? ext;
  String? extractor;
  String? extractorKey;
  String? format;
  String? formatId;
  List<Format>? formats;
  HttpHeaders? httpHeaders;
  String? id;
  dynamic playlist;
  dynamic playlistIndex;
  int? preference;
  String? protocol;
  dynamic requestedSubtitles;
  Subtitles? subtitles;
  String? thumbnail;
  List<Thumbnail>? thumbnails;
  int? timestamp;
  String? title;
  String? uploadDate;
  String? uploader;
  String? url;
  dynamic viewCount;
  String? webpageUrl;
  String? webpageUrlBasename;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        displayId: json["display_id"],
        ext: json["ext"],
        extractor: json["extractor"],
        extractorKey: json["extractor_key"],
        format: json["format"],
        formatId: json["format_id"],
        formats: List<Format>.from(json["formats"].map((x) => Format.fromJson(x))),
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        id: json["id"],
        playlist: json["playlist"],
        playlistIndex: json["playlist_index"],
        preference: json["preference"],
        protocol: json["protocol"],
        requestedSubtitles: json["requested_subtitles"],
        subtitles: Subtitles.fromJson(json["subtitles"]),
        thumbnail: json["thumbnail"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        timestamp: json["timestamp"],
        title: json["title"],
        uploadDate: json["upload_date"],
        uploader: json["uploader"],
        url: json["url"],
        viewCount: json["view_count"],
        webpageUrl: json["webpage_url"],
        webpageUrlBasename: json["webpage_url_basename"],
      );

  Map<String, dynamic> toJson() => {
        "display_id": displayId,
        "ext": ext,
        "extractor": extractor,
        "extractor_key": extractorKey,
        "format": format,
        "format_id": formatId,
        "formats": List<dynamic>.from(formats!.map((x) => x.toJson())),
        "http_headers": httpHeaders!.toJson(),
        "id": id,
        "playlist": playlist,
        "playlist_index": playlistIndex,
        "preference": preference,
        "protocol": protocol,
        "requested_subtitles": requestedSubtitles,
        "subtitles": subtitles!.toJson(),
        "thumbnail": thumbnail,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "timestamp": timestamp,
        "title": title,
        "upload_date": uploadDate,
        "uploader": uploader,
        "url": url,
        "view_count": viewCount,
        "webpage_url": webpageUrl,
        "webpage_url_basename": webpageUrlBasename,
      };
}

class Format {
  Format({
    this.acodec,
    this.asr,
    this.container,
    this.ext,
    this.filesize,
    this.format,
    this.formatId,
    this.formatNote,
    this.fps,
    this.height,
    this.httpHeaders,
    this.language,
    this.manifestUrl,
    this.protocol,
    this.tbr,
    this.url,
    this.vcodec,
    this.width,
    this.preference,
  });

  String? acodec;
  int? asr;
  String? container;
  String? ext;
  dynamic filesize;
  String? format;
  String? formatId;
  String? formatNote;
  dynamic fps;
  int? height;
  HttpHeaders? httpHeaders;
  dynamic language;
  dynamic manifestUrl;
  String? protocol;
  double? tbr;
  String? url;
  String? vcodec;
  int? width;
  int? preference;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        acodec: json["acodec"],
        asr: json["asr"],
        container: json["container"],
        ext: json["ext"],
        filesize: json["filesize"],
        format: json["format"],
        formatId: json["format_id"],
        formatNote: json["format_note"],
        fps: json["fps"],
        height: json["height"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        language: json["language"],
        manifestUrl: json["manifest_url"],
        protocol: json["protocol"],
        // ignore: prefer_null_aware_operators
        tbr: json["tbr"] == null ? null : json["tbr"].toDouble(),
        url: json["url"],
        vcodec: json["vcodec"],
        width: json["width"],
        preference: json["preference"],
      );

  Map<String, dynamic> toJson() => {
        "acodec": acodec,
        "asr": asr,
        "container": container,
        "ext": ext,
        "filesize": filesize,
        "format": format,
        "format_id": formatId,
        "format_note": formatNote,
        "fps": fps,
        "height": height,
        "http_headers": httpHeaders!.toJson(),
        "language": language,
        "manifest_url": manifestUrl,
        "protocol": protocol,
        "tbr": tbr,
        "url": url,
        "vcodec": vcodec,
        "width": width,
        "preference": preference,
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

class Subtitles {
  Subtitles();

  factory Subtitles.fromJson(Map<String, dynamic> json) => Subtitles();

  Map<String, dynamic> toJson() => {};
}

class Thumbnail {
  Thumbnail({
    this.id,
    this.url,
  });

  String? id;
  String? url;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
