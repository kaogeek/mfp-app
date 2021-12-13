// class PostDetailSSModel {
//     PostDetailSSModel({
//         this.id,
//         this.story,
//         this.comment,
//     });

//     String id;

//     Story story;

//     List<dynamic> comment;

//     factory PostDetailSSModel.fromJson(Map<String, dynamic> json) => PostDetailSSModel(
       
//         story: Story.fromJson(json["story"]),
       
//         comment: List<dynamic>.from(json["comment"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
       
//         "story": story.toJson(),
        
//         "comment": List<dynamic>.from(comment.map((x) => x)),
//     };
// }

// class Gallery {
//     Gallery({
//         this.id,
//         this.post,
//         this.fileId,
//         this.imageUrl,
//         this.ordering,
//     });

//     String id;
//     String post;
//     String fileId;
//     String imageUrl;
//     int ordering;

//     factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
//         id: json["_id"],
//         post: json["post"],
//         fileId: json["fileId"],
//         imageUrl: json["imageURL"],
//         ordering: json["ordering"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "post": post,
//         "fileId": fileId,
//         "imageURL": imageUrl,
//         "ordering": ordering,
//     };
// }

// class Need {
//     Need({
//         this.id,
//         this.standardItemId,
//         this.customItemId,
//         this.pageId,
//         this.name,
//         this.active,
//         this.fullfilled,
//         this.quantity,
//         this.unit,
//         this.post,
//         this.description,
//         this.fulfillQuantity,
//         this.pendingQuantity,
//         this.createdDate,
//     });

//     String id;
//     String standardItemId;
//     String customItemId;
//     String pageId;
//     String name;
//     bool active;
//     bool fullfilled;
//     int quantity;
//     String unit;
//     String post;
//     dynamic description;
//     int fulfillQuantity;
//     int pendingQuantity;
//     DateTime createdDate;

//     factory Need.fromJson(Map<String, dynamic> json) => Need(
//         id: json["_id"],
//         standardItemId: json["standardItemId"] == null ? null : json["standardItemId"],
//         customItemId: json["customItemId"] == null ? null : json["customItemId"],
//         pageId: json["pageId"],
//         name: json["name"],
//         active: json["active"],
//         fullfilled: json["fullfilled"],
//         quantity: json["quantity"],
//         unit: json["unit"],
//         post: json["post"],
//         description: json["description"],
//         fulfillQuantity: json["fulfillQuantity"],
//         pendingQuantity: json["pendingQuantity"],
//         createdDate: DateTime.parse(json["createdDate"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "standardItemId": standardItemId == null ? null : standardItemId,
//         "customItemId": customItemId == null ? null : customItemId,
//         "pageId": pageId,
//         "name": name,
//         "active": active,
//         "fullfilled": fullfilled,
//         "quantity": quantity,
//         "unit": unit,
//         "post": post,
//         "description": description,
//         "fulfillQuantity": fulfillQuantity,
//         "pendingQuantity": pendingQuantity,
//         "createdDate": createdDate.toIso8601String(),
//     };
// }

// class OwnerUser {
//     OwnerUser({
//         this.uniqueId,
//         this.imageUrl,
//         this.displayName,
//     });

//     String uniqueId;
//     String imageUrl;
//     String displayName;

//     factory OwnerUser.fromJson(Map<String, dynamic> json) => OwnerUser(
//         uniqueId: json["uniqueId"],
//         imageUrl: json["imageURL"],
//         displayName: json["displayName"],
//     );

//     Map<String, dynamic> toJson() => {
//         "uniqueId": uniqueId,
//         "imageURL": imageUrl,
//         "displayName": displayName,
//     };
// }

// class SocialPost {
//     SocialPost({
//         this.socialId,
//         this.socialType,
//         this.createdDate,
//     });

//     String socialId;
//     String socialType;
//     DateTime createdDate;

//     factory SocialPost.fromJson(Map<String, dynamic> json) => SocialPost(
//         socialId: json["socialId"],
//         socialType: json["socialType"],
//         createdDate: DateTime.parse(json["createdDate"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "socialId": socialId,
//         "socialType": socialType,
//         "createdDate": createdDate.toIso8601String(),
//     };
// }

// class Story {
//     Story({
//         this.story,
//         this.storyAry,
//         this.coverImage,
//     });

//     String story;
//     List<StoryAry> storyAry;
//     String coverImage;

//     factory Story.fromJson(Map<String, dynamic> json) => Story(
//         story: json["story"],
//         storyAry: List<StoryAry>.from(json["storyAry"].map((x) => StoryAry.fromJson(x))),
//         coverImage: json["coverImage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "story": story,
//         "storyAry": List<dynamic>.from(storyAry.map((x) => x.toJson())),
//         "coverImage": coverImage,
//     };
// }

// class StoryAry {
//     StoryAry({
//         this.htmlType,
//         this.text,
//         this.style,
//         this.value,
//     });

//     String htmlType;
//     String text;
//     Style style;
//     String value;

//     factory StoryAry.fromJson(Map<String, dynamic> json) => StoryAry(
//         htmlType: json["htmlType"],
//         text: json["text"],
//         style: Style.fromJson(json["style"]),
//         value: json["value"],
//     );

//     Map<String, dynamic> toJson() => {
//         "htmlType": htmlType,
//         "text": text,
//         "style": style.toJson(),
//         "value": value,
//     };
// }

// class Style {
//     Style({
//         this.textalign,
//         this.fontsize,
//     });

//     String textalign;
//     String fontsize;

//     factory Style.fromJson(Map<String, dynamic> json) => Style(
//         textalign: json["textalign"],
//         fontsize: json["fontsize"],
//     );

//     Map<String, dynamic> toJson() => {
//         "textalign": textalign,
//         "fontsize": fontsize,
//     };
// }
