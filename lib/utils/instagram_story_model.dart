// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.tray,
    this.storyRankingToken,
    this.broadcasts,
    this.stickerVersion,
    this.faceFilterNuxVersion,
    this.storiesViewerGesturesNuxEligible,
    this.hasNewNuxStory,
    this.refreshWindowMs,
    this.responseTimestamp,
    this.status,
  });

  List<Tray>? tray;
  String? storyRankingToken;
  List<dynamic>? broadcasts;
  int? stickerVersion;
  int? faceFilterNuxVersion;
  bool? storiesViewerGesturesNuxEligible;
  bool? hasNewNuxStory;
  int? refreshWindowMs;
  int? responseTimestamp;
  String? status;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        tray: List<Tray>.from(json["tray"].map((x) => Tray.fromJson(x))),
        storyRankingToken: json["story_ranking_token"],
        broadcasts: List<dynamic>.from(json["broadcasts"].map((x) => x)),
        stickerVersion: json["sticker_version"],
        faceFilterNuxVersion: json["face_filter_nux_version"],
        storiesViewerGesturesNuxEligible:
            json["stories_viewer_gestures_nux_eligible"],
        hasNewNuxStory: json["has_new_nux_story"],
        refreshWindowMs: json["refresh_window_ms"],
        responseTimestamp: json["response_timestamp"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tray": List<dynamic>.from(tray!.map((x) => x.toJson())),
        "story_ranking_token": storyRankingToken,
        "broadcasts": List<dynamic>.from(broadcasts!.map((x) => x)),
        "sticker_version": stickerVersion,
        "face_filter_nux_version": faceFilterNuxVersion,
        "stories_viewer_gestures_nux_eligible":
            storiesViewerGesturesNuxEligible,
        "has_new_nux_story": hasNewNuxStory,
        "refresh_window_ms": refreshWindowMs,
        "response_timestamp": responseTimestamp,
        "status": status,
      };
}


class Tray {
  Tray({
    this.id,
    this.latestReelMedia,
    this.expiringAt,
    this.seen,
    this.canReply,
    this.canGifQuickReply,
    this.canReshare,
    this.reelType,
    this.isSensitiveVerticalAd,
    this.user,
    this.rankedPosition,
    this.seenRankedPosition,
    this.muted,
    this.prefetchCount,
    this.hasBestiesMedia,
    this.latestBestiesReelMedia,
    this.mediaCount,
    this.hasVideo,
    this.hasPrideMedia,
    this.items,
  });

  int? id;
  int? latestReelMedia;
  int? expiringAt;
  int? seen;
  bool? canReply;
  bool? canGifQuickReply;
  bool? canReshare;
  ReelType? reelType;
  bool? isSensitiveVerticalAd;
  TrayUser? user;
  int? rankedPosition;
  int? seenRankedPosition;
  bool? muted;
  int? prefetchCount;
  bool? hasBestiesMedia;
  double? latestBestiesReelMedia;
  int? mediaCount;
  bool? hasVideo;
  bool? hasPrideMedia;
  List<Item>? items;

  factory Tray.fromJson(Map<String, dynamic> json) => Tray(
        id: json["id"],
        latestReelMedia: json["latest_reel_media"],
        expiringAt: json["expiring_at"],
        seen: json["seen"],
        canReply: json["can_reply"],
        canGifQuickReply: json["can_gif_quick_reply"],
        canReshare: json["can_reshare"],
        reelType: reelTypeValues.map![json["reel_type"]],
        isSensitiveVerticalAd: json["is_sensitive_vertical_ad"],
        user: TrayUser.fromJson(json["user"]),
        rankedPosition: json["ranked_position"],
        seenRankedPosition: json["seen_ranked_position"],
        muted: json["muted"],
        prefetchCount: json["prefetch_count"],
        hasBestiesMedia: json["has_besties_media"],
        latestBestiesReelMedia: json["latest_besties_reel_media"],
        mediaCount: json["media_count"],
        hasVideo: json["has_video"],
        hasPrideMedia: json["has_pride_media"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latest_reel_media": latestReelMedia,
        "expiring_at": expiringAt,
        "seen": seen,
        "can_reply": canReply,
        "can_gif_quick_reply": canGifQuickReply,
        "can_reshare": canReshare,
        "reel_type": reelTypeValues.reverse![reelType],
        "is_sensitive_vertical_ad": isSensitiveVerticalAd,
        "user": user!.toJson(),
        "ranked_position": rankedPosition,
        "seen_ranked_position": seenRankedPosition,
        "muted": muted,
        "prefetch_count": prefetchCount,
        "has_besties_media": hasBestiesMedia,
        "latest_besties_reel_media": latestBestiesReelMedia,
        "media_count": mediaCount,
        "has_video": hasVideo,
        "has_pride_media": hasPrideMedia,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.takenAt,
    this.pk,
    this.id,
    this.deviceTimestamp,
    this.mediaType,
    this.code,
    this.clientCacheKey,
    this.filterType,
    this.captionIsEdited,
    this.imageVersions2,
    this.originalWidth,
    this.originalHeight,
    this.captionPosition,
    this.isReelMedia,
    this.photoOfYou,
    this.canSeeInsightsAsBrand,
    this.caption,
    this.organicTrackingToken,
    this.expiringAt,
    this.importedTakenAt,
    this.sharingFrictionInfo,
    this.isInProfileGrid,
    this.profileGridControlEnabled,
    this.isShopTheLookEligible,
    this.deletedReason,
    this.integrityReviewDecision,
    this.user,
    this.canReshare,
    this.canReply,
    this.storyStaticModels,
    this.supportsReelReactions,
    this.canSendCustomEmojis,
    this.showOneTapFbShareTooltip,
    this.videoVersions,
    this.hasAudio,
    this.videoDuration,
  });

  int? takenAt;
  double? pk;
  String? id;
  int? deviceTimestamp;
  int? mediaType;
  String? code;
  String? clientCacheKey;
  int? filterType;
  bool? captionIsEdited;
  ImageVersions2? imageVersions2;
  int? originalWidth;
  int? originalHeight;
  double? captionPosition;
  bool? isReelMedia;
  bool? photoOfYou;
  bool? canSeeInsightsAsBrand;
  dynamic caption;
  String? organicTrackingToken;
  int? expiringAt;
  int? importedTakenAt;
  SharingFrictionInfo? sharingFrictionInfo;
  bool? isInProfileGrid;
  bool? profileGridControlEnabled;
  bool? isShopTheLookEligible;
  int? deletedReason;
  String? integrityReviewDecision;
  ItemUser? user;
  bool? canReshare;
  bool? canReply;
  List<dynamic>? storyStaticModels;
  bool? supportsReelReactions;
  bool? canSendCustomEmojis;
  bool? showOneTapFbShareTooltip;
  List<VideoVersion>? videoVersions;
  bool? hasAudio;
  double? videoDuration;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        takenAt: json["taken_at"],
        pk: json["pk"].toDouble(),
        id: json["id"],
        deviceTimestamp: json["device_timestamp"],
        mediaType: json["media_type"],
        code: json["code"],
        clientCacheKey: json["client_cache_key"],
        filterType: json["filter_type"],
        captionIsEdited: json["caption_is_edited"],
        imageVersions2: ImageVersions2.fromJson(json["image_versions2"]),
        originalWidth: json["original_width"],
        originalHeight: json["original_height"],
        captionPosition: json["caption_position"],
        isReelMedia: json["is_reel_media"],
        photoOfYou: json["photo_of_you"],
        canSeeInsightsAsBrand: json["can_see_insights_as_brand"],
        caption: json["caption"],
        organicTrackingToken: json["organic_tracking_token"],
        expiringAt: json["expiring_at"],
        importedTakenAt: json["imported_taken_at"],
        sharingFrictionInfo:
            SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        isInProfileGrid: json["is_in_profile_grid"],
        profileGridControlEnabled: json["profile_grid_control_enabled"],
        isShopTheLookEligible: json["is_shop_the_look_eligible"],
        deletedReason: json["deleted_reason"],
        integrityReviewDecision: json["integrity_review_decision"],
        user: ItemUser.fromJson(json["user"]),
        canReshare: json["can_reshare"],
        canReply: json["can_reply"],
        storyStaticModels:
            List<dynamic>.from(json["story_static_models"].map((x) => x)),
        supportsReelReactions: json["supports_reel_reactions"],
        canSendCustomEmojis: json["can_send_custom_emojis"],
        showOneTapFbShareTooltip: json["show_one_tap_fb_share_tooltip"],
        videoVersions: json["video_versions"] == null
            ? null
            : List<VideoVersion>.from(
                json["video_versions"].map((x) => VideoVersion.fromJson(x))),
        hasAudio: json["has_audio"] == null ? null : json["has_audio"],
        videoDuration: json["video_duration"] == null
            ? null
            : json["video_duration"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "taken_at": takenAt,
        "pk": pk,
        "id": id,
        "device_timestamp": deviceTimestamp,
        "media_type": mediaType,
        "code": code,
        "client_cache_key": clientCacheKey,
        "filter_type": filterType,
        "caption_is_edited": captionIsEdited,
        "image_versions2": imageVersions2!.toJson(),
        "original_width": originalWidth,
        "original_height": originalHeight,
        "caption_position": captionPosition,
        "is_reel_media": isReelMedia,
        "photo_of_you": photoOfYou,
        "can_see_insights_as_brand": canSeeInsightsAsBrand,
        "caption": caption,
        "organic_tracking_token": organicTrackingToken,
        "expiring_at": expiringAt,
        "imported_taken_at": importedTakenAt,
        "sharing_friction_info": sharingFrictionInfo!.toJson(),
        "is_in_profile_grid": isInProfileGrid,
        "profile_grid_control_enabled": profileGridControlEnabled,
        "is_shop_the_look_eligible": isShopTheLookEligible,
        "deleted_reason": deletedReason,
        "integrity_review_decision": integrityReviewDecision,
        "user": user!.toJson(),
        "can_reshare": canReshare,
        "can_reply": canReply,
        "story_static_models":
            List<dynamic>.from(storyStaticModels!.map((x) => x)),
        "supports_reel_reactions": supportsReelReactions,
        "can_send_custom_emojis": canSendCustomEmojis,
        "show_one_tap_fb_share_tooltip": showOneTapFbShareTooltip,
        "video_versions": videoVersions == null
            ? null
            : List<dynamic>.from(videoVersions!.map((x) => x.toJson())),
        "has_audio": hasAudio == null ? null : hasAudio,
        "video_duration": videoDuration == null ? null : videoDuration,
      };
}

class ImageVersions2 {
  ImageVersions2({
    this.candidates,
  });

  List<Candidate>? candidates;

  factory ImageVersions2.fromJson(Map<String, dynamic> json) => ImageVersions2(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates!.map((x) => x.toJson())),
      };
}

class Candidate {
  Candidate({
    this.width,
    this.height,
    this.url,
    this.scansProfile,
  });

  int? width;
  int? height;
  String? url;
  ScansProfile? scansProfile;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        scansProfile: scansProfileValues.map![json["scans_profile"]],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "scans_profile": scansProfileValues.reverse![scansProfile],
      };
}

enum ScansProfile { E35, E15 }

final scansProfileValues =
    EnumValues({"e15": ScansProfile.E15, "e35": ScansProfile.E35});

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

class ItemUser {
  ItemUser({
    this.pk,
    this.isPrivate,
  });

  int? pk;
  bool? isPrivate;

  factory ItemUser.fromJson(Map<String, dynamic> json) => ItemUser(
        pk: json["pk"],
        isPrivate: json["is_private"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "is_private": isPrivate,
      };
}

class VideoVersion {
  VideoVersion({
    this.type,
    this.width,
    this.height,
    this.url,
    this.id,
  });

  int? type;
  int? width;
  int? height;
  String? url;
  String? id;

  factory VideoVersion.fromJson(Map<String, dynamic> json) => VideoVersion(
        type: json["type"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "width": width,
        "height": height,
        "url": url,
        "id": id,
      };
}

enum ReelType { USER_REEL }

final reelTypeValues = EnumValues({"user_reel": ReelType.USER_REEL});

class TrayUser {
  TrayUser({
    this.pk,
    this.username,
    this.fullName,
    this.isPrivate,
    this.profilePicUrl,
    this.profilePicId,
    this.isVerified,
    this.friendshipStatus,
  });

  int? pk;
  String? username;
  String? fullName;
  bool? isPrivate;
  String? profilePicUrl;
  String? profilePicId;
  bool? isVerified;
  FriendshipStatus? friendshipStatus;

  factory TrayUser.fromJson(Map<String, dynamic> json) => TrayUser(
        pk: json["pk"],
        username: json["username"],
        fullName: json["full_name"],
        isPrivate: json["is_private"],
        profilePicUrl: json["profile_pic_url"],
        profilePicId:
            json["profile_pic_id"] == null ? null : json["profile_pic_id"],
        isVerified: json["is_verified"],
        friendshipStatus: FriendshipStatus.fromJson(json["friendship_status"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "full_name": fullName,
        "is_private": isPrivate,
        "profile_pic_url": profilePicUrl,
        "profile_pic_id": profilePicId == null ? null : profilePicId,
        "is_verified": isVerified,
        "friendship_status": friendshipStatus!.toJson(),
      };
}

class FriendshipStatus {
  FriendshipStatus({
    this.muting,
    this.isMutingReel,
    this.following,
    this.isBestie,
    this.outgoingRequest,
  });

  bool? muting;
  bool? isMutingReel;
  bool? following;
  bool? isBestie;
  bool? outgoingRequest;

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) =>
      FriendshipStatus(
        muting: json["muting"],
        isMutingReel: json["is_muting_reel"],
        following: json["following"],
        isBestie: json["is_bestie"],
        outgoingRequest: json["outgoing_request"],
      );

  Map<String, dynamic> toJson() => {
        "muting": muting,
        "is_muting_reel": isMutingReel,
        "following": following,
        "is_bestie": isBestie,
        "outgoing_request": outgoingRequest,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
