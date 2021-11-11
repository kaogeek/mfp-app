
class ProfilePostModel {
    ProfilePostModel({
        this.id,
        this.title,
        this.type,
        this.pageId,
        this.detail,
        this.postsHashTags,
        this.coverImage,
        this.deleted,
        this.hidden,
        this.isDraft,
        this.pinned,
        this.ownerUser,
        this.createdDate,
        this.startDateTime,
        this.likeCount,
        this.viewCount,
        this.commentCount,
        this.repostCount,
        this.shareCount,
        this.visibility,
        this.ranges,
        this.postAsPage,
        this.referencePost,
        this.rootReferencePost,
        this.updateDate,
        this.gallery,
        this.story,
        this.isRepost,
        this.isLike,
        this.likeAsPage,
        this.isComment,
    });

    String id;
    String title;
    String type;
    dynamic pageId;
    String detail;
    List<dynamic> postsHashTags;
    dynamic coverImage;
    bool deleted;
    bool hidden;
    bool isDraft;
    bool pinned;
    String ownerUser;
    DateTime createdDate;
    DateTime startDateTime;
    int likeCount;
    int viewCount;
    int commentCount;
    int repostCount;
    int shareCount;
    dynamic visibility;
    dynamic ranges;
    dynamic postAsPage;
    String referencePost;
    String rootReferencePost;
    DateTime updateDate;
    List<dynamic> gallery;
    dynamic story;
    bool isRepost;
    bool isLike;
    bool likeAsPage;
    bool isComment;

    factory ProfilePostModel.fromJson(Map<String, dynamic> json) => ProfilePostModel(
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        pageId: json["pageId"],
        detail: json["detail"] == null ? null : json["detail"],
        postsHashTags: json["postsHashTags"] == null ? null : List<dynamic>.from(json["postsHashTags"].map((x) => x)),
        coverImage: json["coverImage"],
        deleted: json["deleted"] == null ? null : json["deleted"],
        hidden: json["hidden"] == null ? null : json["hidden"],
        isDraft: json["isDraft"] == null ? null : json["isDraft"],
        pinned: json["pinned"] == null ? null : json["pinned"],
        ownerUser: json["ownerUser"] == null ? null : json["ownerUser"],
        createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
        startDateTime: json["startDateTime"] == null ? null : DateTime.parse(json["startDateTime"]),
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        viewCount: json["viewCount"] == null ? null : json["viewCount"],
        commentCount: json["commentCount"] == null ? null : json["commentCount"],
        repostCount: json["repostCount"] == null ? null : json["repostCount"],
        shareCount: json["shareCount"] == null ? null : json["shareCount"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        postAsPage: json["postAsPage"],
        referencePost: json["referencePost"] == null ? null : json["referencePost"],
        rootReferencePost: json["rootReferencePost"] == null ? null : json["rootReferencePost"],
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        gallery: json["gallery"] == null ? null : List<dynamic>.from(json["gallery"].map((x) => x)),
        story: json["story"],
        isRepost: json["isRepost"] == null ? null : json["isRepost"],
        isLike: json["isLike"] == null ? null : json["isLike"],
        likeAsPage: json["likeAsPage"] == null ? null : json["likeAsPage"],
        isComment: json["isComment"] == null ? null : json["isComment"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "pageId": pageId,
        "detail": detail == null ? null : detail,
        "postsHashTags": postsHashTags == null ? null : List<dynamic>.from(postsHashTags.map((x) => x)),
        "coverImage": coverImage,
        "deleted": deleted == null ? null : deleted,
        "hidden": hidden == null ? null : hidden,
        "isDraft": isDraft == null ? null : isDraft,
        "pinned": pinned == null ? null : pinned,
        "ownerUser": ownerUser == null ? null : ownerUser,
        "createdDate": createdDate == null ? null : createdDate.toIso8601String(),
        "startDateTime": startDateTime == null ? null : startDateTime.toIso8601String(),
        "likeCount": likeCount == null ? null : likeCount,
        "viewCount": viewCount == null ? null : viewCount,
        "commentCount": commentCount == null ? null : commentCount,
        "repostCount": repostCount == null ? null : repostCount,
        "shareCount": shareCount == null ? null : shareCount,
        "visibility": visibility,
        "ranges": ranges,
        "postAsPage": postAsPage,
        "referencePost": referencePost == null ? null : referencePost,
        "rootReferencePost": rootReferencePost == null ? null : rootReferencePost,
        "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
        "gallery": gallery == null ? null : List<dynamic>.from(gallery.map((x) => x)),
        "story": story,
        "isRepost": isRepost == null ? null : isRepost,
        "isLike": isLike == null ? null : isLike,
        "likeAsPage": likeAsPage == null ? null : likeAsPage,
        "isComment": isComment == null ? null : isComment,
    };
}
