import 'ad.dart';
import 'image.dart';
import 'link.dart';
import 'type.dart';

class Application {
  int id;
  String packageName;
  Type? adType;
  Type? osType;
  Type? gameType;
  bool active;
  bool activeAd;
  bool activeReview;
  bool dev;
  String version;
  String build;
  Meta meta;
  Image? logo;
  Image? infoImage;
  Image? preloadImage;
  Ad? ad;
  List<Link> links;

  Application({
    required this.id,
    required this.packageName,
    this.adType,
    this.osType,
    this.gameType,
    required this.active,
    required this.activeAd,
    required this.activeReview,
    required this.dev,
    required this.version,
    required this.build,
    required this.meta,
    this.logo,
    this.infoImage,
    this.preloadImage,
    this.ad,
    required this.links,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      packageName: json['package_name'],
      adType: json['ad_type'] != null ? Type.fromJson(json['ad_type']) : null,
      osType: json['os_type'] != null ? Type.fromJson(json['os_type']) : null,
      gameType:
          json['game_type'] != null ? Type.fromJson(json['game_type']) : null,
      active: json['active'],
      activeAd: json['active_ad'],
      activeReview: json['active_review'],
      dev: json['dev'],
      version: json['version'],
      build: json['build'].toString(),
      meta: Meta.fromJson(json['meta']),
      logo: json['logo'] != null ? Image.fromJson(json['logo']) : null,
      infoImage: json['info_image'] != null
          ? Image.fromJson(json['info_image'])
          : null,
      preloadImage: json['preload_image'] != null
          ? Image.fromJson(json['preload_image'])
          : null,
      ad: json['ad'] != null ? Ad.fromJson(json['ad']) : null,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['package_name'] = packageName;
    data['ad_type'] = adType?.toJson();
    data['os_type'] = osType?.toJson();
    data['game_type'] = gameType?.toJson();
    data['active'] = active;
    data['active_ad'] = activeAd;
    data['active_review'] = activeReview;
    data['dev'] = dev;
    data['version'] = version;
    data['build'] = build;
    data['meta'] = meta.toJson();
    data['logo'] = logo?.toJson();
    data['info_image'] = infoImage?.toJson();
    data['preload_image'] = preloadImage?.toJson();
    data['ad'] = ad?.toJson();
    data['_links'] = []; // TO DO add conversion for links
    return data;
  }
}
