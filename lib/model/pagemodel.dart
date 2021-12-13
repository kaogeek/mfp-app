



class PageModel {
  PageModel({
    this.id,
    this.createdDate,
    this.updateDate,
    this.updateByUsername,
    this.name,
    this.pageUsername,
    this.backgroundStory,
    this.imageUrl,
    this.coverUrl,
    this.coverPosition,
    this.ownerUser,
    this.isOfficial,
    this.category,
    this.banned,
    this.facebookUrl,
    this.email,
    this.categoryName,
    this.followers,
    this.isFollow,

  });

  String id;
  DateTime createdDate;
  DateTime updateDate;
  String updateByUsername;
  String name;
  String pageUsername;
  String backgroundStory;
  String imageUrl;
  String coverUrl;
  int coverPosition;
  String ownerUser;
  bool isOfficial;
  String category;
  bool banned;
  String facebookUrl;
  String email;
  String categoryName;
  int followers;
  bool isFollow;


  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
    id: json["id"],
    createdDate: DateTime.parse(json["createdDate"]),
    updateDate: DateTime.parse(json["updateDate"]),
    updateByUsername: json["updateByUsername"],
    name: json["name"],
    pageUsername: json["pageUsername"],
    backgroundStory: json["backgroundStory"],
    imageUrl: json["imageURL"],
    coverUrl: json["coverURL"],
    coverPosition: json["coverPosition"],
    ownerUser: json["ownerUser"],
    isOfficial: json["isOfficial"],
    category: json["category"],
    banned: json["banned"],
    facebookUrl: json["facebookURL"],
    email: json["email"],
    categoryName: json["categoryName"],
    followers: json["followers"],
    isFollow: json["isFollow"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdDate": createdDate.toIso8601String(),
    "updateDate": updateDate.toIso8601String(),
    "updateByUsername": updateByUsername,
    "name": name,
    "pageUsername": pageUsername,
    "backgroundStory": backgroundStory,
    "imageURL": imageUrl,
    "coverURL": coverUrl,
    "coverPosition": coverPosition,
    "ownerUser": ownerUser,
    "isOfficial": isOfficial,
    "category": category,
    "banned": banned,
    "facebookURL": facebookUrl,
    "email": email,
    "categoryName": categoryName,
    "followers": followers,
    "isFollow": isFollow,

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
