import 'dart:convert';

Vimeo vimeoFromJson(String str) => Vimeo.fromJson(json.decode(str));

String vimeoToJson(Vimeo data) => json.encode(data.toJson());

class Vimeo {
  Vimeo({
    this.url,
    this.videos,
  });

  String? url;
  List<Video>? videos;

  factory Vimeo.fromJson(Map<String, dynamic> json) => Vimeo(
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
    this.acodec,
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
    this.fps,
    this.height,
    this.httpHeaders,
    this.id,
    this.isLive,
    this.likeCount,
    this.manifestUrl,
    this.playlist,
    this.playlistIndex,
    this.preference,
    this.protocol,
    this.requestedSubtitles,
    this.subtitles,
    this.tbr,
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
    this.width,
  });

  Acodec? acodec;
  int? commentCount;
  String? description;
  String? displayId;
  int? duration;
  Ext? ext;
  String? extractor;
  String? extractorKey;
  String? format;
  String? formatId;
  List<Format>? formats;
  double? fps;
  int? height;
  HttpHeaders? httpHeaders;
  String? id;
  bool? isLive;
  int? likeCount;
  String? manifestUrl;
  dynamic playlist;
  dynamic playlistIndex;
  dynamic preference;
  Protocol? protocol;
  dynamic requestedSubtitles;
  Subtitles? subtitles;
  int? tbr;
  String? thumbnail;
  List<Thumbnail>? thumbnails;
  int? timestamp;
  String? title;
  String? uploadDate;
  String? uploader;
  String? uploaderId;
  String? uploaderUrl;
  String? url;
  Vcodec? vcodec;
  int? viewCount;
  String? webpageUrl;
  String? webpageUrlBasename;
  int? width;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        acodec: acodecValues.map![json["acodec"]],
        commentCount: json["comment_count"],
        description: json["description"],
        displayId: json["display_id"],
        duration: json["duration"],
        ext: extValues.map![json["ext"]],
        extractor: json["extractor"],
        extractorKey: json["extractor_key"],
        format: json["format"],
        formatId: json["format_id"],
        formats: List<Format>.from(json["formats"].map((x) => Format.fromJson(x))),
        fps: json["fps"].toDouble(),
        height: json["height"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        id: json["id"],
        isLive: json["is_live"],
        likeCount: json["like_count"],
        manifestUrl: json["manifest_url"],
        playlist: json["playlist"],
        playlistIndex: json["playlist_index"],
        preference: json["preference"],
        protocol: protocolValues.map![json["protocol"]],
        requestedSubtitles: json["requested_subtitles"],
        subtitles: Subtitles.fromJson(json["subtitles"]),
        tbr: json["tbr"],
        thumbnail: json["thumbnail"],
        thumbnails: List<Thumbnail>.from(json["thumbnails"].map((x) => Thumbnail.fromJson(x))),
        timestamp: json["timestamp"],
        title: json["title"],
        uploadDate: json["upload_date"],
        uploader: json["uploader"],
        uploaderId: json["uploader_id"],
        uploaderUrl: json["uploader_url"],
        url: json["url"],
        vcodec: vcodecValues.map![json["vcodec"]],
        viewCount: json["view_count"],
        webpageUrl: json["webpage_url"],
        webpageUrlBasename: json["webpage_url_basename"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "acodec": acodecValues.reverse![acodec],
        "comment_count": commentCount,
        "description": description,
        "display_id": displayId,
        "duration": duration,
        "ext": extValues.reverse![ext],
        "extractor": extractor,
        "extractor_key": extractorKey,
        "format": format,
        "format_id": formatId,
        "formats": List<dynamic>.from(formats!.map((x) => x.toJson())),
        "fps": fps,
        "height": height,
        "http_headers": httpHeaders!.toJson(),
        "id": id,
        "is_live": isLive,
        "like_count": likeCount,
        "manifest_url": manifestUrl,
        "playlist": playlist,
        "playlist_index": playlistIndex,
        "preference": preference,
        "protocol": protocolValues.reverse![protocol],
        "requested_subtitles": requestedSubtitles,
        "subtitles": subtitles!.toJson(),
        "tbr": tbr,
        "thumbnail": thumbnail,
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "timestamp": timestamp,
        "title": title,
        "upload_date": uploadDate,
        "uploader": uploader,
        "uploader_id": uploaderId,
        "uploader_url": uploaderUrl,
        "url": url,
        "vcodec": vcodecValues.reverse![vcodec],
        "view_count": viewCount,
        "webpage_url": webpageUrl,
        "webpage_url_basename": webpageUrlBasename,
        "width": width,
      };
}

enum Acodec { MP4_A_402, NONE }

final acodecValues = EnumValues({"mp4a.40.2": Acodec.MP4_A_402, "none": Acodec.NONE});

enum Ext { MP4, M4_A }

final extValues = EnumValues({"m4a": Ext.M4_A, "mp4": Ext.MP4});

class Format {
  Format({
    this.ext,
    this.format,
    this.formatId,
    this.httpHeaders,
    this.language,
    this.manifestUrl,
    this.preference,
    this.protocol,
    this.url,
    this.vcodec,
    this.acodec,
    this.asr,
    this.container,
    this.filesize,
    this.formatNote,
    this.fps,
    this.fragmentBaseUrl,
    this.fragments,
    this.height,
    this.tbr,
    this.width,
  });

  Ext? ext;
  String? format;
  String? formatId;
  HttpHeaders? httpHeaders;
  dynamic language;
  String? manifestUrl;
  int? preference;
  Protocol? protocol;
  String? url;
  Vcodec? vcodec;
  Acodec? acodec;
  int? asr;
  Container? container;
  dynamic filesize;
  FormatNote? formatNote;
  double? fps;
  String? fragmentBaseUrl;
  List<Fragment>? fragments;
  int? height;
  int? tbr;
  int? width;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        ext: extValues.map![json["ext"]],
        format: json["format"],
        formatId: json["format_id"],
        httpHeaders: HttpHeaders.fromJson(json["http_headers"]),
        language: json["language"],
        manifestUrl: json["manifest_url"],
        preference: json["preference"],
        protocol: protocolValues.map![json["protocol"]],
        url: json["url"],
        vcodec: json["vcodec"] == null ? null : vcodecValues.map![json["vcodec"]],
        acodec: json["acodec"] == null ? null : acodecValues.map![json["acodec"]],
        asr: json["asr"],
        container: json["container"] == null ? null : containerValues.map![json["container"]],
        filesize: json["filesize"],
        formatNote: json["format_note"] == null ? null : formatNoteValues.map![json["format_note"]],
        // ignore: prefer_null_aware_operators
        fps: json["fps"] == null ? null : json["fps"].toDouble(),
        fragmentBaseUrl: json["fragment_base_url"],
        fragments: json["fragments"] == null ? null : List<Fragment>.from(json["fragments"].map((x) => Fragment.fromJson(x))),
        height: json["height"],
        tbr: json["tbr"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "ext": extValues.reverse![ext],
        "format": format,
        "format_id": formatId,
        "http_headers": httpHeaders!.toJson(),
        "language": language,
        "manifest_url": manifestUrl,
        "preference": preference,
        "protocol": protocolValues.reverse![protocol],
        "url": url,
        "vcodec": vcodec == null ? null : vcodecValues.reverse![vcodec],
        "acodec": acodec == null ? null : acodecValues.reverse![acodec],
        "asr": asr,
        "container": container == null ? null : containerValues.reverse![container],
        "filesize": filesize,
        "format_note": formatNote == null ? null : formatNoteValues.reverse![formatNote],
        "fps": fps,
        "fragment_base_url": fragmentBaseUrl,
        "fragments": fragments == null ? null : List<dynamic>.from(fragments!.map((x) => x.toJson())),
        "height": height,
        "tbr": tbr,
        "width": width,
      };
}

enum Container { M4_A_DASH, MP4_DASH }

final containerValues = EnumValues({"m4a_dash": Container.M4_A_DASH, "mp4_dash": Container.MP4_DASH});

enum FormatNote { DASH_AUDIO, DASH_VIDEO }

final formatNoteValues = EnumValues({"DASH audio": FormatNote.DASH_AUDIO, "DASH video": FormatNote.DASH_VIDEO});

class Fragment {
  Fragment({
    this.path,
    this.duration,
  });

  String? path;
  double? duration;

  factory Fragment.fromJson(Map<String, dynamic> json) => Fragment(
        path: json["path"],
        // ignore: prefer_null_aware_operators
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "duration": duration,
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

  Accept? accept;
  AcceptCharset? acceptCharset;
  AcceptEncoding? acceptEncoding;
  AcceptLanguage? acceptLanguage;
  String? userAgent;

  factory HttpHeaders.fromJson(Map<String, dynamic> json) => HttpHeaders(
        accept: acceptValues.map![json["Accept"]],
        acceptCharset: acceptCharsetValues.map![json["Accept-Charset"]],
        acceptEncoding: acceptEncodingValues.map![json["Accept-Encoding"]],
        acceptLanguage: acceptLanguageValues.map![json["Accept-Language"]],
        userAgent: json["User-Agent"],
      );

  Map<String, dynamic> toJson() => {
        "Accept": acceptValues.reverse![accept],
        "Accept-Charset": acceptCharsetValues.reverse![acceptCharset],
        "Accept-Encoding": acceptEncodingValues.reverse![acceptEncoding],
        "Accept-Language": acceptLanguageValues.reverse![acceptLanguage],
        "User-Agent": userAgent,
      };
}

enum Accept { TEXT_HTML_APPLICATION_XHTML_XML_APPLICATION_XML_Q_09_Q_08 }

final acceptValues = EnumValues({"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8": Accept.TEXT_HTML_APPLICATION_XHTML_XML_APPLICATION_XML_Q_09_Q_08});

enum AcceptCharset { ISO_88591_UTF_8_Q_07_Q_07 }

final acceptCharsetValues = EnumValues({"ISO-8859-1,utf-8;q=0.7,*;q=0.7": AcceptCharset.ISO_88591_UTF_8_Q_07_Q_07});

enum AcceptEncoding { GZIP_DEFLATE }

final acceptEncodingValues = EnumValues({"gzip, deflate": AcceptEncoding.GZIP_DEFLATE});

enum AcceptLanguage { EN_US_EN_Q_05 }

final acceptLanguageValues = EnumValues({"en-us,en;q=0.5": AcceptLanguage.EN_US_EN_Q_05});

enum Protocol { M3_U8_NATIVE, HTTP_DASH_SEGMENTS, HTTPS }

final protocolValues = EnumValues({"https": Protocol.HTTPS, "http_dash_segments": Protocol.HTTP_DASH_SEGMENTS, "m3u8_native": Protocol.M3_U8_NATIVE});

enum Vcodec { NONE, AVC1_64001_E, AVC1_64001_F, AVC1_640020, AVC1_640028 }

final vcodecValues = EnumValues({"avc1.64001E": Vcodec.AVC1_64001_E, "avc1.64001F": Vcodec.AVC1_64001_F, "avc1.640020": Vcodec.AVC1_640020, "avc1.640028": Vcodec.AVC1_640028, "none": Vcodec.NONE});

class Subtitles {
  Subtitles();

  factory Subtitles.fromJson(Map<String, dynamic> json) => Subtitles();

  Map<String, dynamic> toJson() => {};
}

class Thumbnail {
  Thumbnail({
    this.id,
    this.url,
    this.width,
  });

  String? id;
  String? url;
  int? width;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        id: json["id"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "width": width,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
