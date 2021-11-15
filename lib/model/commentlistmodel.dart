class CommentlistModel {
    CommentlistModel({
        this.comment,
        this.mediaUrl,
        this.post,
        this.user,
        this.likeCount,
        this.commentAsPage,
        this.createdDate,
        this.id,
        this.isLike,
        this.likeAsPage,
    });

    String comment;
    String mediaUrl;
    String post;
    User user;
    int likeCount;
    String commentAsPage;
    DateTime createdDate;
    String id;
    bool isLike;
    bool likeAsPage;

    factory CommentlistModel.fromJson(Map<String, dynamic> json) => CommentlistModel(
        comment: json["comment"],
        mediaUrl: json["mediaURL"],
        post: json["post"],
        user: User.fromJson(json["user"]),
        likeCount: json["likeCount"],
        commentAsPage: json["commentAsPage"],
        createdDate: DateTime.parse(json["createdDate"]),
        id: json["id"],
        isLike: json["isLike"],
        likeAsPage: json["likeAsPage"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment,
        "mediaURL": mediaUrl,
        "post": post,
        "user": user.toJson(),
        "likeCount": likeCount,
        "commentAsPage": commentAsPage,
        "createdDate": createdDate.toIso8601String(),
        "id": id,
        "isLike": isLike,
        "likeAsPage": likeAsPage,
    };
}

class User {
    User({
        this.imageUrl,
        this.displayName,
        this.id,
    });

    String imageUrl;
    String displayName;
    String id;

    factory User.fromJson(Map<String, dynamic> json) => User(
        imageUrl: json["imageURL"],
        displayName: json["displayName"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "imageURL": imageUrl,
        "displayName": displayName,
        "id": id,
    };
}
