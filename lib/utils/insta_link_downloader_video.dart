// To parse this JSON data, do
//
//     final instaLinkDownloaderVideo = instaLinkDownloaderVideoFromJson(jsonString);

import 'dart:convert';

InstaLinkDownloaderVideo instaLinkDownloaderVideoFromJson(String str) =>
    InstaLinkDownloaderVideo.fromJson(json.decode(str));

String instaLinkDownloaderVideoToJson(InstaLinkDownloaderVideo data) =>
    json.encode(data.toJson());

class InstaLinkDownloaderVideo {
  InstaLinkDownloaderVideo({
    this.graphql,
  });

  Graphql? graphql;

  factory InstaLinkDownloaderVideo.fromJson(Map<String, dynamic> json) =>
      InstaLinkDownloaderVideo(
        graphql: Graphql.fromJson(json["graphql"]),
      );

  Map<String, dynamic> toJson() => {
        "graphql": graphql!.toJson(),
      };
}

class Graphql {
  Graphql({
    this.shortcodeMedia,
  });

  ShortcodeMedia? shortcodeMedia;

  factory Graphql.fromJson(Map<String, dynamic> json) => Graphql(
        shortcodeMedia: ShortcodeMedia.fromJson(json["shortcode_media"]),
      );

  Map<String, dynamic> toJson() => {
        "shortcode_media": shortcodeMedia!.toJson(),
      };
}

class ShortcodeMedia {
  ShortcodeMedia({
    this.typename,
    this.id,
    this.shortcode,
    this.dimensions,
    this.gatingInfo,
    this.factCheckOverallRating,
    this.factCheckInformation,
    this.sensitivityFrictionInfo,
    this.sharingFrictionInfo,
    this.mediaOverlayInfo,
    this.mediaPreview,
    this.displayUrl,
    this.displayResources,
    this.accessibilityCaption,
    this.dashInfo,
    this.hasAudio,
    this.videoUrl,
    this.videoViewCount,
    this.videoPlayCount,
    this.isVideo,
    this.trackingToken,
    this.edgeMediaToTaggedUser,
    this.edgeMediaToCaption,
    this.captionIsEdited,
    this.hasRankedComments,
    this.edgeMediaToParentComment,
    this.edgeMediaToHoistedComment,
    this.edgeMediaPreviewComment,
    this.commentsDisabled,
    this.commentingDisabledForViewer,
    this.takenAtTimestamp,
    this.edgeMediaPreviewLike,
    this.edgeMediaToSponsorUser,
    // this.location,
    this.viewerHasLiked,
    this.viewerHasSaved,
    this.viewerHasSavedToCollection,
    this.viewerInPhotoOfYou,
    this.viewerCanReshare,
    this.owner,
    this.isAd,
    this.edgeWebMediaToRelatedMedia,
    this.encodingStatus,
    this.isPublished,
    this.productType,
    this.title,
    this.videoDuration,
    this.thumbnailSrc,
    this.clipsMusicAttributionInfo,
    this.edgeRelatedProfiles,
  });

  String? typename;
  String? id;
  String? shortcode;
  Dimensions? dimensions;
  dynamic gatingInfo;
  dynamic factCheckOverallRating;
  dynamic factCheckInformation;
  dynamic sensitivityFrictionInfo;
  SharingFrictionInfo? sharingFrictionInfo;
  dynamic mediaOverlayInfo;
  String? mediaPreview;
  String? displayUrl;
  List<DisplayResource>? displayResources;
  dynamic accessibilityCaption;
  DashInfo? dashInfo;
  bool? hasAudio;
  String? videoUrl;
  int? videoViewCount;
  dynamic videoPlayCount;
  bool? isVideo;
  String? trackingToken;
  EdgeMediaToCaptionClass? edgeMediaToTaggedUser;
  EdgeMediaToCaptionClass? edgeMediaToCaption;
  bool? captionIsEdited;
  bool? hasRankedComments;
  EdgeMediaToParentComment? edgeMediaToParentComment;
  EdgeMediaToCaptionClass? edgeMediaToHoistedComment;
  EdgeMediaPreview? edgeMediaPreviewComment;
  bool? commentsDisabled;
  bool? commentingDisabledForViewer;
  int? takenAtTimestamp;
  EdgeMediaPreview? edgeMediaPreviewLike;
  EdgeMediaToCaptionClass? edgeMediaToSponsorUser;

  //Location location;
  bool? viewerHasLiked;
  bool? viewerHasSaved;
  bool? viewerHasSavedToCollection;
  bool? viewerInPhotoOfYou;
  bool? viewerCanReshare;
  Owner? owner;
  bool? isAd;
  EdgeMediaToCaptionClass? edgeWebMediaToRelatedMedia;
  dynamic encodingStatus;
  bool? isPublished;
  String? productType;
  String? title;
  double? videoDuration;
  String? thumbnailSrc;
  dynamic clipsMusicAttributionInfo;
  EdgeMediaToCaptionClass? edgeRelatedProfiles;

  factory ShortcodeMedia.fromJson(Map<String, dynamic> json) => ShortcodeMedia(
        typename: json["__typename"],
        id: json["id"],
        shortcode: json["shortcode"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        gatingInfo: json["gating_info"],
        factCheckOverallRating: json["fact_check_overall_rating"],
        factCheckInformation: json["fact_check_information"],
        sensitivityFrictionInfo: json["sensitivity_friction_info"],
        sharingFrictionInfo:
            SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        mediaOverlayInfo: json["media_overlay_info"],
        mediaPreview: json["media_preview"],
        displayUrl: json["display_url"],
        displayResources: List<DisplayResource>.from(
            json["display_resources"].map((x) => DisplayResource.fromJson(x))),
        accessibilityCaption: json["accessibility_caption"],
        dashInfo: DashInfo.fromJson(json["dash_info"]),
        hasAudio: json["has_audio"],
        videoUrl: json["video_url"],
        videoViewCount: json["video_view_count"],
        videoPlayCount: json["video_play_count"],
        isVideo: json["is_video"],
        trackingToken: json["tracking_token"],
        edgeMediaToTaggedUser:
            EdgeMediaToCaptionClass.fromJson(json["edge_media_to_tagged_user"]),
        edgeMediaToCaption:
            EdgeMediaToCaptionClass.fromJson(json["edge_media_to_caption"]),
        captionIsEdited: json["caption_is_edited"],
        hasRankedComments: json["has_ranked_comments"],
        edgeMediaToParentComment: EdgeMediaToParentComment.fromJson(
            json["edge_media_to_parent_comment"]),
        edgeMediaToHoistedComment: EdgeMediaToCaptionClass.fromJson(
            json["edge_media_to_hoisted_comment"]),
        edgeMediaPreviewComment:
            EdgeMediaPreview.fromJson(json["edge_media_preview_comment"]),
        commentsDisabled: json["comments_disabled"],
        commentingDisabledForViewer: json["commenting_disabled_for_viewer"],
        takenAtTimestamp: json["taken_at_timestamp"],
        edgeMediaPreviewLike:
            EdgeMediaPreview.fromJson(json["edge_media_preview_like"]),
        edgeMediaToSponsorUser: EdgeMediaToCaptionClass.fromJson(
            json["edge_media_to_sponsor_user"]),
        // location: Location.fromJson(json["location"]),
        viewerHasLiked: json["viewer_has_liked"],
        viewerHasSaved: json["viewer_has_saved"],
        viewerHasSavedToCollection: json["viewer_has_saved_to_collection"],
        viewerInPhotoOfYou: json["viewer_in_photo_of_you"],
        viewerCanReshare: json["viewer_can_reshare"],
        owner: Owner.fromJson(json["owner"]),
        isAd: json["is_ad"],
        edgeWebMediaToRelatedMedia: EdgeMediaToCaptionClass.fromJson(
            json["edge_web_media_to_related_media"]),
        encodingStatus: json["encoding_status"],
        isPublished: json["is_published"],
        productType: json["product_type"],
        title: json["title"],
        videoDuration: json["video_duration"].toDouble(),
        thumbnailSrc: json["thumbnail_src"],
        clipsMusicAttributionInfo: json["clips_music_attribution_info"],
        edgeRelatedProfiles:
            EdgeMediaToCaptionClass.fromJson(json["edge_related_profiles"]),
      );

  Map<String, dynamic> toJson() => {
        "__typename": typename,
        "id": id,
        "shortcode": shortcode,
        "dimensions": dimensions!.toJson(),
        "gating_info": gatingInfo,
        "fact_check_overall_rating": factCheckOverallRating,
        "fact_check_information": factCheckInformation,
        "sensitivity_friction_info": sensitivityFrictionInfo,
        "sharing_friction_info": sharingFrictionInfo!.toJson(),
        "media_overlay_info": mediaOverlayInfo,
        "media_preview": mediaPreview,
        "display_url": displayUrl,
        "display_resources":
            List<dynamic>.from(displayResources!.map((x) => x.toJson())),
        "accessibility_caption": accessibilityCaption,
        "dash_info": dashInfo!.toJson(),
        "has_audio": hasAudio,
        "video_url": videoUrl,
        "video_view_count": videoViewCount,
        "video_play_count": videoPlayCount,
        "is_video": isVideo,
        "tracking_token": trackingToken,
        "edge_media_to_tagged_user": edgeMediaToTaggedUser!.toJson(),
        "edge_media_to_caption": edgeMediaToCaption!.toJson(),
        "caption_is_edited": captionIsEdited,
        "has_ranked_comments": hasRankedComments,
        "edge_media_to_parent_comment": edgeMediaToParentComment!.toJson(),
        "edge_media_to_hoisted_comment": edgeMediaToHoistedComment!.toJson(),
        "edge_media_preview_comment": edgeMediaPreviewComment!.toJson(),
        "comments_disabled": commentsDisabled,
        "commenting_disabled_for_viewer": commentingDisabledForViewer,
        "taken_at_timestamp": takenAtTimestamp,
        "edge_media_preview_like": edgeMediaPreviewLike!.toJson(),
        "edge_media_to_sponsor_user": edgeMediaToSponsorUser!.toJson(),
        //"location": location.toJson(),
        "viewer_has_liked": viewerHasLiked,
        "viewer_has_saved": viewerHasSaved,
        "viewer_has_saved_to_collection": viewerHasSavedToCollection,
        "viewer_in_photo_of_you": viewerInPhotoOfYou,
        "viewer_can_reshare": viewerCanReshare,
        "owner": owner!.toJson(),
        "is_ad": isAd,
        "edge_web_media_to_related_media": edgeWebMediaToRelatedMedia!.toJson(),
        "encoding_status": encodingStatus,
        "is_published": isPublished,
        "product_type": productType,
        "title": title,
        "video_duration": videoDuration,
        "thumbnail_src": thumbnailSrc,
        "clips_music_attribution_info": clipsMusicAttributionInfo,
        "edge_related_profiles": edgeRelatedProfiles!.toJson(),
      };
}

class DashInfo {
  DashInfo({
    this.isDashEligible,
    this.videoDashManifest,
    this.numberOfQualities,
  });

  bool? isDashEligible;
  dynamic videoDashManifest;
  int? numberOfQualities;

  factory DashInfo.fromJson(Map<String, dynamic> json) => DashInfo(
        isDashEligible: json["is_dash_eligible"],
        videoDashManifest: json["video_dash_manifest"],
        numberOfQualities: json["number_of_qualities"],
      );

  Map<String, dynamic> toJson() => {
        "is_dash_eligible": isDashEligible,
        "video_dash_manifest": videoDashManifest,
        "number_of_qualities": numberOfQualities,
      };
}

class Dimensions {
  Dimensions({
    this.height,
    this.width,
  });

  int? height;
  int? width;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "width": width,
      };
}

class DisplayResource {
  DisplayResource({
    this.src,
    this.configWidth,
    this.configHeight,
  });

  String? src;
  int? configWidth;
  int? configHeight;

  factory DisplayResource.fromJson(Map<String, dynamic> json) =>
      DisplayResource(
        src: json["src"],
        configWidth: json["config_width"],
        configHeight: json["config_height"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "config_width": configWidth,
        "config_height": configHeight,
      };
}

class EdgeMediaPreview {
  EdgeMediaPreview({
    this.count,
    this.edges,
  });

  int? count;
  List<dynamic>? edges;

  factory EdgeMediaPreview.fromJson(Map<String, dynamic> json) =>
      EdgeMediaPreview(
        count: json["count"],
        edges: List<dynamic>.from(json["edges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "edges": List<dynamic>.from(edges!.map((x) => x)),
      };
}

class EdgeMediaToCaptionClass {
  EdgeMediaToCaptionClass({
    this.edges,
  });

  List<Edge>? edges;

  factory EdgeMediaToCaptionClass.fromJson(Map<String, dynamic> json) =>
      EdgeMediaToCaptionClass(
        edges: List<Edge>.from(json["edges"].map((x) => Edge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "edges": List<dynamic>.from(edges!.map((x) => x.toJson())),
      };
}

class Edge {
  Edge({
    this.node,
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
    this.text,
  });

  String? text;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class EdgeMediaToParentComment {
  EdgeMediaToParentComment({
    this.count,
    this.pageInfo,
    this.edges,
  });

  int? count;
  PageInfo? pageInfo;
  List<dynamic>? edges;

  factory EdgeMediaToParentComment.fromJson(Map<String, dynamic> json) =>
      EdgeMediaToParentComment(
        count: json["count"],
        pageInfo: PageInfo.fromJson(json["page_info"]),
        edges: List<dynamic>.from(json["edges"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page_info": pageInfo!.toJson(),
        "edges": List<dynamic>.from(edges!.map((x) => x)),
      };
}

class PageInfo {
  PageInfo({
    this.hasNextPage,
    this.endCursor,
  });

  bool? hasNextPage;
  dynamic endCursor;

  factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        hasNextPage: json["has_next_page"],
        endCursor: json["end_cursor"],
      );

  Map<String, dynamic> toJson() => {
        "has_next_page": hasNextPage,
        "end_cursor": endCursor,
      };
}

class Owner {
  Owner({
    this.id,
    this.isVerified,
    this.profilePicUrl,
    this.username,
    this.blockedByViewer,
    this.restrictedByViewer,
    this.followedByViewer,
    this.fullName,
    this.hasBlockedViewer,
    this.isPrivate,
    this.isUnpublished,
    this.requestedByViewer,
    this.passTieringRecommendation,
    this.edgeOwnerToTimelineMedia,
    this.edgeFollowedBy,
  });

  String? id;
  bool? isVerified;
  String? profilePicUrl;
  String? username;
  bool? blockedByViewer;
  bool? restrictedByViewer;
  bool? followedByViewer;
  String? fullName;
  bool? hasBlockedViewer;
  bool? isPrivate;
  bool? isUnpublished;
  bool? requestedByViewer;
  bool? passTieringRecommendation;
  EdgeFollowedByClass? edgeOwnerToTimelineMedia;
  EdgeFollowedByClass? edgeFollowedBy;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        isVerified: json["is_verified"],
        profilePicUrl: json["profile_pic_url"],
        username: json["username"],
        blockedByViewer: json["blocked_by_viewer"],
        restrictedByViewer: json["restricted_by_viewer"],
        followedByViewer: json["followed_by_viewer"],
        fullName: json["full_name"],
        hasBlockedViewer: json["has_blocked_viewer"],
        isPrivate: json["is_private"],
        isUnpublished: json["is_unpublished"],
        requestedByViewer: json["requested_by_viewer"],
        passTieringRecommendation: json["pass_tiering_recommendation"],
        edgeOwnerToTimelineMedia:
            EdgeFollowedByClass.fromJson(json["edge_owner_to_timeline_media"]),
        edgeFollowedBy: EdgeFollowedByClass.fromJson(json["edge_followed_by"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_verified": isVerified,
        "profile_pic_url": profilePicUrl,
        "username": username,
        "blocked_by_viewer": blockedByViewer,
        "restricted_by_viewer": restrictedByViewer,
        "followed_by_viewer": followedByViewer,
        "full_name": fullName,
        "has_blocked_viewer": hasBlockedViewer,
        "is_private": isPrivate,
        "is_unpublished": isUnpublished,
        "requested_by_viewer": requestedByViewer,
        "pass_tiering_recommendation": passTieringRecommendation,
        "edge_owner_to_timeline_media": edgeOwnerToTimelineMedia!.toJson(),
        "edge_followed_by": edgeFollowedBy!.toJson(),
      };
}

class EdgeFollowedByClass {
  EdgeFollowedByClass({
    this.count,
  });

  int? count;

  factory EdgeFollowedByClass.fromJson(Map<String, dynamic> json) =>
      EdgeFollowedByClass(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}

class SharingFrictionInfo {
  SharingFrictionInfo({
    this.shouldHaveSharingFriction,
    this.bloksAppUrl,
  });

  bool? shouldHaveSharingFriction;
  dynamic bloksAppUrl;

  factory SharingFrictionInfo.fromJson(Map<String, dynamic> json) =>
      SharingFrictionInfo(
        shouldHaveSharingFriction: json["should_have_sharing_friction"],
        bloksAppUrl: json["bloks_app_url"],
      );

  Map<String, dynamic> toJson() => {
        "should_have_sharing_friction": shouldHaveSharingFriction,
        "bloks_app_url": bloksAppUrl,
      };
}
