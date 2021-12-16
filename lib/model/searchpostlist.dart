import 'dart:convert';

SearchPostList testFromJson(String str) => SearchPostList.fromJson(json.decode(str));

String testToJson(SearchPostList data) => json.encode(data.toJson());


class SearchPostList {
    SearchPostList({
        this.post,
        this.user,
        this.page,
    });

    Post post;
    User user;
    Page page;

    factory SearchPostList.fromJson(Map<String, dynamic> json) => SearchPostList(
        post: Post.fromJson(json["post"]),
        user: User.fromJson(json["user"]),
        page: Page.fromJson(json["page"]),
    );

    Map<String, dynamic> toJson() => {
        "post": post.toJson(),
        "user": user.toJson(),
        "page": page.toJson(),
    };
}

class Page {
    Page({
        this.id,
        this.createdDate,
        this.updateDate,
        this.updateByUsername,
        this.name,
        this.pageUsername,
        this.imageUrl,
        this.coverUrl,
        this.coverPosition,
        this.ownerUser,
        this.isOfficial,
        this.category,
        this.banned,
        this.lineId,
        this.facebookUrl,
        this.twitterUrl,
        this.websiteUrl,
        this.mobileNo,
        this.address,
        this.email,
    });

    String id;
    DateTime createdDate;
    DateTime updateDate;
    String updateByUsername;
    String name;
    String pageUsername;
    String imageUrl;
    String coverUrl;
    int coverPosition;
    String ownerUser;
    bool isOfficial;
    String category;
    bool banned;
    String lineId;
    String facebookUrl;
    String twitterUrl;
    String websiteUrl;
    String mobileNo;
    String address;
    String email;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        updateByUsername: json["updateByUsername"],
        name: json["name"],
        pageUsername: json["pageUsername"],
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"],
        coverPosition: json["coverPosition"],
        ownerUser: json["ownerUser"],
        isOfficial: json["isOfficial"],
        category: json["category"],
        banned: json["banned"],
        lineId: json["lineId"],
        facebookUrl: json["facebookURL"],
        twitterUrl: json["twitterURL"],
        websiteUrl: json["websiteURL"],
        mobileNo: json["mobileNo"],
        address: json["address"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "updateByUsername": updateByUsername,
        "name": name,
        "pageUsername": pageUsername,
        "imageURL": imageUrl,
        "coverURL": coverUrl,
        "coverPosition": coverPosition,
        "ownerUser": ownerUser,
        "isOfficial": isOfficial,
        "category": category,
        "banned": banned,
        "lineId": lineId,
        "facebookURL": facebookUrl,
        "twitterURL": twitterUrl,
        "websiteURL": websiteUrl,
        "mobileNo": mobileNo,
        "address": address,
        "email": email,
    };
}

class Post {
    Post({
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
        this.total,
        this.gallery,
        this.needs,
        this.fulfillment,
        this.hashTags,
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
    String ownerUser;
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
    int total;
    List<GallerySearchPost> gallery;
    List<dynamic> needs;
    List<dynamic> fulfillment;
    List<dynamic> hashTags;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
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
        ownerUser: json["ownerUser"],
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
        total: json["total"],
        gallery: List<GallerySearchPost>.from(json["gallery"].map((x) => GallerySearchPost.fromJson(x))),
        needs: List<dynamic>.from(json["needs"].map((x) => x)),
        fulfillment: List<dynamic>.from(json["fulfillment"].map((x) => x)),
        hashTags: List<dynamic>.from(json["hashTags"].map((x) => x)),
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
        "ownerUser": ownerUser,
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
        "total": total,
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "needs": List<dynamic>.from(needs.map((x) => x)),
        "fulfillment": List<dynamic>.from(fulfillment.map((x) => x)),
        "hashTags": List<dynamic>.from(hashTags.map((x) => x)),
    };
}

class GallerySearchPost {
    GallerySearchPost({
        this.id,
        this.post,
        this.fileId,
        this.imageUrl,
        this.ordering,
        this.signUrl,

    });

    String id;
    String post;
    String fileId;
    String imageUrl;
    int ordering;
    String signUrl;

    factory GallerySearchPost.fromJson(Map<String, dynamic> json) => GallerySearchPost(
        id: json["_id"],
        post: json["post"],
        fileId: json["fileId"],
        imageUrl: json["imageURL"],
        ordering: json["ordering"],
                signUrl: json["signURL"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "fileId": fileId,
        "imageURL": imageUrl,
        "ordering": ordering,
    };
}



class Style {
    Style({
        this.textalign,
        this.fontsize,
    });

    String textalign;
    String fontsize;

    factory Style.fromJson(Map<String, dynamic> json) => Style(
        textalign: json["textalign"],
        fontsize: json["fontsize"],
    );

    Map<String, dynamic> toJson() => {
        "textalign": textalign,
        "fontsize": fontsize,
    };
}

class User {
    User({
        this.displayName,
        this.imageUrl,
        this.email,
        this.isAdmin,
        this.uniqueId,
    });

    String displayName;
    String imageUrl;
    String email;
    bool isAdmin;
    String uniqueId;

    factory User.fromJson(Map<String, dynamic> json) => User(
        displayName: json["displayName"],
        imageUrl: json["imageURL"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        uniqueId: json["uniqueId"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "imageURL": imageUrl,
        "email": email,
        "isAdmin": isAdmin,
        "uniqueId": uniqueId,
    };
}
