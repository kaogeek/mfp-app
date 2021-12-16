// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PostPageSS welcomeFromJson(String str) => PostPageSS.fromJson(json.decode(str));

String welcomeToJson(PostPageSS data) => json.encode(data.toJson());


class PostPageSS {
    PostPageSS({
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
        this.story,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
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
    Story story;
    String pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    List<dynamic> comment;
    List<GalleryPostPageSS> gallery;
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

    factory PostPageSS.fromJson(Map<String, dynamic> json) => PostPageSS(
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
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
        pageId: json["pageId"],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        comment: List<dynamic>.from(json["comment"].map((x) => x)),
        gallery: List<GalleryPostPageSS>.from(json["gallery"].map((x) => GalleryPostPageSS.fromJson(x))),
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
        "story": story == null ? null : story.toJson(),
        "pageId": pageId,
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
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

class GalleryPostPageSS {
    GalleryPostPageSS({
        this.id,
        this.post,
        this.fileId,
        this.imageUrl,
        this.s3ImageUrl,
        this.ordering,
        this.signUrl,
    });

    String id;
    String post;
    String fileId;
    String imageUrl;
    String s3ImageUrl;
    int ordering;
    String signUrl;

    factory GalleryPostPageSS.fromJson(Map<String, dynamic> json) => GalleryPostPageSS(
        id: json["_id"],
        post: json["post"],
        fileId: json["fileId"],
        imageUrl: json["imageURL"],
        s3ImageUrl: json["s3ImageURL"],
        ordering: json["ordering"],
        signUrl: json["signURL"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "fileId": fileId,
        "imageURL": imageUrl,
        "s3ImageURL": s3ImageUrl,
        "ordering": ordering,
        "signURL": signUrl,
    };
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

class Story {
    Story();

    factory Story.fromJson(Map<String, dynamic> json) => Story(
    );

    Map<String, dynamic> toJson() => {
    };
}

