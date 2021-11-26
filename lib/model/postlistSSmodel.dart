class PostListSS {
    PostListSS({
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
        this.pageId,
        this.referencePost,
        this.rootReferencePost,
        this.visibility,
        this.ranges,
        this.updateDate,
        this.gallery,
        this.needs,
        this.comment,
        this.socialPosts,
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
    List<String> postsHashTags;
    PageId pageId;
    dynamic referencePost;
    dynamic rootReferencePost;
    dynamic visibility;
    dynamic ranges;
    DateTime updateDate;
    List<Gallery> gallery;
    List<Need> needs;
    List<dynamic> comment;
    List<dynamic> socialPosts;

    factory PostListSS.fromJson(Map<String, dynamic> json) => PostListSS(
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
        postsHashTags: List<String>.from(json["postsHashTags"].map((x) => x)),
        pageId: pageIdValues.map[json["pageId"]],
        referencePost: json["referencePost"],
        rootReferencePost: json["rootReferencePost"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        updateDate: DateTime.parse(json["updateDate"]),
        gallery: List<Gallery>.from(json["gallery"].map((x) => Gallery.fromJson(x))),
        needs: List<Need>.from(json["needs"].map((x) => Need.fromJson(x))),
        comment: List<dynamic>.from(json["comment"].map((x) => x)),
        socialPosts: List<dynamic>.from(json["socialPosts"].map((x) => x)),
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
        "postsHashTags": List<dynamic>.from(postsHashTags.map((x) => x)),
        "pageId": pageIdValues.reverse[pageId],
        "referencePost": referencePost,
        "rootReferencePost": rootReferencePost,
        "visibility": visibility,
        "ranges": ranges,
        "updateDate": updateDate.toIso8601String(),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "needs": List<dynamic>.from(needs.map((x) => x.toJson())),
        "comment": List<dynamic>.from(comment.map((x) => x)),
        "socialPosts": List<dynamic>.from(socialPosts.map((x) => x)),
    };
}

class Gallery {
    Gallery({
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

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
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
                "signURL": signUrl,

    };
}

class Need {
    Need({
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
    });

    Id id;
    StandardItemId standardItemId;
    CustomItemId customItemId;
    PageId pageId;
    Name name;
    bool active;
    bool fullfilled;
    int quantity;
    Unit unit;
    Post post;
    dynamic description;
    int fulfillQuantity;
    int pendingQuantity;
    DateTime createdDate;

    factory Need.fromJson(Map<String, dynamic> json) => Need(
        id: idValues.map[json["_id"]],
        standardItemId: standardItemIdValues.map[json["standardItemId"]],
        customItemId: customItemIdValues.map[json["customItemId"]],
        pageId: pageIdValues.map[json["pageId"]],
        name: nameValues.map[json["name"]],
        active: json["active"],
        fullfilled: json["fullfilled"],
        quantity: json["quantity"],
        unit: unitValues.map[json["unit"]],
        post: postValues.map[json["post"]],
        description: json["description"],
        fulfillQuantity: json["fulfillQuantity"],
        pendingQuantity: json["pendingQuantity"],
        createdDate: DateTime.parse(json["createdDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "standardItemId": standardItemIdValues.reverse[standardItemId],
        "customItemId": customItemIdValues.reverse[customItemId],
        "pageId": pageIdValues.reverse[pageId],
        "name": nameValues.reverse[name],
        "active": active,
        "fullfilled": fullfilled,
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
        "post": postValues.reverse[post],
        "description": description,
        "fulfillQuantity": fulfillQuantity,
        "pendingQuantity": pendingQuantity,
        "createdDate": createdDate.toIso8601String(),
    };
}

enum CustomItemId { THE_605_AD8_E1_E672034779_D0_A4_C8, THE_605_AED3_EE672034779_D0_A535 }

final customItemIdValues = EnumValues({
    "605ad8e1e672034779d0a4c8": CustomItemId.THE_605_AD8_E1_E672034779_D0_A4_C8,
    "605aed3ee672034779d0a535": CustomItemId.THE_605_AED3_EE672034779_D0_A535
});

enum Id { THE_605_AD8_E1_E672034779_D0_A4_C9, THE_605_AED3_EE672034779_D0_A536 }

final idValues = EnumValues({
    "605ad8e1e672034779d0a4c9": Id.THE_605_AD8_E1_E672034779_D0_A4_C9,
    "605aed3ee672034779d0a536": Id.THE_605_AED3_EE672034779_D0_A536
});

enum Name { EMPTY, NAME }

final nameValues = EnumValues({
    "ว่าที่ผู้แทนราษฎรในนามพรรคก้าวไกล": Name.EMPTY,
    "สมาชิกพรรคก้าวไกล": Name.NAME
});

enum PageId { THE_605_AB592_DD77_B8368_D17_ED9_A }

final pageIdValues = EnumValues({
    "605ab592dd77b8368d17ed9a": PageId.THE_605_AB592_DD77_B8368_D17_ED9_A
});

enum Post { THE_605_AD8_E1_E672034779_D0_A4_C6, THE_605_AED3_EE672034779_D0_A533 }

final postValues = EnumValues({
    "605ad8e1e672034779d0a4c6": Post.THE_605_AD8_E1_E672034779_D0_A4_C6,
    "605aed3ee672034779d0a533": Post.THE_605_AED3_EE672034779_D0_A533
});

enum StandardItemId { THE_6061_B71215_A868141_FF6_BE08, THE_6061_B48_E15_A868141_FF6_BCC0 }

final standardItemIdValues = EnumValues({
    "6061b48e15a868141ff6bcc0": StandardItemId.THE_6061_B48_E15_A868141_FF6_BCC0,
    "6061b71215a868141ff6be08": StandardItemId.THE_6061_B71215_A868141_FF6_BE08
});

enum Unit { EMPTY }

final unitValues = EnumValues({
    "คน": Unit.EMPTY
});

class OwnerUser {
    OwnerUser({
        this.uniqueId,
        this.imageUrl,
        this.displayName,
    });

    String uniqueId;
    String imageUrl;
    String displayName;

    factory OwnerUser.fromJson(Map<String, dynamic> json) => OwnerUser(
        uniqueId: json["uniqueId"],
        imageUrl: json["imageURL"],
        displayName: json["displayName"],
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "imageURL": imageUrl,
        "displayName": displayName,
    };
}

class Story {
    Story({
        this.story,
        this.storyAry,
        this.coverImage,
    });

    String story;
    List<StoryAry> storyAry;
    String coverImage;

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        story: json["story"],
        storyAry: List<StoryAry>.from(json["storyAry"].map((x) => StoryAry.fromJson(x))),
        coverImage: json["coverImage"],
    );

    Map<String, dynamic> toJson() => {
        "story": story,
        "storyAry": List<dynamic>.from(storyAry.map((x) => x.toJson())),
        "coverImage": coverImage,
    };
}

class StoryAry {
    StoryAry({
        this.htmlType,
        this.text,
        this.style,
        this.value,
    });

    String htmlType;
    String text;
    Style style;
    String value;

    factory StoryAry.fromJson(Map<String, dynamic> json) => StoryAry(
        htmlType: json["htmlType"],
        text: json["text"],
        style: Style.fromJson(json["style"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "htmlType": htmlType,
        "text": text,
        "style": style.toJson(),
        "value": value,
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
