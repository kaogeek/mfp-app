

import 'package:mfp_app/model/gallery.dart';

class PostDetailsModel {
    PostDetailsModel({
        this.id,
        this.title,
        this.detail,
        this.isDraft,
        this.hidden,
        this.type,
        this.userTags,
        this.coverImage,
        this.pinned,
        this.deleted,
        this.ownerUser,
        this.commentCount,
        this.repostCount,
        this.shareCount,
        this.likeCount,
        this.viewCount,
        this.createdDate,
        this.startDateTime,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.page,
        this.comment,
        this.gallery,
        this.needs,
        this.fulfillment,
        this.caseFulfillment,
        this.caseNeeds,
        this.socialPosts,
        this.hashTags,
        this.isRepost,
        this.isLike,
        this.likeAsPage,
        this.isComment,
              this.story,

    });

    String id;
    String title;
    String detail;
    bool isDraft;
    bool hidden;
    String type;
    List<dynamic> userTags;
    String coverImage;
    bool pinned;
    bool deleted;
    OwnerUser ownerUser;
    int commentCount;
    int repostCount;
    int shareCount;
    int likeCount;
    int viewCount;
    DateTime createdDate;
    DateTime startDateTime;
    String pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    List<Page> page;
    List<dynamic> comment;
    List<Gallery> gallery;
    List<dynamic> needs;
    List<dynamic> fulfillment;
    List<dynamic> caseFulfillment;
    List<dynamic> caseNeeds;
    List<dynamic> socialPosts;
    List<HashTag> hashTags;
    bool isRepost;
    bool isLike;
    bool likeAsPage;
    bool isComment;
      Story story;


    factory PostDetailsModel.fromJson(Map<String, dynamic> json) => PostDetailsModel(
        id: json["_id"],
        title: json["title"],
        detail: json["detail"],
        isDraft: json["isDraft"],
        hidden: json["hidden"],
        type: json["type"],
        userTags: List<dynamic>.from(json["userTags"].map((x) => x)),
        coverImage: json["coverImage"],
        pinned: json["pinned"],
        deleted: json["deleted"],
        ownerUser: OwnerUser.fromJson(json["ownerUser"]),
        commentCount: json["commentCount"],
        repostCount: json["repostCount"],
        shareCount: json["shareCount"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        createdDate: DateTime.parse(json["createdDate"]),
        startDateTime: DateTime.parse(json["startDateTime"]),
        pageId: json["pageId"],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        page: List<Page>.from(json["page"].map((x) => Page.fromJson(x))),
        comment: List<dynamic>.from(json["comment"].map((x) => x)),
        gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        needs: List<dynamic>.from(json["needs"].map((x) => x)),
        fulfillment: List<dynamic>.from(json["fulfillment"].map((x) => x)),
        caseFulfillment: List<dynamic>.from(json["caseFulfillment"].map((x) => x)),
        caseNeeds: List<dynamic>.from(json["caseNeeds"].map((x) => x)),
        socialPosts: List<dynamic>.from(json["socialPosts"].map((x) => x)),
        hashTags: List<HashTag>.from(json["hashTags"].map((x) => HashTag.fromJson(x))),
        isRepost: json["isRepost"],
        isLike: json["isLike"],
        likeAsPage: json["likeAsPage"],
        isComment: json["isComment"],
                        story: json["story"] == null ? null : Story.fromJson(json["story"]),

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "detail": detail,
        "isDraft": isDraft,
        "hidden": hidden,
        "type": type,
        "userTags": List<dynamic>.from(userTags.map((x) => x)),
        "coverImage": coverImage,
        "pinned": pinned,
        "deleted": deleted,
        "ownerUser": ownerUser.toJson(),
        "commentCount": commentCount,
        "repostCount": repostCount,
        "shareCount": shareCount,
        "likeCount": likeCount,
        "viewCount": viewCount,
        "createdDate": createdDate.toIso8601String(),
        "startDateTime": startDateTime.toIso8601String(),
        "pageId": pageId,
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
        "page": List<dynamic>.from(page.map((x) => x.toJson())),
        "comment": List<dynamic>.from(comment.map((x) => x)),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "needs": List<dynamic>.from(needs.map((x) => x)),
        "fulfillment": List<dynamic>.from(fulfillment.map((x) => x)),
        "caseFulfillment": List<dynamic>.from(caseFulfillment.map((x) => x)),
        "caseNeeds": List<dynamic>.from(caseNeeds.map((x) => x)),
        "socialPosts": List<dynamic>.from(socialPosts.map((x) => x)),
        "hashTags": List<dynamic>.from(hashTags.map((x) => x.toJson())),
        "isRepost": isRepost,
        "isLike": isLike,
        "likeAsPage": likeAsPage,
        "isComment": isComment,

    };
}
class Story {
  Story();

  factory Story.fromJson(Map<String, dynamic> json) => Story();

  Map<String, dynamic> toJson() => {};
}


class HashTag {
    HashTag({
        this.name,
    });

    String name;

    factory HashTag.fromJson(Map<String, dynamic> json) => HashTag(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class OwnerUser {
    OwnerUser({
        this.id,
        this.uniqueId,
        this.imageUrl,
        this.displayName,
    });

    String id;
    String uniqueId;
    String imageUrl;
    String displayName;

    factory OwnerUser.fromJson(Map<String, dynamic> json) => OwnerUser(
        id: json["_id"],
        uniqueId: json["uniqueId"],
        imageUrl: json["imageURL"],
        displayName: json["displayName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "uniqueId": uniqueId,
        "imageURL": imageUrl,
        "displayName": displayName,
    };
}

class Page {
    Page({
        this.id,
        this.name,
        this.pageUsername,
        this.subTitle,
        this.backgroundStory,
        this.detail,
        this.ownerUser,
        this.imageUrl,
        this.coverUrl,
        this.coverPosition,
        this.color,
        this.category,
        this.isOfficial,
        this.banned,
        this.createdDate,
        this.address,
        this.facebookUrl,
        this.instagramUrl,
        this.lineId,
        this.mobileNo,
        this.twitterUrl,
        this.websiteUrl,
        this.updateDate,
        this.updateByUsername,
    });

    String id;
    String name;
    String pageUsername;
    dynamic subTitle;
    dynamic backgroundStory;
    dynamic detail;
    String ownerUser;
    String imageUrl;
    String coverUrl;
    int coverPosition;
    dynamic color;
    String category;
    bool isOfficial;
    bool banned;
    DateTime createdDate;
    dynamic address;
    dynamic facebookUrl;
    dynamic instagramUrl;
    dynamic lineId;
    dynamic mobileNo;
    dynamic twitterUrl;
    dynamic websiteUrl;
    DateTime updateDate;
    String updateByUsername;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["_id"],
        name: json["name"],
        pageUsername: json["pageUsername"],
        subTitle: json["subTitle"],
        backgroundStory: json["backgroundStory"],
        detail: json["detail"],
        ownerUser: json["ownerUser"],
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"],
        coverPosition: json["coverPosition"],
        color: json["color"],
        category: json["category"],
        isOfficial: json["isOfficial"],
        banned: json["banned"],
        createdDate: DateTime.parse(json["createdDate"]),
        address: json["address"],
        facebookUrl: json["facebookURL"],
        instagramUrl: json["instagramURL"],
        lineId: json["lineId"],
        mobileNo: json["mobileNo"],
        twitterUrl: json["twitterURL"],
        websiteUrl: json["websiteURL"],
        updateDate: DateTime.parse(json["updateDate"]),
        updateByUsername: json["updateByUsername"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "pageUsername": pageUsername,
        "subTitle": subTitle,
        "backgroundStory": backgroundStory,
        "detail": detail,
        "ownerUser": ownerUser,
        "imageURL": imageUrl,
        "coverURL": coverUrl,
        "coverPosition": coverPosition,
        "color": color,
        "category": category,
        "isOfficial": isOfficial,
        "banned": banned,
        "createdDate": createdDate.toIso8601String(),
        "address": address,
        "facebookURL": facebookUrl,
        "instagramURL": instagramUrl,
        "lineId": lineId,
        "mobileNo": mobileNo,
        "twitterURL": twitterUrl,
        "websiteURL": websiteUrl,
        "updateDate": updateDate.toIso8601String(),
        "updateByUsername": updateByUsername,
    };
}
