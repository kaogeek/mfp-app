// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RecomUserPageModel welcomeFromJson(String str) => RecomUserPageModel.fromJson(json.decode(str));

String welcomeToJson(RecomUserPageModel data) => json.encode(data.toJson());


class RecomUserPageModel {
    RecomUserPageModel({
        this.id,
        this.username,
        this.email,
        this.uniqueId,
        this.imageUrl,
        this.displayName,
        this.signUrl,
        this.type,
        this.name,
        this.pageUsername,
        this.isOfficial,
         this.isFollow,
    });

    String id;
    String username;
    String email;
    String uniqueId;
    String imageUrl;
    String displayName;
    String signUrl;
    String type;
    String name;
    String pageUsername;
    bool isOfficial;
    bool isFollow;

    factory RecomUserPageModel.fromJson(Map<String, dynamic> json) => RecomUserPageModel(
        id: json["_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"],
        uniqueId: json["uniqueId"] == null ? null : json["uniqueId"],
        imageUrl: json["imageURL"],
        displayName: json["displayName"] == null ? null : json["displayName"],
        signUrl: json["signURL"],
        type: json["type"],
        name: json["name"] == null ? null : json["name"],
        pageUsername: json["pageUsername"] == null ? null : json["pageUsername"],
        isOfficial: json["isOfficial"] == null ? null : json["isOfficial"],
                isFollow: json["isFollow"] == null ? null : json["isFollow"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username == null ? null : username,
        "email": email,
        "uniqueId": uniqueId == null ? null : uniqueId,
        "imageURL": imageUrl,
        "displayName": displayName == null ? null : displayName,
        "signURL": signUrl,
        "type": type,
        "name": name == null ? null : name,
        "pageUsername": pageUsername == null ? null : pageUsername,
        "isOfficial": isOfficial == null ? null : isOfficial,
                "isFollow": isFollow == null ? null : isFollow,

    };
}
