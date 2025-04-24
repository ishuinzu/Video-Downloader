import 'dart:convert';

import 'package:meta/meta.dart';

FbFriendsStoryModel fbFriendsStoryModelFromJson(String str) => FbFriendsStoryModel.fromJson(json.decode(str));

String fbFriendsStoryModelToJson(FbFriendsStoryModel data) => json.encode(data.toJson());

class FbFriendsStoryModel {
  FbFriendsStoryModel({
    @required this.data,
    @required this.errors,
    @required this.extensions,
  });

  Data? data;
  List<Error>? errors;
  Extensions? extensions;

  factory FbFriendsStoryModel.fromJson(Map<String, dynamic> json) => FbFriendsStoryModel(
        data: Data.fromJson(json["data"]),
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
        extensions: Extensions.fromJson(json["extensions"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "errors": List<dynamic>.from(errors!.map((x) => x.toJson())),
        "extensions": extensions!.toJson(),
      };
}

class Data {
  Data({
    @required this.bucket,
    @required this.initialBucket,
    @required this.viewer,
  });

  dynamic bucket;
  dynamic initialBucket;
  Viewer? viewer;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bucket: json["bucket"],
        initialBucket: json["initialBucket"],
        viewer: Viewer.fromJson(json["viewer"]),
      );

  Map<String, dynamic> toJson() => {
        "bucket": bucket,
        "initialBucket": initialBucket,
        "viewer": viewer!.toJson(),
      };
}

class Viewer {
  Viewer({
    @required this.storiesLwrAnimations,
    @required this.actor,
  });

  StoriesLwrAnimations? storiesLwrAnimations;
  Actor? actor;

  factory Viewer.fromJson(Map<String, dynamic> json) => Viewer(
        storiesLwrAnimations: StoriesLwrAnimations.fromJson(json["stories_lwr_animations"]),
        actor: Actor.fromJson(json["actor"]),
      );

  Map<String, dynamic> toJson() => {
        "stories_lwr_animations": storiesLwrAnimations!.toJson(),
        "actor": actor!.toJson(),
      };
}

class Actor {
  Actor({
    @required this.typename,
    @required this.id,
  });

  String? typename;
  String? id;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        typename: json["__typename"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id": id,
      };
}

class StoriesLwrAnimations {
  StoriesLwrAnimations({
    required this.edges,
  });

  List<Edge> edges;

  factory StoriesLwrAnimations.fromJson(Map<String, dynamic> json) => StoriesLwrAnimations(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges.map((x) => x.toJson())),
      };
}

class Edge {
  Edge({
    @required this.node,
  });

  Node? node;

  factory Edge.fromJson(Map<String, dynamic> json) => Edge(
        node: Node.fromJson(json["node"]),
      );

  Map<String, dynamic> toJson() => {
        "node": node!.toJson(),
      };
}

class Node {
  Node({
    @required this.feedbackReactionIdentifier,
    @required this.tapAnimationAsset,
    @required this.id,
  });

  String? feedbackReactionIdentifier;
  TapAnimationAsset? tapAnimationAsset;
  String? id;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        feedbackReactionIdentifier: json["feedback_reaction_identifier"],
        tapAnimationAsset: TapAnimationAsset.fromJson(json["tap_animation_asset"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "feedback_reaction_identifier": feedbackReactionIdentifier,
        "tap_animation_asset": tapAnimationAsset!.toJson(),
        "id": id,
      };
}

class TapAnimationAsset {
  TapAnimationAsset({
    @required this.keyframeUri,
    @required this.id,
  });

  String? keyframeUri;
  String? id;

  factory TapAnimationAsset.fromJson(Map<String, dynamic> json) => TapAnimationAsset(
        keyframeUri: json["keyframe_uri"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "keyframe_uri": keyframeUri,
        "id": id,
      };
}

class Error {
  Error({
    @required this.message,
    @required this.severity,
    @required this.code,
    @required this.apiErrorCode,
    @required this.summary,
    @required this.description,
    @required this.descriptionRaw,
    @required this.isSilent,
    @required this.isTransient,
    @required this.requiresReauth,
    @required this.allowUserRetry,
    @required this.debugInfo,
    @required this.queryPath,
    @required this.fbtraceId,
    @required this.wwwRequestId,
    @required this.path,
  });

  String? message;
  String? severity;
  int? code;
  dynamic apiErrorCode;
  String? summary;
  String? description;
  String? descriptionRaw;
  bool? isSilent;
  bool? isTransient;
  bool? requiresReauth;
  bool? allowUserRetry;
  dynamic debugInfo;
  dynamic queryPath;
  String? fbtraceId;
  String? wwwRequestId;
  List<String>? path;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        severity: json["severity"],
        code: json["code"],
        apiErrorCode: json["api_error_code"],
        summary: json["summary"],
        description: json["description"],
        descriptionRaw: json["description_raw"],
        isSilent: json["is_silent"],
        isTransient: json["is_transient"],
        requiresReauth: json["requires_reauth"],
        allowUserRetry: json["allow_user_retry"],
        debugInfo: json["debug_info"],
        queryPath: json["query_path"],
        fbtraceId: json["fbtrace_id"],
        wwwRequestId: json["www_request_id"],
        path: json["path"] == null ? null : List<String>.from(json["path"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "severity": severity,
        "code": code,
        "api_error_code": apiErrorCode,
        "summary": summary,
        "description": description,
        "description_raw": descriptionRaw,
        "is_silent": isSilent,
        "is_transient": isTransient,
        "requires_reauth": requiresReauth,
        "allow_user_retry": allowUserRetry,
        "debug_info": debugInfo,
        "query_path": queryPath,
        "fbtrace_id": fbtraceId,
        "www_request_id": wwwRequestId,
        "path": path == null ? null : List<dynamic>.from(path!.map((x) => x)),
      };
}

class Extensions {
  Extensions({
    @required this.isFinal,
  });

  bool? isFinal;

  factory Extensions.fromJson(Map<String, dynamic> json) => Extensions(
        isFinal: json["is_final"],
      );

  Map<String, dynamic> toJson() => {
        "is_final": isFinal,
      };
}
