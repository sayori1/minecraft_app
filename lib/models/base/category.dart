import 'color.dart';
import 'game.dart';
import 'link.dart';
import 'type.dart';

class Category {
  List<Game> gamesTop;
  int id;
  String alias;
  bool active;
  int priority;
  String title;
  List<Color> colors;
  List<Link> links;

  Category({
    required this.gamesTop,
    required this.id,
    required this.alias,
    required this.active,
    required this.priority,
    required this.title,
    required this.colors,
    required this.links,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      gamesTop: List<Game>.from(json["gamesTop"].map((x) => Game.fromJson(x))),
      id: json["id"],
      alias: json["alias"],
      active: json["active"],
      priority: json["priority"],
      title: json["title"],
      colors: () {
        var data = (json['colors']);
        List<Color> returnData = [];
        data.forEach((key, value) {
          returnData.add(Color(name: key, color: value));
        });
        return returnData;
      }(),
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
        "gamesTop": List<dynamic>.from(gamesTop.map((x) => x.toJson())),
        "id": id,
        "alias": alias,
        "active": active,
        "priority": priority,
        "title": title,
        "colors": [],
        "_links": [],
      };
}
