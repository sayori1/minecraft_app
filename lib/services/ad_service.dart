import 'dart:developer';

import 'package:flutter_application/models/base/ad.dart' as App;
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends GetxController {
  final App.Ad ad;
  NativeAd? nativeAd;
  AdService({required this.ad});

  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    MobileAds.instance.initialize();
    nativeAd = NativeAd(
      adUnitId: ad.nativeUid,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var _add = ad as NativeAd;
          print("**** AD ***** ${_add.responseInfo}");
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => print('Ad clicked.'),
      ),
    );
    await nativeAd!.load();
    isInited = true.obs;
    print('[debug] ad service inited');
  }

  bool showNative(
      {int? categoryIndex,
      int? gameIndex,
      bool isInGamePage = false,
      bool isInDialog = false}) {
    if (ad.enableNative) return false;

    if (isInGamePage && ad.enableMrecGamePage) return true;
    if (isInDialog && ad.enableMrecMain) return true;

    //нативка в категориях
    if (categoryIndex != null) {
      if (ad.enableMrecList) {
        if (categoryIndex % ad.countMrec == 0) {
          return true;
        }
      }
    }

    if (gameIndex != null) {
      if (ad.enableMrecList) {
        if (gameIndex % ad.countMrecMain == 0 &&
            ad.countMrecMainMax >= (gameIndex / ad.countMrec)) {
          return true;
        }
      }
    }

    return false;
  }
}
