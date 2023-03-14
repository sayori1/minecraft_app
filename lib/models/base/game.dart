import 'color.dart';
import 'file.dart';
import 'link.dart';
import 'type.dart';

class Game {
  int id;
  String title;
  int priority;
  int gold;
  int likeAmount;
  int installAmount;
  bool active;
  int rating;
  String type;
  String logo;
  String? description;
  List<Color> colors;
  File file;
  Type fillLike;
  List<Game> similars;
  List<Link> links;

  Game({
    required this.id,
    required this.title,
    required this.priority,
    required this.gold,
    required this.likeAmount,
    required this.installAmount,
    required this.active,
    required this.rating,
    required this.type,
    required this.logo,
    this.description,
    required this.colors,
    required this.file,
    required this.fillLike,
    this.similars = const [],
    required this.links,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      installAmount: json['install_amount'],
      id: json["id"],
      title: json["title"],
      priority: json["priority"],
      gold: json["gold"],
      likeAmount: json["like_amount"],
      active: json["active"],
      rating: json["rating"],
      type: json["type"],
      logo: json["logo"],
      description: json["description"],
      colors: () {
        var data = (json['colors']);
        List<Color> returnData = [];
        data.forEach((key, value) {
          returnData.add(Color(name: key, color: value));
        });
        return returnData;
      }(),
      file: File.fromJson(json["file"]),
      fillLike: Type.fromJson(json["fill_like"]),
      similars: json['similars'] != null
          ? List<Game>.from(json["similars"].map((x) => Game.fromJson(x)))
          : [],
      links: () {
        var data = (json['_links']);
        List<Link> returnData = [];
        data.forEach((key, value) {
          returnData.add(Link(name: key, href: value['href']));
        });
        return returnData;
      }(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "priority": priority,
        "gold": gold,
        "like_amount": likeAmount,
        "active": active,
        "rating": rating,
        "type": type,
        "logo": logo,
        "description": description,
        "colors": [],
        "file": file.toJson(),
        "fill_like": fillLike.toJson(),
        "similars": List<dynamic>.from(similars.map((x) => x)),
        "_links": [], //TO DO make convertation,
        "install_amount": installAmount
      };
}
