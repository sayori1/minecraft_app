class Link {
  String name;
  String href;

  Link({required this.name, required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      name: json['name'],
      href: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['href'] = href;
    return data;
  }
}
