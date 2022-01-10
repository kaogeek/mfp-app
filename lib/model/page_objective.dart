class PageObjectiveModel {
  PageObjectiveModel({
    this.id,
    this.createdDate,
    this.pageId,
    this.title,
    this.iconUrl,
    this.hashTag,
    this.s3IconUrl,
    this.iconSignUrl,
  });

  String id;
  DateTime createdDate;
  String pageId;
  String title;
  String iconUrl;
  String hashTag;
  String s3IconUrl;
  String iconSignUrl;

  factory PageObjectiveModel.fromJson(Map<String, dynamic> json) => PageObjectiveModel(
        id: json["id"],
        createdDate: DateTime.parse(json["createdDate"]),
        pageId: json["pageId"],
        title: json["title"],
        iconUrl: json["iconURL"],
        hashTag: json["hashTag"],
        s3IconUrl: json["s3IconURL"] == null ? null : json["s3IconURL"],
        iconSignUrl: json["iconSignURL"] == null ? null : json["iconSignURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdDate": createdDate.toIso8601String(),
        "pageId": pageId,
        "title": title,
        "iconURL": iconUrl,
        "hashTag": hashTag,
        "s3IconURL": s3IconUrl == null ? null : s3IconUrl,
        "iconSignURL": iconSignUrl == null ? null : iconSignUrl,
      };
}
