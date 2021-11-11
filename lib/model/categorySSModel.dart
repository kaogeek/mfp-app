class CategorySS {
    CategorySS({
        this.id,
        this.name,
        this.iconUrl,
    });

    String id;
    String name;
    String iconUrl;

    factory CategorySS.fromJson(Map<String, dynamic> json) => CategorySS(
        id: json["id"],
        name: json["name"],
        iconUrl: json["iconURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iconURL": iconUrl,
    };
}
