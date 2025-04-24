import 'dart:convert';

BitChute bitChuteFromJson(String str) => BitChute.fromJson(json.decode(str));

String bitChuteToJson(BitChute data) => json.encode(data.toJson());

class BitChute {
  BitChute({
    this.url,
    this.videos,
  });

  String? url;
  List<Video>? videos;

  factory BitChute.fromJson(Map<String, dynamic> json) => BitChute(
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
    this.description,
    this.displayId,
    this.ext,
    this.extractor,
    this.extractorKey,
    this.format,
    this.formatId,
    this.formats,
    this.height,
    this.httpHeaders,
    this.id,
    this.playlist,
    this.playlistIndex,
    this.protocol,
    this.requestedSubtitles,
    this.tbr,
    this.thumbnail,
    this.thumbnails,
    this.title,
    this.uploadDate,
    this.uploader,
    this.url,
    this.vcodec,
    this.webpageUrl,
    this.webpageUrlBasename,
    this.width,
  });

  String? description;
  String? displayId;
  String? ext;
  String? extractor;
  String? extractorKey;
  String? format;
  String? formatId;
  List<Format>? formats;
  dynamic height;
  HttpHeaders? httpHeaders;
  String? id;
  dynamic playlist;
  dynamic playlistIndex;
  String? protocol;
  dynamic requestedSubtitles;
  dynamic tbr;
  String? thumbnail;
  List<Thumbnail>? thumbnails;
  String? title;
  String? uploadDate;
  String? uploader;
  String? url;
  dynamic vcodec;
  String? webpageUrl;
  String? webpageUrlBasename;
  dynamic width;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        description: json["description"],
        displayId: json["display_id"],
        ext: json["ext"],
        extractor: json["extractor"],
        extractorKey: json["extractor_key"],
        format: json["format"],
        formatId: json["format_id"],
        formats: List<Format>.from(json["formats"].map((x) => Format.fromJson(x))),
        height: json["height"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        id: json["id"],
        playlist: json["playlist"],
        playlistIndex: json["playlist_index"],
        protocol: json["protocol"],
        requestedSubtitles: json["requested_subtitles"],
        tbr: json["tbr"],
        thumbnail: json["thumbnail"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        title: json["title"],
        uploadDate: json["upload_date"],
        uploader: json["uploader"],
        url: json["url"],
        vcodec: json["vcodec"],
        webpageUrl: json["webpage_url"],
        webpageUrlBasename: json["webpage_url_basename"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "display_id": displayId,
        "ext": ext,
        "extractor": extractor,
        "extractor_key": extractorKey,
        "format": format,
        "format_id": formatId,
        "formats": List<dynamic>.from(formats!.map((x) => x.toJson())),
        "height": height,
        "http_headers": httpHeaders!.toJson(),
        "id": id,
        "playlist": playlist,
        "playlist_index": playlistIndex,
        "protocol": protocol,
        "requested_subtitles": requestedSubtitles,
        "tbr": tbr,
        "thumbnail": thumbnail,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "title": title,
        "upload_date": uploadDate,
        "uploader": uploader,
        "url": url,
        "vcodec": vcodec,
        "webpage_url": webpageUrl,
        "webpage_url_basename": webpageUrlBasename,
        "width": width,
      };
}

class Format {
  Format({
    this.ext,
    this.format,
    this.formatId,
    this.height,
    this.httpHeaders,
    this.protocol,
    this.tbr,
    this.url,
    this.vcodec,
    this.width,
  });

  String? ext;
  String? format;
  String? formatId;
  dynamic height;
  HttpHeaders? httpHeaders;
  String? protocol;
  dynamic tbr;
  String? url;
  dynamic vcodec;
  dynamic width;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        ext: json["ext"],
        format: json["format"],
        formatId: json["format_id"],
        height: json["height"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        protocol: json["protocol"],
        tbr: json["tbr"],
        url: json["url"],
        vcodec: json["vcodec"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "format": format,
        "format_id": formatId,
        "height": height,
        "http_headers": httpHeaders!.toJson(),
        "protocol": protocol,
        "tbr": tbr,
        "url": url,
        "vcodec": vcodec,
        "width": width,
      };
}

class HttpHeaders {
  HttpHeaders({
    this.accept,
    this.acceptCharset,
    this.acceptEncoding,
    this.acceptLanguage,
    this.cookie,
    this.referer,
    this.userAgent,
  });

  String? accept;
  String? acceptCharset;
  String? acceptEncoding;
  String? acceptLanguage;
  String? cookie;
  String? referer;
  String? userAgent;

  factory HttpHeaders.fromJson(Map<String, dynamic> json) => HttpHeaders(
        accept: json["Accept"],
        acceptCharset: json["Accept-Charset"],
        acceptEncoding: json["Accept-Encoding"],
        acceptLanguage: json["Accept-Language"],
        cookie: json["Cookie"],
        referer: json["Referer"],
        userAgent: json["User-Agent"],
      );

  Map<String, dynamic> toJson() => {
        "Accept": accept,
        "Accept-Charset": acceptCharset,
        "Accept-Encoding": acceptEncoding,
        "Accept-Language": acceptLanguage,
        "Cookie": cookie,
        "Referer": referer,
        "User-Agent": userAgent,
      };
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
