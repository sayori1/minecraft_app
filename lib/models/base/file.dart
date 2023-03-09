class File {
  final String url;
  final int size;

  File({required this.url, required this.size});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(url: json['url'], size: json['size']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'size': size};
  }
}
