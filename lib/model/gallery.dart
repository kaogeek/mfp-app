class Gallery {
    Gallery({
        this.id,
        this.post,
        this.fileId,
        this.imageUrl,
        this.s3ImageUrl,
        this.ordering,
                this.signUrl,

    });

    String id;
    String post;
    String fileId;
    String imageUrl;
    String s3ImageUrl;
    int ordering;
    String signUrl;

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["_id"],
        post: json["post"],
        fileId: json["fileId"],
        imageUrl: json["imageURL"],
        s3ImageUrl: json["s3ImageURL"],
        ordering: json["ordering"],
                signUrl: json["signURL"],

    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "fileId": fileId,
        "imageURL": imageUrl,
        "s3ImageURL": s3ImageUrl,
        "ordering": ordering,
                "signURL": signUrl,

    };
}
