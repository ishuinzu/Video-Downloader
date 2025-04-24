// To parse this JSON data, do
//
//     final instaStoryReelFeedData = instaStoryReelFeedDataFromJson(jsonString);

import 'dart:convert';

InstaStoryReelFeedData instaStoryReelFeedDataFromJson(String str) =>
    InstaStoryReelFeedData.fromJson(json.decode(str));

String instaStoryReelFeedDataToJson(InstaStoryReelFeedData data) =>
    json.encode(data.toJson());

class InstaStoryReelFeedData {
  InstaStoryReelFeedData({
    //  this.userDetail,
    this.feed,
    this.reelFeed,
    this.userStory,
    this.status,
  });

  //UserDetail userDetail;
  Feed? feed;
  Reel? reelFeed;
  UserStory? userStory;
  String? status;

  factory InstaStoryReelFeedData.fromJson(Map<String, dynamic> json) =>
      InstaStoryReelFeedData(
        // userDetail: UserDetail.fromJson(json["user_detail"]),
        feed: Feed.fromJson(json["feed"]),
        reelFeed: Reel.fromJson(json["reel_feed"]),
        userStory: UserStory.fromJson(json["user_story"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        // "user_detail": userDetail.toJson(),
        "feed": feed!.toJson(),
        "reel_feed": reelFeed!.toJson(),
        "user_story": userStory!.toJson(),
        "status": status,
      };
}

class Feed {
  Feed({
    this.items,
    this.numResults,
    this.moreAvailable,
    this.nextMaxId,
    this.autoLoadMoreEnabled,
  });

  List<FeedItem>? items;
  int? numResults;
  bool? moreAvailable;
  String? nextMaxId;
  bool? autoLoadMoreEnabled;

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        items:
            List<FeedItem>.from(json["items"].map((x) => FeedItem.fromJson(x))),
        numResults: json["num_results"],
        moreAvailable: json["more_available"],
        nextMaxId: json["next_max_id"],
        autoLoadMoreEnabled: json["auto_load_more_enabled"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "num_results": numResults,
        "more_available": moreAvailable,
        "next_max_id": nextMaxId,
        "auto_load_more_enabled": autoLoadMoreEnabled,
      };
}

class FeedItem {
  FeedItem({
    this.takenAt,
    this.pk,
    this.id,
    this.deviceTimestamp,
    this.mediaType,
    this.code,
    this.clientCacheKey,
    this.filterType,
    this.location,
    this.lat,
    this.lng,
    this.shouldRequestAds,
    this.user,
    this.canViewerReshare,
    this.captionIsEdited,
    this.commentLikesEnabled,
    this.commentThreadingEnabled,
    this.hasMoreComments,
    this.nextMaxId,
    this.maxNumVisiblePreviewComments,
    // this.previewComments,
    this.canViewMorePreviewComments,
    this.commentCount,
    this.inlineComposerDisplayCondition,
    this.imageVersions2,
    this.originalWidth,
    this.originalHeight,
    this.likeCount,
    this.hasLiked,
    this.topLikers,
    this.facepileTopLikers,
    this.photoOfYou,
    this.canSeeInsightsAsBrand,
    //this.caption,
    this.organicTrackingToken,
    this.sharingFrictionInfo,
    this.isInProfileGrid,
    this.profileGridControlEnabled,
    this.isShopTheLookEligible,
    this.deletedReason,
    this.integrityReviewDecision,
    this.usertags,
  });

  int? takenAt;
  double? pk;
  String? id;
  int? deviceTimestamp;
  int? mediaType;
  String? code;
  String? clientCacheKey;
  int? filterType;
  Location? location;
  double? lat;
  double? lng;
  bool? shouldRequestAds;
  CaptionUser? user;
  bool? canViewerReshare;
  bool? captionIsEdited;
  bool? commentLikesEnabled;
  bool? commentThreadingEnabled;
  bool? hasMoreComments;
  double? nextMaxId;
  int? maxNumVisiblePreviewComments;

  //List<PreviewComment> previewComments;
  bool? canViewMorePreviewComments;
  int? commentCount;
  InlineComposerDisplayCondition? inlineComposerDisplayCondition;
  ImageVersions2? imageVersions2;
  int? originalWidth;
  int? originalHeight;
  int? likeCount;
  bool? hasLiked;
  List<dynamic>? topLikers;
  List<dynamic>? facepileTopLikers;
  bool? photoOfYou;
  bool? canSeeInsightsAsBrand;

  //Caption caption;
  String? organicTrackingToken;
  SharingFrictionInfo? sharingFrictionInfo;
  bool? isInProfileGrid;
  bool? profileGridControlEnabled;
  bool? isShopTheLookEligible;
  int? deletedReason;
  IntegrityReviewDecision? integrityReviewDecision;
  Usertags? usertags;

  factory FeedItem.fromJson(Map<String, dynamic> json) => FeedItem(
        takenAt: json["taken_at"],
        pk: json["pk"].toDouble(),
        id: json["id"],
        deviceTimestamp: json["device_timestamp"],
        mediaType: json["media_type"],
        code: json["code"],
        clientCacheKey: json["client_cache_key"],
        filterType: json["filter_type"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        shouldRequestAds: json["should_request_ads"],
        user: CaptionUser.fromJson(json["user"]),
        canViewerReshare: json["can_viewer_reshare"],
        captionIsEdited: json["caption_is_edited"],
        commentLikesEnabled: json["comment_likes_enabled"],
        commentThreadingEnabled: json["comment_threading_enabled"],
        hasMoreComments: json["has_more_comments"],
        nextMaxId:
            json["next_max_id"] == null ? null : json["next_max_id"].toDouble(),
        maxNumVisiblePreviewComments: json["max_num_visible_preview_comments"],
        // previewComments: List<PreviewComment>.from(
        //     json["preview_comments"].map((x) => PreviewComment.fromJson(x))),
        canViewMorePreviewComments: json["can_view_more_preview_comments"],
        commentCount: json["comment_count"],
        inlineComposerDisplayCondition: inlineComposerDisplayConditionValues
            .map![json["inline_composer_display_condition"]],
        imageVersions2: ImageVersions2.fromJson(json["image_versions2"]),
        originalWidth: json["original_width"],
        originalHeight: json["original_height"],
        likeCount: json["like_count"],
        hasLiked: json["has_liked"],
        topLikers: List<dynamic>.from(json["top_likers"].map((x) => x)),
        facepileTopLikers:
            List<dynamic>.from(json["facepile_top_likers"].map((x) => x)),
        photoOfYou: json["photo_of_you"],
        canSeeInsightsAsBrand: json["can_see_insights_as_brand"],
        //  caption: Caption.fromJson(json["caption"]),
        organicTrackingToken: json["organic_tracking_token"],
        sharingFrictionInfo:
            SharingFrictionInfo.fromJson(json["sharing_friction_info"]),
        isInProfileGrid: json["is_in_profile_grid"],
        profileGridControlEnabled: json["profile_grid_control_enabled"],
        isShopTheLookEligible: json["is_shop_the_look_eligible"],
        deletedReason: json["deleted_reason"],
        integrityReviewDecision: integrityReviewDecisionValues
            .map![json["integrity_review_decision"]],
        usertags: json["usertags"] == null
            ? null
            : Usertags.fromJson(json["usertags"]),
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
        "location": location == null ? null : location!.toJson(),
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "should_request_ads": shouldRequestAds,
        "user": user!.toJson(),
        "can_viewer_reshare": canViewerReshare,
        "caption_is_edited": captionIsEdited,
        "comment_likes_enabled": commentLikesEnabled,
        "comment_threading_enabled": commentThreadingEnabled,
        "has_more_comments": hasMoreComments,
        "next_max_id": nextMaxId == null ? null : nextMaxId,
        "max_num_visible_preview_comments": maxNumVisiblePreviewComments,
        // "preview_comments": List<dynamic>.from(
        //     previewComments.map((x) => x.toJson())),
        "can_view_more_preview_comments": canViewMorePreviewComments,
        "comment_count": commentCount,
        "inline_composer_display_condition":
            inlineComposerDisplayConditionValues
                .reverse![inlineComposerDisplayCondition],
        "image_versions2": imageVersions2!.toJson(),
        "original_width": originalWidth,
        "original_height": originalHeight,
        "like_count": likeCount,
        "has_liked": hasLiked,
        "top_likers": List<dynamic>.from(topLikers!.map((x) => x)),
        "facepile_top_likers":
            List<dynamic>.from(facepileTopLikers!.map((x) => x)),
        "photo_of_you": photoOfYou,
        "can_see_insights_as_brand": canSeeInsightsAsBrand,
        //"caption": caption.toJson(),
        "organic_tracking_token": organicTrackingToken,
        "sharing_friction_info": sharingFrictionInfo!.toJson(),
        "is_in_profile_grid": isInProfileGrid,
        "profile_grid_control_enabled": profileGridControlEnabled,
        "is_shop_the_look_eligible": isShopTheLookEligible,
        "deleted_reason": deletedReason,
        "integrity_review_decision":
            integrityReviewDecisionValues.reverse![integrityReviewDecision],
        "usertags": usertags == null ? null : usertags!.toJson(),
      };
}

enum ContentType { COMMENT }

final contentTypeValues = EnumValues({"comment": ContentType.COMMENT});

enum Status { ACTIVE }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class CaptionUser {
  CaptionUser({
    this.pk,
    this.username,
    this.fullName,
    this.isPrivate,
    this.profilePicUrl,
    this.profilePicId,
    this.isVerified,
    this.hasAnonymousProfilePicture,
    this.isUnpublished,
    this.isFavorite,
    this.latestReelMedia,
    this.storyReelMediaIds,
  });

  int? pk;
  Username? username;
  FullName? fullName;
  bool? isPrivate;
  String? profilePicUrl;
  ProfilePicId? profilePicId;
  bool? isVerified;
  bool? hasAnonymousProfilePicture;
  bool? isUnpublished;
  bool? isFavorite;
  int? latestReelMedia;
  List<dynamic>? storyReelMediaIds;

  factory CaptionUser.fromJson(Map<String, dynamic> json) => CaptionUser(
        pk: json["pk"],
        username: usernameValues.map![json["username"]],
        fullName: fullNameValues.map![json["full_name"]],
        isPrivate: json["is_private"],
        profilePicUrl: json["profile_pic_url"],
        profilePicId: profilePicIdValues.map![json["profile_pic_id"]],
        isVerified: json["is_verified"],
        hasAnonymousProfilePicture: json["has_anonymous_profile_picture"],
        isUnpublished: json["is_unpublished"],
        isFavorite: json["is_favorite"],
        latestReelMedia: json["latest_reel_media"] == null
            ? null
            : json["latest_reel_media"],
        storyReelMediaIds: json["story_reel_media_ids"] == null
            ? null
            : List<dynamic>.from(json["story_reel_media_ids"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": usernameValues.reverse![username],
        "full_name": fullNameValues.reverse![fullName],
        "is_private": isPrivate,
        "profile_pic_url": profilePicUrl,
        "profile_pic_id": profilePicIdValues.reverse![profilePicId],
        "is_verified": isVerified,
        "has_anonymous_profile_picture": hasAnonymousProfilePicture,
        "is_unpublished": isUnpublished,
        "is_favorite": isFavorite,
        "latest_reel_media": latestReelMedia == null ? null : latestReelMedia,
        "story_reel_media_ids": storyReelMediaIds == null
            ? null
            : List<dynamic>.from(storyReelMediaIds!.map((x) => x)),
      };
}

enum FullName { POOJA_HEGDE }

final fullNameValues = EnumValues({"Pooja Hegde": FullName.POOJA_HEGDE});

enum ProfilePicId { THE_2454363035815259612287472860 }

final profilePicIdValues = EnumValues({
  "2454363035815259612_287472860": ProfilePicId.THE_2454363035815259612287472860
});

enum Username { HEGDEPOOJA }

final usernameValues = EnumValues({"hegdepooja": Username.HEGDEPOOJA});

class ImageVersions2 {
  ImageVersions2({
    this.candidates,
  });

  List<HdProfilePicUrlInfo>? candidates;

  factory ImageVersions2.fromJson(Map<String, dynamic> json) => ImageVersions2(
        candidates: List<HdProfilePicUrlInfo>.from(
            json["candidates"].map((x) => HdProfilePicUrlInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates!.map((x) => x.toJson())),
      };
}

class HdProfilePicUrlInfo {
  HdProfilePicUrlInfo({
    this.width,
    this.height,
    this.url,
    this.scansProfile,
  });

  int? width;
  int? height;
  String? url;
  ScansProfile? scansProfile;

  factory HdProfilePicUrlInfo.fromJson(Map<String, dynamic> json) =>
      HdProfilePicUrlInfo(
        width: json["width"],
        height: json["height"],
        url: json["url"],
        scansProfile: json["scans_profile"] == null
            ? null
            : scansProfileValues.map![json["scans_profile"]],
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "url": url,
        "scans_profile": scansProfile == null
            ? null
            : scansProfileValues.reverse![scansProfile],
      };
}

enum ScansProfile { E35, E15 }

final scansProfileValues =
    EnumValues({"e15": ScansProfile.E15, "e35": ScansProfile.E35});

enum InlineComposerDisplayCondition { IMPRESSION_TRIGGER }

final inlineComposerDisplayConditionValues = EnumValues(
    {"impression_trigger": InlineComposerDisplayCondition.IMPRESSION_TRIGGER});

enum IntegrityReviewDecision { PENDING }

final integrityReviewDecisionValues =
    EnumValues({"pending": IntegrityReviewDecision.PENDING});

class Location {
  Location({
    this.pk,
    this.shortName,
    this.facebookPlacesId,
    this.externalSource,
    this.name,
    this.address,
    this.city,
    this.lng,
    this.lat,
  });

  int? pk;
  String? shortName;
  int? facebookPlacesId;
  String? externalSource;
  String? name;
  String? address;
  String? city;
  double? lng;
  double? lat;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        pk: json["pk"],
        shortName: json["short_name"],
        facebookPlacesId: json["facebook_places_id"],
        externalSource: json["external_source"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "short_name": shortName,
        "facebook_places_id": facebookPlacesId,
        "external_source": externalSource,
        "name": name,
        "address": address,
        "city": city,
        "lng": lng == null ? null : lng,
        "lat": lat == null ? null : lat,
      };
}

class PreviewCommentUser {
  PreviewCommentUser({
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

  factory PreviewCommentUser.fromJson(Map<String, dynamic> json) =>
      PreviewCommentUser(
        pk: json["pk"],
        username: json["username"],
        fullName: json["full_name"],
        isPrivate: json["is_private"],
        profilePicUrl: json["profile_pic_url"],
        profilePicId:
            json["profile_pic_id"] == null ? null : json["profile_pic_id"],
        isVerified: json["is_verified"],
        friendshipStatus: json["friendship_status"] == null
            ? null
            : FriendshipStatus.fromJson(json["friendship_status"]),
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "username": username,
        "full_name": fullName,
        "is_private": isPrivate,
        "profile_pic_url": profilePicUrl,
        "profile_pic_id": profilePicId == null ? null : profilePicId,
        "is_verified": isVerified,
        "friendship_status":
            friendshipStatus == null ? null : friendshipStatus!.toJson(),
      };
}

class FriendshipStatus {
  FriendshipStatus({
    this.following,
    this.followedBy,
    this.blocking,
    this.muting,
    this.isPrivate,
    this.incomingRequest,
    this.outgoingRequest,
    this.isBestie,
    this.isRestricted,
    this.isBlockingReel,
    this.isMutingReel,
  });

  bool? following;
  bool? followedBy;
  bool? blocking;
  bool? muting;
  bool? isPrivate;
  bool? incomingRequest;
  bool? outgoingRequest;
  bool? isBestie;
  bool? isRestricted;
  bool? isBlockingReel;
  bool? isMutingReel;

  factory FriendshipStatus.fromJson(Map<String, dynamic> json) =>
      FriendshipStatus(
        following: json["following"],
        followedBy: json["followed_by"],
        blocking: json["blocking"],
        muting: json["muting"],
        isPrivate: json["is_private"],
        incomingRequest: json["incoming_request"],
        outgoingRequest: json["outgoing_request"],
        isBestie: json["is_bestie"],
        isRestricted: json["is_restricted"],
        isBlockingReel:
            json["is_blocking_reel"] == null ? null : json["is_blocking_reel"],
        isMutingReel:
            json["is_muting_reel"] == null ? null : json["is_muting_reel"],
      );

  Map<String, dynamic> toJson() => {
        "following": following,
        "followed_by": followedBy,
        "blocking": blocking,
        "muting": muting,
        "is_private": isPrivate,
        "incoming_request": incomingRequest,
        "outgoing_request": outgoingRequest,
        "is_bestie": isBestie,
        "is_restricted": isRestricted,
        "is_blocking_reel": isBlockingReel == null ? null : isBlockingReel,
        "is_muting_reel": isMutingReel == null ? null : isMutingReel,
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

class Usertags {
  Usertags({
    this.usertagsIn,
  });

  List<In>? usertagsIn;

  factory Usertags.fromJson(Map<String, dynamic> json) => Usertags(
        usertagsIn: List<In>.from(json["in"].map((x) => In.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "in": List<dynamic>.from(usertagsIn!.map((x) => x.toJson())),
      };
}

class In {
  In({
    this.user,
    this.position,
    this.startTimeInVideoInSec,
    this.durationInVideoInSec,
  });

  PreviewCommentUser? user;
  List<double>? position;
  dynamic startTimeInVideoInSec;
  dynamic durationInVideoInSec;

  factory In.fromJson(Map<String, dynamic> json) => In(
        user: PreviewCommentUser.fromJson(json["user"]),
        position: List<double>.from(json["position"].map((x) => x.toDouble())),
        startTimeInVideoInSec: json["start_time_in_video_in_sec"],
        durationInVideoInSec: json["duration_in_video_in_sec"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "position": List<dynamic>.from(position!.map((x) => x)),
        "start_time_in_video_in_sec": startTimeInVideoInSec,
        "duration_in_video_in_sec": durationInVideoInSec,
      };
}

class Reel {
  Reel({
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
    this.items,
    this.prefetchCount,
    this.hasBestiesMedia,
    this.mediaCount,
    this.mediaIds,
  });

  int? id;
  int? latestReelMedia;
  int? expiringAt;
  int? seen;
  bool? canReply;
  bool? canGifQuickReply;
  bool? canReshare;
  String? reelType;
  bool? isSensitiveVerticalAd;
  PreviewCommentUser? user;
  List<ReelFeedItem>? items;
  int? prefetchCount;
  bool? hasBestiesMedia;
  int? mediaCount;
  List<double>? mediaIds;

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
        id: json["id"],
        latestReelMedia: json["latest_reel_media"],
        expiringAt: json["expiring_at"],
        seen: json["seen"],
        canReply: json["can_reply"],
        canGifQuickReply: json["can_gif_quick_reply"],
        canReshare: json["can_reshare"],
        reelType: json["reel_type"],
        isSensitiveVerticalAd: json["is_sensitive_vertical_ad"],
        user: PreviewCommentUser.fromJson(json["user"]),
        items: List<ReelFeedItem>.from(
            json["items"].map((x) => ReelFeedItem.fromJson(x))),
        prefetchCount: json["prefetch_count"],
        hasBestiesMedia: json["has_besties_media"],
        mediaCount: json["media_count"],
        mediaIds: List<double>.from(json["media_ids"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latest_reel_media": latestReelMedia,
        "expiring_at": expiringAt,
        "seen": seen,
        "can_reply": canReply,
        "can_gif_quick_reply": canGifQuickReply,
        "can_reshare": canReshare,
        "reel_type": reelType,
        "is_sensitive_vertical_ad": isSensitiveVerticalAd,
        "user": user!.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "prefetch_count": prefetchCount,
        "has_besties_media": hasBestiesMedia,
        "media_count": mediaCount,
        "media_ids": List<dynamic>.from(mediaIds!.map((x) => x)),
      };
}

class ReelFeedItem {
  ReelFeedItem({
    this.takenAt,
    this.pk,
    this.id,
    this.deviceTimestamp,
    this.mediaType,
    this.code,
    this.clientCacheKey,
    this.filterType,
    this.user,
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
    this.canReshare,
    this.canReply,
    this.storyStaticModels,
    this.supportsReelReactions,
    this.canSendCustomEmojis,
    this.showOneTapFbShareTooltip,
    this.videoVersions,
    this.hasAudio,
    this.videoDuration,
    this.reelMentions,
  });

  int? takenAt;
  double? pk;
  String? id;
  int? deviceTimestamp;
  int? mediaType;
  String? code;
  String? clientCacheKey;
  int? filterType;
  CaptionUser? user;
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
  IntegrityReviewDecision? integrityReviewDecision;
  bool? canReshare;
  bool? canReply;
  List<dynamic>? storyStaticModels;
  bool? supportsReelReactions;
  bool? canSendCustomEmojis;
  bool? showOneTapFbShareTooltip;
  List<VideoVersion>? videoVersions;
  bool? hasAudio;
  double? videoDuration;
  List<ReelMention>? reelMentions;

  factory ReelFeedItem.fromJson(Map<String, dynamic> json) => ReelFeedItem(
        takenAt: json["taken_at"],
        pk: json["pk"].toDouble(),
        id: json["id"],
        deviceTimestamp: json["device_timestamp"],
        mediaType: json["media_type"],
        code: json["code"],
        clientCacheKey: json["client_cache_key"],
        filterType: json["filter_type"],
        user: CaptionUser.fromJson(json["user"]),
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
        integrityReviewDecision: integrityReviewDecisionValues
            .map![json["integrity_review_decision"]],
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
        videoDuration:
            json["video_duration"] == null ? null : json["video_duration"],
        reelMentions: json["reel_mentions"] == null
            ? null
            : List<ReelMention>.from(
                json["reel_mentions"].map((x) => ReelMention.fromJson(x))),
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
        "user": user!.toJson(),
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
        "integrity_review_decision":
            integrityReviewDecisionValues.reverse![integrityReviewDecision],
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
        "reel_mentions": reelMentions == null
            ? null
            : List<dynamic>.from(reelMentions!.map((x) => x.toJson())),
      };
}

class ReelMention {
  ReelMention({
    this.x,
    this.y,
    this.z,
    this.width,
    this.height,
    this.rotation,
    this.isPinned,
    this.isHidden,
    this.displayType,
    this.isSticker,
    this.isFbSticker,
    this.user,
  });

  double? x;
  double? y;
  int? z;
  double? width;
  double? height;
  double? rotation;
  int? isPinned;
  int? isHidden;
  String? displayType;
  int? isSticker;
  int? isFbSticker;
  PreviewCommentUser? user;

  factory ReelMention.fromJson(Map<String, dynamic> json) => ReelMention(
        x: json["x"].toDouble(),
        y: json["y"].toDouble(),
        z: json["z"],
        width: json["width"].toDouble(),
        height: json["height"].toDouble(),
        rotation: json["rotation"],
        isPinned: json["is_pinned"],
        isHidden: json["is_hidden"],
        displayType: json["display_type"],
        isSticker: json["is_sticker"],
        isFbSticker: json["is_fb_sticker"],
        user: PreviewCommentUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "z": z,
        "width": width,
        "height": height,
        "rotation": rotation,
        "is_pinned": isPinned,
        "is_hidden": isHidden,
        "display_type": displayType,
        "is_sticker": isSticker,
        "is_fb_sticker": isFbSticker,
        "user": user!.toJson(),
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

class ProfileContextLinksWithUserId {
  ProfileContextLinksWithUserId({
    this.start,
    this.end,
    this.username,
  });

  int? start;
  int? end;
  String? username;

  factory ProfileContextLinksWithUserId.fromJson(Map<String, dynamic> json) =>
      ProfileContextLinksWithUserId(
        start: json["start"],
        end: json["end"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "start": start,
        "end": end,
        "username": username,
      };
}

class UserStory {
  UserStory({
    this.reel,
    this.broadcast,
  });

  Reel? reel;
  dynamic broadcast;

  factory UserStory.fromJson(Map<String, dynamic> json) => UserStory(
        reel: Reel.fromJson(json["reel"]),
        broadcast: json["broadcast"],
      );

  Map<String, dynamic> toJson() => {
        "reel": reel!.toJson(),
        "broadcast": broadcast,
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
