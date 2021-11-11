class UserProfileModel {
    UserProfileModel({
        this.user,
        this.token,
    });

    User user;
    String token;

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        user: User.fromJson(json["user"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
    };
}

class User {
    User({
        this.id,
        this.createdDate,
        this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.displayName,
        this.uniqueId,
        this.gender,
        this.isAdmin,
        this.isSubAdmin,
        this.birthdate,
        this.imageUrl,
        this.coverUrl,
        this.coverPosition,
        this.banned,
        this.followings,
        this.followers,
    });

    String id;
    DateTime createdDate;
    String username;
    String email;
    String firstName;
    String lastName;
    String displayName;
    String uniqueId;
    int gender;
    bool isAdmin;
    bool isSubAdmin;
    DateTime birthdate;
    String imageUrl;
    String coverUrl;
    int coverPosition;
    bool banned;
    int followings;
    int followers;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        displayName: json["displayName"],
        uniqueId: json["uniqueId"],
        gender: json["gender"],
        isAdmin: json["isAdmin"],
        isSubAdmin: json["isSubAdmin"],
        birthdate: DateTime.parse(json["birthdate"]),
        imageUrl: json["imageURL"],
        coverUrl: json["coverURL"],
        coverPosition: json["coverPosition"],
        banned: json["banned"],
        followings: json["followings"],
        followers: json["followers"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "displayName": displayName,
        "uniqueId": uniqueId,
        "gender": gender,
        "isAdmin": isAdmin,
        "isSubAdmin": isSubAdmin,
        "birthdate": "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "imageURL": imageUrl,
        "coverURL": coverUrl,
        "coverPosition": coverPosition,
        "banned": banned,
        "followings": followings,
        "followers": followers,
    };
}
