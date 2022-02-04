// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserPageModel welcomeFromJson(String str) => UserPageModel.fromJson(json.decode(str));

String welcomeToJson(UserPageModel data) => json.encode(data.toJson());



class UserPageModel {
    UserPageModel({
        this.page,
        this.user,
        this.level,
    });

    Page page;
    User user;
    String level;

    factory UserPageModel.fromJson(Map<String, dynamic> json) => UserPageModel(
        page: Page.fromJson(json["page"]),
        user: User.fromJson(json["user"]),
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "page": page.toJson(),
        "user": user.toJson(),
        "level": level,
    };
}

class Page {
    Page({
        this.id,
        this.name,
        this.pageUsername,
        this.imageUrl,
        this.signUrl,
        this.isOfficial,
    });

    String id;
    String name;
    String pageUsername;
    String imageUrl;
    String signUrl;
    bool isOfficial;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        name: json["name"],
        pageUsername: json["pageUsername"],
        imageUrl: json["imageURL"],
        signUrl: json["signURL"] == null ? null : json["signURL"],
        isOfficial: json["isOfficial"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pageUsername": pageUsername,
        "imageURL": imageUrl,
        "signURL": signUrl == null ? null : signUrl,
        "isOfficial": isOfficial,
    };
}

class User {
    User({
        this.id,
        this.displayName,
        this.imageUrl,
    });

    String id;
    String displayName;
    String imageUrl;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        displayName: json["displayName"],
        imageUrl: json["imageURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "imageURL": imageUrl,
    };
}
