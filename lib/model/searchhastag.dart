class SearchHastag {
  SearchHastag({this.value, this.label, this.type, this.count, this.historyId});

  String value;
  String historyId;
  String label;
  String type;
  int count;

  factory SearchHastag.fromJson(Map<String, dynamic> json) => SearchHastag(
        value: json["value"] ,
        historyId: json["historyId"],
        label: json["label"] ,
        type: json["type"],
        count: json["count"] ,
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "historyId": historyId,
        "label": label,
        "type": type,
        "count": count,
      };
}

