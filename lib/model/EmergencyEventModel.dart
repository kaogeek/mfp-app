// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';



EmergencyEventModel welcomeFromJson(String str) => EmergencyEventModel.fromJson(json.decode(str));

String welcomeToJson(EmergencyEventModel data) => json.encode(data.toJson());

class EmergencyEventModel {
    EmergencyEventModel({
        this.emergencyEvent,
        this.followedUser,
        this.followedCount,
        this.fulfillmentCount,
        this.fulfillmentUser,
        this.fulfillmentUserCount,
        this.isFollow,
        this.relatedHashTags,
        this.needItems,
        this.timelines,
    });

    EmergencyEvent emergencyEvent;
    List<FollowedUser> followedUser;
    int followedCount;
    int fulfillmentCount;
    List<User> fulfillmentUser;
    int fulfillmentUserCount;
    bool isFollow;
    List<RelatedHashTag> relatedHashTags;
    List<NeedItem> needItems;
    List<Timeline> timelines;

    factory EmergencyEventModel.fromJson(Map<String, dynamic> json) => EmergencyEventModel(
        emergencyEvent: EmergencyEvent.fromJson(json["emergencyEvent"]),
        followedUser: List<FollowedUser>.from(json["followedUser"].map((x) => FollowedUser.fromJson(x))),
        followedCount: json["followedCount"],
        fulfillmentCount: json["fulfillmentCount"],
        fulfillmentUser: List<User>.from(json["fulfillmentUser"].map((x) => User.fromJson(x))),
        fulfillmentUserCount: json["fulfillmentUserCount"],
        isFollow: json["isFollow"],
        relatedHashTags: List<RelatedHashTag>.from(json["relatedHashTags"].map((x) => RelatedHashTag.fromJson(x))),
        needItems: List<NeedItem>.from(json["needItems"].map((x) => NeedItem.fromJson(x))),
        timelines: List<Timeline>.from(json["timelines"].map((x) => Timeline.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "emergencyEvent": emergencyEvent.toJson(),
        "followedUser": List<dynamic>.from(followedUser.map((x) => x.toJson())),
        "followedCount": followedCount,
        "fulfillmentCount": fulfillmentCount,
        "fulfillmentUser": List<dynamic>.from(fulfillmentUser.map((x) => x.toJson())),
        "fulfillmentUserCount": fulfillmentUserCount,
        "isFollow": isFollow,
        "relatedHashTags": List<dynamic>.from(relatedHashTags.map((x) => x.toJson())),
        "needItems": List<dynamic>.from(needItems.map((x) => x.toJson())),
        "timelines": List<dynamic>.from(timelines.map((x) => x.toJson())),
    };
}

class EmergencyEvent {
    EmergencyEvent({
        this.id,
        this.createdDate,
        this.title,
        this.detail,
        this.coverPageUrl,
        this.hashTag,
        this.isClose,
        this.isPin,
        this.s3CoverPageUrl,
        this.hashTagName,
    });

    Id id;
    DateTime createdDate;
    String title;
    String detail;
    String coverPageUrl;
    String hashTag;
    bool isClose;
    bool isPin;
    String s3CoverPageUrl;
    String hashTagName;

    factory EmergencyEvent.fromJson(Map<String, dynamic> json) => EmergencyEvent(
        id: idValues.map[json["id"]],
        title: json["title"],
        detail: json["detail"],
        coverPageUrl: json["coverPageURL"],
        hashTag: json["hashTag"],
        isClose: json["isClose"],
        isPin: json["isPin"],
        s3CoverPageUrl: json["s3CoverPageURL"],
        hashTagName: json["hashTagName"],
    );

    Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "title": title,
        "detail": detail,
        "coverPageURL": coverPageUrl,
        "hashTag": hashTag,
        "isClose": isClose,
        "isPin": isPin,
        "s3CoverPageURL": s3CoverPageUrl,
        "hashTagName":hashTagName,
    };
}



enum Id { THE_615411616_B0_A7_F20497_B62_E8 }

final idValues = EnumValues({
    "615411616b0a7f20497b62e8": Id.THE_615411616_B0_A7_F20497_B62_E8
});

class FollowedUser {
    FollowedUser({
        this.id,
        this.displayName,
        this.imageUrl,
        this.email,
        this.isAdmin,
        this.uniqueId,
        this.type,
    });

    String id;
    String displayName;
    String imageUrl;
    String email;
    bool isAdmin;
    String uniqueId;
    String type;

    factory FollowedUser.fromJson(Map<String, dynamic> json) => FollowedUser(
        id: json["id"],
        displayName: json["displayName"],
        imageUrl: json["imageURL"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        uniqueId: json["uniqueId"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "imageURL": imageUrl,
        "email": email,
        "isAdmin": isAdmin,
        "uniqueId": uniqueId,
        "type": type,
    };
}

class User {
    User({
        this.id,
        this.username,
        this.email,
        this.uniqueId,
        this.imageUrl,
        this.coverUrl,
        this.firstName,
        this.lastName,
        this.displayName,
        this.isAdmin,
        this.isSubAdmin,
        this.banned,
        this.createdDate,
        this.customGender,
        this.gender,
        this.s3CoverUrl,
    });

    String id;
    String username;
    String email;
    String uniqueId;
    String imageUrl;
    String coverUrl;
    String firstName;
    String lastName;
    String displayName;
    bool isAdmin;
    bool isSubAdmin;
    bool banned;
    DateTime createdDate;
    dynamic customGender;
    int gender;
    String s3CoverUrl;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        uniqueId: json["uniqueId"],
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"] == null ? null : json["coverURL"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        displayName: json["displayName"],
        isAdmin: json["isAdmin"],
        isSubAdmin: json["isSubAdmin"],
        banned: json["banned"],
        createdDate: DateTime.parse(json["createdDate"]),
        customGender: json["customGender"],
        gender: json["gender"] == null ? null : json["gender"],
        s3CoverUrl: json["s3CoverURL"] == null ? null : json["s3CoverURL"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "uniqueId": uniqueId,
        "imageURL": imageUrl,
        "coverURL": coverUrl == null ? null : coverUrl,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": displayName,
        "isAdmin": isAdmin,
        "isSubAdmin": isSubAdmin,
        "banned": banned,
        "createdDate": createdDate.toIso8601String(),
        "customGender": customGender,
        "gender": gender == null ? null : gender,
        "s3CoverURL": s3CoverUrl == null ? null : s3CoverUrl,
    };
}

class NeedItem {
    NeedItem({
        this.id,
        this.standardItemId,
        this.customItemId,
        this.pageId,
        this.name,
        this.active,
        this.fullfilled,
        this.quantity,
        this.unit,
        this.post,
        this.description,
        this.fulfillQuantity,
        this.pendingQuantity,
        this.createdDate,
        this.standardItem,
        this.customItem,
    });

    String id;
    String standardItemId;
    String customItemId;
    String pageId;
    String name;
    bool active;
    bool fullfilled;
    int quantity;
    String unit;
    String post;
    dynamic description;
    int fulfillQuantity;
    int pendingQuantity;
    DateTime createdDate;
    StandardItem standardItem;
    CustomItem customItem;

    factory NeedItem.fromJson(Map<String, dynamic> json) => NeedItem(
        id: json["_id"],
        standardItemId: json["standardItemId"] == null ? null : json["standardItemId"],
        customItemId: json["customItemId"] == null ? null : json["customItemId"],
        pageId: json["pageId"],
        name: json["name"],
        active: json["active"],
        fullfilled: json["fullfilled"],
        quantity: json["quantity"],
        unit: json["unit"],
        post: json["post"],
        description: json["description"],
        fulfillQuantity: json["fulfillQuantity"],
        pendingQuantity: json["pendingQuantity"],
        createdDate: DateTime.parse(json["createdDate"]),
        standardItem: json["standardItem"] == null ? null : StandardItem.fromJson(json["standardItem"]),
        customItem: json["customItem"] == null ? null : CustomItem.fromJson(json["customItem"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "standardItemId": standardItemId == null ? null : standardItemId,
        "customItemId": customItemId == null ? null : customItemId,
        "pageId": pageId,
        "name": name,
        "active": active,
        "fullfilled": fullfilled,
        "quantity": quantity,
        "unit": unit,
        "post": post,
        "description": description,
        "fulfillQuantity": fulfillQuantity,
        "pendingQuantity": pendingQuantity,
        "createdDate": createdDate.toIso8601String(),
        "standardItem": standardItem == null ? null : standardItem.toJson(),
        "customItem": customItem == null ? null : customItem.toJson(),
    };
}

class CustomItem {
    CustomItem({
        this.id,
        this.name,
        this.unit,
        this.userId,
        this.standardItemId,
        this.createdDate,
    });

    String id;
    String name;
    String unit;
    String userId;
    dynamic standardItemId;
    DateTime createdDate;

    factory CustomItem.fromJson(Map<String, dynamic> json) => CustomItem(
        id: json["_id"],
        name: json["name"],
        unit: json["unit"],
        userId: json["userId"],
        standardItemId: json["standardItemId"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "unit": unit,
        "userId": userId,
        "standardItemId": standardItemId,
        "createdDate": createdDate.toIso8601String(),
    };
}

class StandardItem {
    StandardItem({
        this.id,
        this.name,
        this.unit,
        this.imageUrl,
        this.category,
        this.createdDate,
    });

    String id;
    String name;
    String unit;
    String imageUrl;
    String category;
    DateTime createdDate;

    factory StandardItem.fromJson(Map<String, dynamic> json) => StandardItem(
        id: json["_id"],
        name: json["name"],
        unit: json["unit"],
        imageUrl: json["imageURL"]??"",
        category: json["category"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "unit": unit,
        "imageURL": imageUrl,
        "category": category,
        "createdDate": createdDate.toIso8601String(),
    };
}

class RelatedHashTag {
    RelatedHashTag({
        this.id,
        this.createdDate,
        this.name,
        this.iconUrl,
        this.count,
        this.lastActiveDate,
    });

    String id;
    DateTime createdDate;
    String name;
    String iconUrl;
    int count;
    DateTime lastActiveDate;

    factory RelatedHashTag.fromJson(Map<String, dynamic> json) => RelatedHashTag(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        name: json["name"],
        iconUrl: json["iconURL"],
        count: json["count"],
        lastActiveDate: DateTime.parse(json["lastActiveDate"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "name": name,
        "iconURL": iconUrl,
        "count": count,
        "lastActiveDate": lastActiveDate.toIso8601String(),
    };
}

class Timeline {
    Timeline({
        this.title,
        this.subTitle,
        this.detail,
        this.post,
        this.type,
        this.isLike,
        this.isRepost,
        this.isComment,
        this.isShare,
        this.users,
        this.galleries,
        this.posts,
    });

    String title;
    String subTitle;
    String detail;
    Post post;
    String type;
    bool isLike;
    bool isRepost;
    bool isComment;
    bool isShare;
    List<User> users;
    List<dynamic> galleries;
    List<Post> posts;

    factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
        title: json["title"],
        subTitle: json["subTitle"],
        detail: json["detail"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
        type: json["type"],
        isLike: json["isLike"] == null ? null : json["isLike"],
        isRepost: json["isRepost"] == null ? null : json["isRepost"],
        isComment: json["isComment"] == null ? null : json["isComment"],
        isShare: json["isShare"] == null ? null : json["isShare"],
        users: json["users"] == null ? null : List<User>.from(json["users"].map((x) => User.fromJson(x))),
        galleries: json["galleries"] == null ? null : List<dynamic>.from(json["galleries"].map((x) => x)),
        posts: json["posts"] == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "subTitle": subTitle,
        "detail": detail,
        "post": post == null ? null : post.toJson(),
        "type": type,
        "isLike": isLike == null ? null : isLike,
        "isRepost": isRepost == null ? null : isRepost,
        "isComment": isComment == null ? null : isComment,
        "isShare": isShare == null ? null : isShare,
        "users": users == null ? null : List<dynamic>.from(users.map((x) => x.toJson())),
        "galleries": galleries == null ? null : List<dynamic>.from(galleries.map((x) => x)),
        "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
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
        this.story,
        this.postsHashTags,
        this.objective,
        // this.objectiveTag,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.emergencyEvent,
        // this.emergencyEventTag,
        this.postHashTag,
        this.s3CoverImage,
        this.postGallery,
    });

    String id;
    String title;
    String detail;
    bool isDraft;
    bool hidden;
    Type type;
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
    List<String> postsHashTags;
    Objective objective;
    // HashTagName objectiveTag;
    PageId pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    Id emergencyEvent;
    // HashTagName emergencyEventTag;
    List<String> postHashTag;
    String s3CoverImage;
    List<PostGallery> postGallery;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        detail: json["detail"],
        isDraft: json["isDraft"],
        hidden: json["hidden"],
        type: typeValues.map[json["type"]],
        userTags: List<dynamic>.from(json["userTags"].map((x) => x)),
        coverImage: json["coverImage"],
        pinned: json["pinned"],
        deleted: json["deleted"],
        ownerUser: ownerUserValues.map[json["ownerUser"]],
        commentCount: json["commentCount"],
        repostCount: json["repostCount"],
        shareCount: json["shareCount"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        createdDate: DateTime.parse(json["createdDate"]),
        startDateTime: DateTime.parse(json["startDateTime"]),
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
        postsHashTags: List<String>.from(json["postsHashTags"].map((x) => x)),
        objective: objectiveValues.map[json["objective"]],
        // objectiveTag: hashTagNameValues.map[json["objectiveTag"]],
        pageId: pageIdValues.map[json["pageId"]],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        emergencyEvent: idValues.map[json["emergencyEvent"]],
        // emergencyEventTag: hashTagNameValues.map[json["emergencyEventTag"]],
        postHashTag: json["postHashTag"] == null ? null : List<String>.from(json["postHashTag"].map((x) => x)),
        s3CoverImage: json["s3CoverImage"] == null ? null : json["s3CoverImage"],
        postGallery: List<PostGallery>.from(json["postGallery"].map((x) => PostGallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "detail": detail,
        "isDraft": isDraft,
        "hidden": hidden,
        "type": typeValues.reverse[type],
        "userTags": List<dynamic>.from(userTags.map((x) => x)),
        "coverImage": coverImage,
        "pinned": pinned,
        "deleted": deleted,
        "ownerUser": ownerUserValues.reverse[ownerUser],
        "commentCount": commentCount,
        "repostCount": repostCount,
        "shareCount": shareCount,
        "likeCount": likeCount,
        "viewCount": viewCount,
        "createdDate": createdDate.toIso8601String(),
        "startDateTime": startDateTime.toIso8601String(),
        "story": story == null ? null : story.toJson(),
        "postsHashTags": List<dynamic>.from(postsHashTags.map((x) => x)),
        "objective": objectiveValues.reverse[objective],
        // "objectiveTag": hashTagNameValues.reverse[objectiveTag],
        "pageId": pageIdValues.reverse[pageId],
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
        "emergencyEvent": idValues.reverse[emergencyEvent],
        // "emergencyEventTag": hashTagNameValues.reverse[emergencyEventTag],
        "postHashTag": postHashTag == null ? null : List<dynamic>.from(postHashTag.map((x) => x)),
        "s3CoverImage": s3CoverImage == null ? null : s3CoverImage,
        "postGallery": List<dynamic>.from(postGallery.map((x) => x.toJson())),
    };
}

enum Objective { THE_61540_C7620695_E0_D97_ED14_E0 }

final objectiveValues = EnumValues({
    "61540c7620695e0d97ed14e0": Objective.THE_61540_C7620695_E0_D97_ED14_E0
});

enum OwnerUser { THE_604_B35_CB78_D6_C04_E3_DACB86_C }

final ownerUserValues = EnumValues({
    "604b35cb78d6c04e3dacb86c": OwnerUser.THE_604_B35_CB78_D6_C04_E3_DACB86_C
});

enum PageId { THE_605_AB592_DD77_B8368_D17_ED9_A }

final pageIdValues = EnumValues({
    "605ab592dd77b8368d17ed9a": PageId.THE_605_AB592_DD77_B8368_D17_ED9_A
});

class PostGallery {
    PostGallery({
        this.id,
        this.post,
        this.fileId,
        this.imageUrl,
        this.s3ImageUrl,
        this.ordering,
    });

    String id;
    String post;
    String fileId;
    String imageUrl;
    String s3ImageUrl;
    int ordering;

    factory PostGallery.fromJson(Map<String, dynamic> json) => PostGallery(
        id: json["_id"],
        post: json["post"],
        fileId: json["fileId"],
        imageUrl: json["imageURL"],
        s3ImageUrl: json["s3ImageURL"],
        ordering: json["ordering"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "fileId": fileId,
        "imageURL": imageUrl,
        "s3ImageURL": s3ImageUrl,
        "ordering": ordering,
    };
}

class Story {
    Story({
        this.story,
        this.storyAry,
    });

    String story;
    List<StoryAry> storyAry;

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        story: json["story"],
        storyAry: List<StoryAry>.from(json["storyAry"].map((x) => StoryAry.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "story": story,
        "storyAry": List<dynamic>.from(storyAry.map((x) => x.toJson())),
    };
}

class StoryAry {
    StoryAry({
        this.htmlType,
        this.text,
        this.style,
        this.value,
        this.image64,
    });

    HtmlType htmlType;
    String text;
    Style style;
    String value;
    String image64;

    factory StoryAry.fromJson(Map<String, dynamic> json) => StoryAry(
        htmlType: htmlTypeValues.map[json["htmlType"]],
        text: json["text"],
        style: Style.fromJson(json["style"]),
        value: json["value"],
        image64: json["image64"],
    );

    Map<String, dynamic> toJson() => {
        "htmlType": htmlTypeValues.reverse[htmlType],
        "text": text,
        "style": style.toJson(),
        "value": value,
        "image64": image64,
    };
}

enum HtmlType { TEXT }

final htmlTypeValues = EnumValues({
    "TEXT": HtmlType.TEXT
});

class Style {
    Style({
        this.textalign,
        this.fontsize,
    });

    Textalign textalign;
    Fontsize fontsize;

    factory Style.fromJson(Map<String, dynamic> json) => Style(
        textalign: textalignValues.map[json["textalign"]],
        fontsize: fontsizeValues.map[json["fontsize"]],
    );

    Map<String, dynamic> toJson() => {
        "textalign": textalignValues.reverse[textalign],
        "fontsize": fontsizeValues.reverse[fontsize],
    };
}

enum Fontsize { THE_16_PX }

final fontsizeValues = EnumValues({
    "16px": Fontsize.THE_16_PX
});

enum Textalign { LEFT }

final textalignValues = EnumValues({
    "left": Textalign.LEFT
});

enum Type { GENERAL }

final typeValues = EnumValues({
    "GENERAL": Type.GENERAL
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
