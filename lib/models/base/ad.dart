import './type.dart';

class Ad {
  String nativeUid;
  String interUid;
  String rewardUid;
  String bannerUid;
  String interRewardUid;
  String goldRewardUid;
  String mrecUid;

  int countInter;
  int countReview;
  int countReviewFact;
  int countMrec;
  int countMrecMain;
  int countMrecMainMax;

  Type adType;
  bool enableBanner;
  bool enableMrec;
  bool enableNative;
  bool enableNativePreload;
  bool enableMrecList;
  bool enableMrecGamePage;
  bool enableMrecMain;
  bool enableOpen;

  Ad({
    required this.nativeUid,
    required this.interUid,
    required this.rewardUid,
    required this.bannerUid,
    required this.interRewardUid,
    required this.goldRewardUid,
    required this.mrecUid,
    required this.countInter,
    required this.countReview,
    required this.countReviewFact,
    required this.countMrec,
    required this.adType,
    required this.enableBanner,
    required this.enableMrec,
    required this.enableNative,
    required this.enableMrecList,
    required this.enableMrecGamePage,
    required this.enableNativePreload,
    required this.enableOpen,
    required this.countMrecMain,
    required this.countMrecMainMax,
    required this.enableMrecMain,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      nativeUid: json['native_uid'],
      interUid: json['inter_uid'],
      rewardUid: json['reward_uid'],
      bannerUid: json['banner_uid'],
      interRewardUid: json['inter_reward_uid'],
      goldRewardUid: json['gold_reward_uid'],
      mrecUid: json['mrec_uid'],
      countInter: json['count_inter'],
      countReview: json['count_review'],
      countReviewFact: json['count_review_fact'],
      countMrec: json['count_mrec'],
      adType: Type.fromJson(json['ad_type']),
      enableBanner: json['enable_banner'],
      enableMrec: json['enable_mrec'],
      enableNative: json['enable_native'],
      enableMrecList: json['enable_mrec_list'],
      enableMrecGamePage: json['enable_mrec_game_page'],
      enableNativePreload: json['enable_native_preload'],
      enableOpen: json['enable_open'],
      countMrecMain: json['count_mrec_main'],
      countMrecMainMax: json['count_mrec_main_max'],
      enableMrecMain: json['enable_mrec_main'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['native_uid'] = nativeUid;
    data['inter_uid'] = interUid;
    data['reward_uid'] = rewardUid;
    data['banner_uid'] = bannerUid;
    data['inter_reward_uid'] = interRewardUid;
    data['gold_reward_uid'] = goldRewardUid;
    data['mrec_uid'] = mrecUid;
    data['count_inter'] = countInter;
    data['count_review'] = countReview;
    data['count_review_fact'] = countReviewFact;
    data['count_mrec'] = countMrec;
    data['ad_type'] = adType.toJson();
    data['enable_banner'] = enableBanner;
    data['enable_mrec'] = enableMrec;
    data['enable_native'] = enableNative;
    data['enable_mrec_list'] = enableMrecList;
    data['enable_mrec_game_page'] = enableMrecGamePage;
    data['enable_native_preload'] = enableNativePreload;
    data['enable_open'] = enableOpen;
    return data;
  }
}
