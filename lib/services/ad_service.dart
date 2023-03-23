import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/ad.dart' as App;
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends GetxController {
  App.Ad ad;
  NativeAd? nativeAd;
  AdService({required this.ad});

  RxBool isInited = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    MobileAds.instance.initialize();
    nativeAd = NativeAd(
      adUnitId: ad.nativeUid, //ca-app-pub-3940256099942544/2247696110
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          print('[ads] loaded!' + ad.toString());
          nativeAd = ad as NativeAd;
          update();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print(
              '[ads] Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('[ads] Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('[ads] Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('[ads] Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => print('[ads] Ad clicked.'),
      ),
    );
    await nativeAd!.load();
    isInited = true.obs;
    update();
  }

  bool showNative(
      {int? categoryIndex,
      int? gameIndex,
      bool isInGamePage = false,
      bool isInDialog = false}) {
    if (!ad.enableNative) return false;

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
        if (gameIndex % ad.countMrecMain ==
                0 /*  &&
            ad.countMrecMainMax >= (gameIndex / ad.countMrec) */
            ) {
          return true;
        }
      }
    }

    return false;
  }

  Widget syncNativeAdWidget() {
    return GetBuilder<AdService>(builder: (model) {
      if (nativeAd!.responseInfo != null) {
        return StatefulBuilder(
          builder: (context, setState) => Container(
            padding: EdgeInsets.all(5),
            height: 160.0,
            decoration:
                BoxDecoration(border: Border.all(color: Color(0xFF262626))),
            alignment: Alignment.center,
            child: AdWidget(ad: nativeAd!),
          ),
        );
      }
      return Container();
    });
  }

  Future<Widget> asyncNativeAd() async {
    try {
      NativeAd? _ad;
      _ad = NativeAd(
        adUnitId: ad.nativeUid, //ca-app-pub-3940256099942544/2247696110
        factoryId: 'listTile',
        request: AdRequest(),
        listener: NativeAdListener(onAdLoaded: (loadedAd) {
          _ad = loadedAd as NativeAd;
        }, onAdFailedToLoad: (loadedAd, error) {
          debugger();
        }),
      );

      await _ad!.load();
      await Future.delayed(
          200.milliseconds); //cause admob blocks when ad generates often
      return StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.all(5),
          height: 160.0,
          decoration:
              BoxDecoration(border: Border.all(color: Color(0xFF262626))),
          alignment: Alignment.center,
          child: AdWidget(ad: _ad!),
        ),
      );
    } catch (e) {
      debugger();
    }
    return Container();
  }
}
