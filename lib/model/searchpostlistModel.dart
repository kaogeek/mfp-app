// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:mfp_app/model/gallery.dart';

Postslist welcomeFromJson(String str) => Postslist.fromJson(json.decode(str));

String welcomeToJson(Postslist data) => json.encode(data.toJson());

class Postslist {
  Postslist({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<PostSearchModel> data;

  factory Postslist.fromJson(Map<String, dynamic> json) => Postslist(
        status: json["status"],
        message: json["message"],
        data: List<PostSearchModel>.from(
            json["data"].map((x) => PostSearchModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PostSearchModel {
  PostSearchModel({
    this.post,
    this.user,
    this.page,
  });

  Post post;
  User user;
  Page page;

  factory PostSearchModel.fromJson(Map<String, dynamic> json) =>
      PostSearchModel(
        post: Post.fromJson(json["post"]),
        user: User.fromJson(json["user"]),
        page: json["page"] == null ? null : Page.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "post": post.toJson(),
        "user": user.toJson(),
        "page": page == null ? null : page.toJson(),
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
        lineId: json["lineId"] == null ? null : json["lineId"],
        facebookUrl: json["facebookURL"] == null ? null : json["facebookURL"],
        twitterUrl: json["twitterURL"] == null ? null : json["twitterURL"],
        websiteUrl: json["websiteURL"] == null ? null : json["websiteURL"],
        mobileNo: json["mobileNo"] == null ? null : json["mobileNo"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
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
        "lineId": lineId == null ? null : lineId,
        "facebookURL": facebookUrl == null ? null : facebookUrl,
        "twitterURL": twitterUrl == null ? null : twitterUrl,
        "websiteURL": websiteUrl == null ? null : websiteUrl,
        "mobileNo": mobileNo == null ? null : mobileNo,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
      };
}

class Post {
  Post(
      {this.id,
      this.title,
      this.type,
      this.pageId,
      this.detail,
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
      this.needs,
      this.fulfillment,
      this.hashTags,
      this.coverImageSignUrl,
      this.userTags,
      this.story,
      this.islike});

  String id;
  String title;
  String type;
  String pageId;
  String detail;
  String coverImage;
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
  List<Gallery> gallery;
  List<dynamic> needs;
  List<dynamic> fulfillment;
  List<HashTag> hashTags;
  String coverImageSignUrl;
  List<dynamic> userTags;
  Story story;
  bool islike = false;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        pageId: json["pageId"] == null ? null : json["pageId"],
        detail: json["detail"],
        coverImage: json["coverImage"] == null ? null : json["coverImage"],
        deleted: json["deleted"],
        hidden: json["hidden"],
        isDraft: json["isDraft"],
        pinned: json["pinned"],
        ownerUser: json["ownerUser"],
        createdDate: DateTime.parse(json["createdDate"]),
        startDateTime: DateTime.parse(json["startDateTime"]),
        likeCount: json["likeCount"],
        viewCount: json["viewCount"],
        commentCount: json["commentCount"],
        repostCount: json["repostCount"],
        shareCount: json["shareCount"],
        visibility: json["visibility"],
        ranges: json["ranges"],
        postAsPage: json["postAsPage"],
        referencePost:
            json["referencePost"] == null ? null : json["referencePost"],
        rootReferencePost: json["rootReferencePost"] == null
            ? null
            : json["rootReferencePost"],
        updateDate: DateTime.parse(json["updateDate"]),
        gallery: List<Gallery>.from(
            json["gallery"].map((x) => Gallery.fromJson(x))),
        needs: List<dynamic>.from(json["needs"].map((x) => x)),
        fulfillment: List<dynamic>.from(json["fulfillment"].map((x) => x)),
        hashTags: List<HashTag>.from(
            json["hashTags"].map((x) => HashTag.fromJson(x))),
        coverImageSignUrl: json["coverImageSignURL"],
        userTags: json["userTags"] == null
            ? null
            : List<dynamic>.from(json["userTags"].map((x) => x)),
        story: json["story"] == null ? null : Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "pageId": pageId == null ? null : pageId,
        "detail": detail,
        "coverImage": coverImage == null ? null : coverImage,
        "deleted": deleted,
        "hidden": hidden,
        "isDraft": isDraft,
        "pinned": pinned,
        "ownerUser": ownerUser,
        "createdDate": createdDate.toIso8601String(),
        "startDateTime": startDateTime.toIso8601String(),
        "likeCount": likeCount,
        "viewCount": viewCount,
        "commentCount": commentCount,
        "repostCount": repostCount,
        "shareCount": shareCount,
        "visibility": visibility,
        "ranges": ranges,
        "postAsPage": postAsPage,
        "referencePost": referencePost == null ? null : referencePost,
        "rootReferencePost":
            rootReferencePost == null ? null : rootReferencePost,
        "updateDate": updateDate.toIso8601String(),
        "gallery": List<dynamic>.from(gallery.map((x) => x.toJson())),
        "needs": List<dynamic>.from(needs.map((x) => x)),
        "fulfillment": List<dynamic>.from(fulfillment.map((x) => x)),
        "hashTags": List<dynamic>.from(hashTags.map((x) => x.toJson())),
        "coverImageSignURL": coverImageSignUrl,
        "userTags": userTags == null
            ? null
            : List<dynamic>.from(userTags.map((x) => x)),
        "story": story == null ? null : story.toJson(),
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

class Story {
  Story();

  factory Story.fromJson(Map<String, dynamic> json) => Story();

  Map<String, dynamic> toJson() => {};
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
