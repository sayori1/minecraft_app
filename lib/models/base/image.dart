class Image {
  String full;
  String thumb;

  Image({required this.full, required this.thumb});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      full: json['full'],
      thumb: json['thumb'],
    );
  }

  Map<String, dynamic> toJson() => {
        'full': full,
        'thumb': thumb,
      };
}
