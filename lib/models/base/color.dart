class Color {
  String name;
  String color;

  Color({required this.name, required this.color});

  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      name: json['name'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
