
import 'dart:convert';

List<Test> testFromJson(String str) =>
    List<Test>.from(json.decode(str).map((x) => Test.fromJson(x)));
String testToJson(List<Test> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Test {
  Test({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  Data data;

  factory Test.fromJson(Map<String, dynamic> json) => Test(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
    Data({
        this.emergencyEvents,
        this.emergencyPin,
        this.postSectionModel,
        this.objectiveEvents,
        this.sectionModels,
    });

    Emergency emergencyEvents;
    Emergency emergencyPin;
    PostSectionModel postSectionModel;
    ObjectiveEvents objectiveEvents;
    List<SectionModel> sectionModels;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        emergencyEvents: Emergency.fromJson(json["emergencyEvents"]),
        emergencyPin: Emergency.fromJson(json["emergencyPin"]),
        postSectionModel: PostSectionModel.fromJson(json["postSectionModel"]),
        objectiveEvents: ObjectiveEvents.fromJson(json["objectiveEvents"]),
        sectionModels: List<SectionModel>.from(json["sectionModels"].map((x) => SectionModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "emergencyEvents": emergencyEvents.toJson(),
        "emergencyPin": emergencyPin.toJson(),
        "postSectionModel": postSectionModel.toJson(),
        "objectiveEvents": objectiveEvents.toJson(),
        "sectionModels": List<dynamic>.from(sectionModels.map((x) => x.toJson())),
    };
}

class Emergency {
    Emergency({
        this.isList,
        this.isHighlight,
        this.title,
        this.subtitle,
        this.description,
        this.type,
        this.iconUrl,
        this.contents,
        this.contentCount,
        this.dateTime,
    });

    bool isList;
    bool isHighlight;
    String title;
    String subtitle;
    String description;
    String type;
    String iconUrl;
    List<EmergencyEventsContent> contents;
    int contentCount;
    DateTime dateTime;

    factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
        isList: json["isList"],
        isHighlight: json["isHighlight"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        type: json["type"] == null ? null : json["type"],
        iconUrl: json["iconUrl"],
        contents: List<EmergencyEventsContent>.from(json["contents"].map((x) => EmergencyEventsContent.fromJson(x))),
        contentCount: json["contentCount"] == null ? null : json["contentCount"],
        dateTime: DateTime.parse(json["dateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "isList": isList,
        "isHighlight": isHighlight,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "type": type == null ? null : type,
        "iconUrl": iconUrl,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "contentCount": contentCount == null ? null : contentCount,
        "dateTime": dateTime.toIso8601String(),
    };
}

class EmergencyEventsContent {
    EmergencyEventsContent({
        this.coverPageUrl,
        this.coverPageSignUrl,
        this.title,
        this.description,
        this.postCount,
        this.commentCount,
        this.repostCount,
        this.shareCount,
        this.likeCount,
        this.viewCount,
        this.dateTime,
                this.data,

    });

    String coverPageUrl;
    String coverPageSignUrl;
    String title;
    String description;
    int postCount;
    int commentCount;
    int repostCount;
    int shareCount;
    int likeCount;
    int viewCount;
    DateTime dateTime;
    PurpleData data;

    factory EmergencyEventsContent.fromJson(Map<String, dynamic> json) => EmergencyEventsContent(
        coverPageUrl: json["coverPageUrl"],
        coverPageSignUrl: json["coverPageSignUrl"],
        title: json["title"],
        description: json["description"],
        postCount: json["postCount"],
        commentCount: json["commentCount"],
        repostCount: json["repostCount"],
        shareCount: json["shareCount"],
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        dateTime: DateTime.parse(json["dateTime"]),
                data: PurpleData.fromJson(json["data"]),

    );

    Map<String, dynamic> toJson() => {
        "coverPageUrl": coverPageUrl,
                "coverPageSignUrl": coverPageSignUrl,

        "title": title,
        "description": description,
        "postCount": postCount,
        "commentCount": commentCount,
        "repostCount": repostCount,
        "shareCount": shareCount,
        "likeCount": likeCount,
        "viewCount": viewCount,
        "dateTime": dateTime.toIso8601String(),
                "data": data.toJson(),

    };
}
class PurpleData {
    PurpleData({
        this.emergencyEventId,
    });

    String emergencyEventId;

    factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
        emergencyEventId: json["emergencyEventId"],
    );

    Map<String, dynamic> toJson() => {
        "emergencyEventId": emergencyEventId,
    };
}

class ObjectiveEvents {
    ObjectiveEvents({
        this.isList,
        this.isHighlight,
        this.title,
        this.subtitle,
        this.type,
        this.description,
        this.iconUrl,
        this.contents,
        this.dateTime,
    });

    bool isList;
    bool isHighlight;
    String title;
    String subtitle;
    String type;
    String description;
    String iconUrl;
    List<ObjectiveEventsContent> contents;
    DateTime dateTime;

    factory ObjectiveEvents.fromJson(Map<String, dynamic> json) => ObjectiveEvents(
        isList: json["isList"],
        isHighlight: json["isHighlight"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        description: json["description"],
        iconUrl: json["iconUrl"],
        contents: List<ObjectiveEventsContent>.from(json["contents"].map((x) => ObjectiveEventsContent.fromJson(x))),
        dateTime: DateTime.parse(json["dateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "isList": isList,
        "isHighlight": isHighlight,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "description": description,
        "iconUrl": iconUrl,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "dateTime": dateTime.toIso8601String(),
    };
}

class ObjectiveEventsContent {
    ObjectiveEventsContent({
        this.title,
        this.iconUrl,
        this.owner,
        this.post,
    });

    String title;
    String iconUrl;
    PurpleOwner owner;
    List<dynamic> post;

    factory ObjectiveEventsContent.fromJson(Map<String, dynamic> json) => ObjectiveEventsContent(
        title: json["title"],
        iconUrl: json["iconUrl"],
        owner: PurpleOwner.fromJson(json["owner"]),
        post: List<dynamic>.from(json["post"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "iconUrl": iconUrl,
        "owner": owner.toJson(),
        "post": List<dynamic>.from(post.map((x) => x)),
    };
}

class PurpleOwner {
    PurpleOwner({
        this.id,
        this.name,
        this.imageUrl,
        this.isOfficial,
        this.uniqueId,
        this.type,
    });

    String id;
    String name;
    String imageUrl;
    bool isOfficial;
    String uniqueId;
    OwnerType type;

    factory PurpleOwner.fromJson(Map<String, dynamic> json) => PurpleOwner(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageURL"],
        isOfficial: json["isOfficial"],
        uniqueId: json["uniqueId"],
        type: ownerTypeValues.map[json["type"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageURL": imageUrl,
        "isOfficial": isOfficial,
        "uniqueId": uniqueId,
        "type": ownerTypeValues.reverse[type],
    };
}

enum OwnerType { USER, PAGE }

final ownerTypeValues = EnumValues({
    "PAGE": OwnerType.PAGE,
    "USER": OwnerType.USER
});

class PostSectionModel {
    PostSectionModel({
        this.isList,
        this.isHighlight,
        this.title,
        this.subtitle,
        this.description,
        this.iconUrl,
        this.contents,
        this.dateTime,
    });

    bool isList;
    bool isHighlight;
    String title;
    String subtitle;
    String description;
    String iconUrl;
    List<PostSectionModelContent> contents;
    dynamic dateTime;

    factory PostSectionModel.fromJson(Map<String, dynamic> json) => PostSectionModel(
        isList: json["isList"],
        isHighlight: json["isHighlight"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        iconUrl: json["iconUrl"],
        contents: List<PostSectionModelContent>.from(json["contents"].map((x) => PostSectionModelContent.fromJson(x))),
        dateTime: json["dateTime"],
    );

    Map<String, dynamic> toJson() => {
        "isList": isList,
        "isHighlight": isHighlight,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "iconUrl": iconUrl,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "dateTime": dateTime,
    };
}

class PostSectionModelContent {
    PostSectionModelContent({
        this.coverPageUrl,
        this.owner,
        this.post,
    });

    String coverPageUrl;
    FluffyOwner owner;
    PurplePost post;

    factory PostSectionModelContent.fromJson(Map<String, dynamic> json) => PostSectionModelContent(
        coverPageUrl: json["coverPageUrl"] == null ? null : json["coverPageUrl"],
        owner: FluffyOwner.fromJson(json["owner"]),
        post: PurplePost.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "coverPageUrl": coverPageUrl == null ? null : coverPageUrl,
        "owner": owner.toJson(),
        "post": post.toJson(),
    };
}

class FluffyOwner {
    FluffyOwner({
        this.id,
        this.displayName,
        this.imageUrl,
        this.email,
        this.isAdmin,
        this.uniqueId,
        this.type,
        this.name,
        this.isOfficial,
    });

    String id;
    DisplayName displayName;
    String imageUrl;
    Email email;
    bool isAdmin;
    String uniqueId;
    OwnerType type;
    String name;
    bool isOfficial;

    factory FluffyOwner.fromJson(Map<String, dynamic> json) => FluffyOwner(
        id: json["id"],
        displayName: json["displayName"] == null ? null : displayNameValues.map[json["displayName"]],
        imageUrl: json["imageURL"],
        email: json["email"] == null ? null : emailValues.map[json["email"]],
        isAdmin: json["isAdmin"] == null ? null : json["isAdmin"],
        uniqueId: json["uniqueId"],
        type: ownerTypeValues.map[json["type"]],
        name: json["name"] == null ? null : json["name"],
        isOfficial: json["isOfficial"] == null ? null : json["isOfficial"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName == null ? null : displayNameValues.reverse[displayName],
        "imageURL": imageUrl,
        "email": email == null ? null : emailValues.reverse[email],
        "isAdmin": isAdmin == null ? null : isAdmin,
        "uniqueId": uniqueId,
        "type": ownerTypeValues.reverse[type],
        "name": name == null ? null : name,
        "isOfficial": isOfficial == null ? null : isOfficial,
    };
}

enum DisplayName { MAC, ARITATT, TRAVEL }

final displayNameValues = EnumValues({
    "Aritatt": DisplayName.ARITATT,
    "MAC": DisplayName.MAC,
    "Travel": DisplayName.TRAVEL
});

enum Email { TEETHADH_GMAIL_COM, THE_60104110034_RPU_AC_TH, TRAVEL_GMAIL_COM }

final emailValues = EnumValues({
    "teethadh@gmail.com": Email.TEETHADH_GMAIL_COM,
    "60104110034@rpu.ac.th": Email.THE_60104110034_RPU_AC_TH,
    "travel@gmail.com": Email.TRAVEL_GMAIL_COM
});

class PurplePost {
    PurplePost({
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
        this.postsHashTags,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.page,
        this.postAsPage,
    });

    String id;
    String title;
    String detail;
    bool isDraft;
    bool hidden;
    PostType type;
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
    List<String> postsHashTags;
    String pageId;
    String referencePost;
    String rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    Page page;
    dynamic postAsPage;

    factory PurplePost.fromJson(Map<String, dynamic> json) => PurplePost(
        id: json["_id"],
        title: json["title"],
        detail: json["detail"],
        isDraft: json["isDraft"],
        hidden: json["hidden"],
        type: postTypeValues.map[json["type"]],
        userTags: json["userTags"] == null ? null : List<dynamic>.from(json["userTags"].map((x) => x)),
        coverImage: json["coverImage"] == null ? null : json["coverImage"],
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
        postsHashTags: List<String>.from(json["postsHashTags"].map((x) => x)),
        pageId: json["pageId"] == null ? null : json["pageId"],
        referencePost: json["referencePost"] == null ? null : json["referencePost"],
        rootReferencePost: json["rootReferencePost"] == null ? null : json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]),
        postAsPage: json["postAsPage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "detail": detail,
        "isDraft": isDraft,
        "hidden": hidden,
        "type": postTypeValues.reverse[type],
        "userTags": userTags == null ? null : List<dynamic>.from(userTags.map((x) => x)),
        "coverImage": coverImage == null ? null : coverImage,
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
        "postsHashTags": List<dynamic>.from(postsHashTags.map((x) => x)),
        "pageId": pageId == null ? null : pageId,
        "referencePost": referencePost == null ? null : referencePost,
        "rootReferencePost": rootReferencePost == null ? null : rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
        "page": page == null ? null : page.toJson(),
        "postAsPage": postAsPage,
    };
}



enum OwnerUser { THE_604_B35_CB78_D6_C04_E3_DACB86_C, THE_60_C8_AD7_E6923656607919_E14, THE_6049_E497_B8_A2_D345758_FFC87 }

final ownerUserValues = EnumValues({
    "6049e497b8a2d345758ffc87": OwnerUser.THE_6049_E497_B8_A2_D345758_FFC87,
    "604b35cb78d6c04e3dacb86c": OwnerUser.THE_604_B35_CB78_D6_C04_E3_DACB86_C,
    "60c8ad7e6923656607919e14": OwnerUser.THE_60_C8_AD7_E6923656607919_E14
});

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
        this.updateDate,
        this.address,
        this.facebookUrl,
        this.instagramUrl,
        this.lineId,
        this.mobileNo,
        this.twitterUrl,
        this.websiteUrl,
        this.email,
        this.updateByUsername,
    });

    String id;
    String name;
    String pageUsername;
    dynamic subTitle;
    String backgroundStory;
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
    DateTime updateDate;
    String address;
    String facebookUrl;
    dynamic instagramUrl;
    String lineId;
    String mobileNo;
    String twitterUrl;
    String websiteUrl;
    String email;
    UpdateByUsername updateByUsername;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["_id"],
        name: json["name"],
        pageUsername: json["pageUsername"],
        subTitle: json["subTitle"],
        backgroundStory: json["backgroundStory"] == null ? null : json["backgroundStory"],
        detail: json["detail"],
        ownerUser: json["ownerUser"],
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"],
        coverPosition: json["coverPosition"] == null ? null : json["coverPosition"],
        color: json["color"],
        category: json["category"],
        isOfficial: json["isOfficial"],
        banned: json["banned"],
        createdDate: DateTime.parse(json["createdDate"]),
        updateDate: json["updateDate"] == null ? null : DateTime.parse(json["updateDate"]),
        address: json["address"] == null ? null : json["address"],
        facebookUrl: json["facebookURL"] == null ? null : json["facebookURL"],
        instagramUrl: json["instagramURL"],
        lineId: json["lineId"] == null ? null : json["lineId"],
        mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
        twitterUrl: json["twitterURL"] == null ? null : json["twitterURL"],
        websiteUrl: json["websiteURL"] == null ? null : json["websiteURL"],
        email: json["email"] == null ? null : json["email"],
        updateByUsername: json["updateByUsername"] == null ? null : updateByUsernameValues.map[json["updateByUsername"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "pageUsername": pageUsername,
        "subTitle": subTitle,
        "backgroundStory": backgroundStory == null ? null : backgroundStory,
        "detail": detail,
        "ownerUser": ownerUser,
        "imageURL": imageUrl,
        "coverURL": coverUrl,
        "coverPosition": coverPosition == null ? null : coverPosition,
        "color": color,
        "category": category,
        "isOfficial": isOfficial,
        "banned": banned,
        "createdDate": createdDate.toIso8601String(),
        "updateDate": updateDate == null ? null : updateDate.toIso8601String(),
        "address": address == null ? null : address,
        "facebookURL": facebookUrl == null ? null : facebookUrl,
        "instagramURL": instagramUrl,
        "lineId": lineId == null ? null : lineId,
        "mobileNo": mobileNo == null ? null : mobileNo,
        "twitterURL": twitterUrl == null ? null : twitterUrl,
        "websiteURL": websiteUrl == null ? null : websiteUrl,
        "email": email == null ? null : email,
        "updateByUsername": updateByUsername == null ? null : updateByUsernameValues.reverse[updateByUsername],
    };
}

enum UpdateByUsername { ADMIN_MOVEFORWARDPARTY_ORG }

final updateByUsernameValues = EnumValues({
    "admin@moveforwardparty.org": UpdateByUsername.ADMIN_MOVEFORWARDPARTY_ORG
});

enum PostType { GENERAL }

final postTypeValues = EnumValues({
    "GENERAL": PostType.GENERAL
});

class SectionModel {
    SectionModel({
        this.isList,
        this.isHighlight,
        this.title,
        this.iconUrl,
        this.subtitle,
        this.description,
        this.contents,
        this.dateTime,
        this.type,
    });

    bool isList;
    bool isHighlight;
    String title;
    String iconUrl;
    String subtitle;
    String description;
    List<SectionModelContent> contents;
    DateTime dateTime;
    String type;

    factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
        isList: json["isList"],
        isHighlight: json["isHighlight"],
        title: json["title"],
        iconUrl: json["iconUrl"],
        subtitle: json["subtitle"],
        description: json["description"],
        contents: List<SectionModelContent>.from(json["contents"].map((x) => SectionModelContent.fromJson(x))),
        dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "isList": isList,
        "isHighlight": isHighlight,
        "title": title,
        "iconUrl": iconUrl,
        "subtitle": subtitle,
        "description": description,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "dateTime": dateTime == null ? null : dateTime.toIso8601String(),
        "type": type == null ? null : type,
    };
}

class SectionModelContent {
    SectionModelContent({
        this.isFollow,
        this.commentCount,
        this.repostCount,
        this.shareCount,
        this.likeCount,
        this.viewCount,
        this.post,
        this.dateTime,
        this.followUserCount,
        this.followUsers,
        this.coverPageUrl,
        this.isLike,
        this.isRepost,
        this.isComment,
        this.isShare,
        this.owner,
        this.title,
        this.iconUrl,
        this.subtitle,
        this.data,
    });

    bool isFollow;
    int commentCount;
    int repostCount;
    int shareCount;
    int likeCount;
    int viewCount;
    FluffyPost post;
    DateTime dateTime;
    int followUserCount;
    List<dynamic> followUsers;
    String coverPageUrl;
    bool isLike;
    bool isRepost;
    bool isComment;
    bool isShare;
    FluffyOwner owner;
    String title;
    String iconUrl;
    String subtitle;
    Page data;

    factory SectionModelContent.fromJson(Map<String, dynamic> json) => SectionModelContent(
        isFollow: json["isFollow"] == null ? null : json["isFollow"],
        commentCount: json["commentCount"] == null ? null : json["commentCount"],
        repostCount: json["repostCount"] == null ? null : json["repostCount"],
        shareCount: json["shareCount"] == null ? null : json["shareCount"],
        likeCount: json["likeCount"] == null ? null : json["likeCount"],
        viewCount: json["viewCount"] == null ? null : json["viewCount"],
        post: json["post"] == null ? null : FluffyPost.fromJson(json["post"]),
        dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        followUserCount: json["followUserCount"] == null ? null : json["followUserCount"],
        followUsers: json["followUsers"] == null ? null : List<dynamic>.from(json["followUsers"].map((x) => x)),
        coverPageUrl: json["coverPageUrl"] == null ? null : json["coverPageUrl"],
        isLike: json["isLike"] == null ? null : json["isLike"],
        isRepost: json["isRepost"] == null ? null : json["isRepost"],
        isComment: json["isComment"] == null ? null : json["isComment"],
        isShare: json["isShare"] == null ? null : json["isShare"],
        owner: json["owner"] == null ? null : FluffyOwner.fromJson(json["owner"]),
        title: json["title"] == null ? null : json["title"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        data: json["data"] == null ? null : Page.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "isFollow": isFollow == null ? null : isFollow,
        "commentCount": commentCount == null ? null : commentCount,
        "repostCount": repostCount == null ? null : repostCount,
        "shareCount": shareCount == null ? null : shareCount,
        "likeCount": likeCount == null ? null : likeCount,
        "viewCount": viewCount == null ? null : viewCount,
        "post": post == null ? null : post.toJson(),
        "dateTime": dateTime == null ? null : dateTime.toIso8601String(),
        "followUserCount": followUserCount == null ? null : followUserCount,
        "followUsers": followUsers == null ? null : List<dynamic>.from(followUsers.map((x) => x)),
        "coverPageUrl": coverPageUrl == null ? null : coverPageUrl,
        "isLike": isLike == null ? null : isLike,
        "isRepost": isRepost == null ? null : isRepost,
        "isComment": isComment == null ? null : isComment,
        "isShare": isShare == null ? null : isShare,
        "owner": owner == null ? null : owner.toJson(),
        "title": title == null ? null : title,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "subtitle": subtitle == null ? null : subtitle,
        "data": data == null ? null : data.toJson(),
    };
}

class FluffyPost {
    FluffyPost({
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
        this.postsHashTags,
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.page,
        this.user,
    });

    String id;
    String title;
    String detail;
    bool isDraft;
    bool hidden;
    PostType type;
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
    List<String> postsHashTags;
    String pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    Page page;
    User user;

    factory FluffyPost.fromJson(Map<String, dynamic> json) => FluffyPost(
        id: json["_id"],
        title: json["title"],
        detail: json["detail"],
        isDraft: json["isDraft"],
        hidden: json["hidden"],
        type: postTypeValues.map[json["type"]],
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
        postsHashTags: List<String>.from(json["postsHashTags"].map((x) => x)),
        pageId: json["pageId"],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "detail": detail,
        "isDraft": isDraft,
        "hidden": hidden,
        "type": postTypeValues.reverse[type],
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
        "postsHashTags": List<dynamic>.from(postsHashTags.map((x) => x)),
        "pageId": pageId,
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
        "page": page == null ? null : page.toJson(),
        "user": user == null ? null : user.toJson(),
    };
}

class User {
    User({
        this.id,
        this.email,
        this.uniqueId,
        this.imageUrl,
        this.firstName,
        this.lastName,
        this.displayName,
        this.isAdmin,
        this.isSubAdmin,
        this.banned,
        this.customGender,
        this.gender,
        this.createdDate,
    });

    OwnerUser id;
    Email email;
    String uniqueId;
    String imageUrl;
    String firstName;
    String lastName;
    DisplayName displayName;
    bool isAdmin;
    bool isSubAdmin;
    bool banned;
    dynamic customGender;
    int gender;
    DateTime createdDate;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: ownerUserValues.map[json["_id"]],
        email: emailValues.map[json["email"]],
        uniqueId: json["uniqueId"],
        imageUrl: json["imageURL"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        displayName: displayNameValues.map[json["displayName"]],
        isAdmin: json["isAdmin"],
        isSubAdmin: json["isSubAdmin"],
        banned: json["banned"],
        customGender: json["customGender"],
        gender: json["gender"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": ownerUserValues.reverse[id],
        "email": emailValues.reverse[email],
        "uniqueId": uniqueId,
        "imageURL": imageUrl,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": displayNameValues.reverse[displayName],
        "isAdmin": isAdmin,
        "isSubAdmin": isSubAdmin,
        "banned": banned,
        "customGender": customGender,
        "gender": gender,
        "createdDate": createdDate.toIso8601String(),
    };
}

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