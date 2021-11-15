import 'dart:convert';


// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


ProfileSS welcomeFromJson(String str) => ProfileSS.fromJson(json.decode(str));

String welcomeToJson(ProfileSS data) => json.encode(data.toJson());


class ProfileSS {
    ProfileSS({
        this.id,
        // this.createdDate,
        // this.updateDate,
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
        this.categoryName,
        this.followers,
        this.isFollow,
        // this.pageObjectives,
        // this.needs,
    });

    String id;
    // DateTime createdDate;
    // DateTime updateDate;
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
    String categoryName;
    int followers;
    bool isFollow;
    // List<PageObjective> pageObjectives;
    // List<Need> needs;

    factory ProfileSS.fromJson(Map<String, dynamic> json) => ProfileSS(
        id: json["id"],
        // createdDate: DateTime.parse(json["createdDate"]),
        // updateDate: DateTime.parse(json["updateDate"]),
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
        categoryName: json["categoryName"],
        followers: json["followers"],
        isFollow: json["isFollow"],
        // pageObjectives: List<PageObjective>.from(json["pageObjectives"].map((x) => PageObjective.fromJson(x))),
        // needs: List<Need>.from(json["needs"].map((x) => Need.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        // "createdDate": createdDate.toIso8601String(),
        // "updateDate": updateDate.toIso8601String(),
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
        "categoryName": categoryName,
        "followers": followers,
        "isFollow": isFollow,
        // "pageObjectives": List<dynamic>.from(pageObjectives.map((x) => x.toJson())),
        // "needs": List<dynamic>.from(needs.map((x) => x.toJson())),
    };
}

class Need {
    Need({
        this.id,
        this.standardItemId,
        this.customItemId,
        this.name,
        this.quantity,
        this.unit,
        this.createdDate,
        this.pageId,
        this.post,
        this.active,
        this.fullfilled,
        this.fulfillQuantity,
        this.pendingQuantity,
    });

    String id;
    String standardItemId;
    String customItemId;
    String name;
    int quantity;
    String unit;
    DateTime createdDate;
    String pageId;
    String post;
    bool active;
    bool fullfilled;
    int fulfillQuantity;
    int pendingQuantity;

    factory Need.fromJson(Map<String, dynamic> json) => Need(
        id: json["id"],
        standardItemId: json["standardItemId"] == null ? null : json["standardItemId"],
        customItemId: json["customItemId"] == null ? null : json["customItemId"],
        name: json["name"],
        quantity: json["quantity"],
        unit: json["unit"],
        createdDate: DateTime.parse(json["createdDate"]),
        pageId: json["pageId"],
        post: json["post"],
        active: json["active"],
        fullfilled: json["fullfilled"],
        fulfillQuantity: json["fulfillQuantity"],
        pendingQuantity: json["pendingQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "standardItemId": standardItemId == null ? null : standardItemId,
        "customItemId": customItemId == null ? null : customItemId,
        "name": name,
        "quantity": quantity,
        "unit": unit,
        "createdDate": createdDate.toIso8601String(),
        "pageId": pageId,
        "post": post,
        "active": active,
        "fullfilled": fullfilled,
        "fulfillQuantity": fulfillQuantity,
        "pendingQuantity": pendingQuantity,
    };
}

class PageObjective {
    PageObjective({
        this.id,
        this.createdDate,
        this.pageId,
        this.title,
        this.iconUrl,
        this.hashTag,
    });

    String id;
    DateTime createdDate;
    String pageId;
    String title;
    String iconUrl;
    String hashTag;

    factory PageObjective.fromJson(Map<String, dynamic> json) => PageObjective(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        pageId: json["pageId"],
        title: json["title"],
        iconUrl: json["iconURL"],
        hashTag: json["hashTag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "pageId": pageId,
        "title": title,
        "iconURL": iconUrl,
        "hashTag": hashTag,
    };
}
