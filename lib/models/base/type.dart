class Type {
  String name;
  int value;

  Type({
    required this.name,
    required this.value,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}

class Meta {
  String title;
  String shortDescription;
  String description;

  Meta({
    required this.title,
    required this.shortDescription,
    required this.description,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      title: json['title'],
      shortDescription: json['short_description'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'short_description': shortDescription,
        'description': description,
      };
}
