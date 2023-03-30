import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application/models/base/ad.dart' as App;
import 'package:flutter_application/views/main/main_controller.dart';
import 'package:flutter_yandex_ads/components/interstitial.dart';
import 'package:flutter_yandex_ads/pigeons/banner.dart';
import 'package:flutter_yandex_ads/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads/pigeons/native.dart';
import 'package:flutter_yandex_ads/widgets/native.dart';
import 'package:flutter_yandex_ads/yandex.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdService extends GetxController {
  App.Ad ad;
  AdService({required this.ad});

  InterstitialAd? googleInterstitialAd;
  YandexAdsInterstitialComponent? yandexInterstitialAd;
  int countOfVisitedPages = 0;

  @override
  Future<void> onInit() async {
    super.onInit();
    MobileAds.instance.initialize();
    FlutterYandexAds.initialize();
  }

  bool isGoogleAds() {
    return ad.adType == 'GOOGLE';
  }

  bool needToShowNative({
    int? categoryIndex,
    int? gameIndex,
    bool isInGamePage = false,
    bool isInDialog = false,
    bool isInMainPage = false,
  }) {
    if (!ad.enableNative) return false;

    if (isInMainPage && gameIndex == ad.countMrecMain)
      return true; //TO DO add condition from backend
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

  Future<Widget> asyncNativeAd() async {
    if (isGoogleAds()) return await asyncGoogleNativeAd();
    return await asyncYandexNativeAd();
  }

  Future<Widget> asyncYandexNativeAd() async {
    Completer<bool> adLoaded = Completer();

    var yAd = YandexAdsNativeWidget(
      id: 'R-M-2268755-1',
      onAdLoaded: () {
        adLoaded.complete(true);
      },
      onAdFailedToLoad: (BannerError err) {
        debugger();
        adLoaded.complete(false);
      },
      onImpression: (BannerImpression? data) {
        print("native onImpression ${data?.data}");
      },
      onAdClicked: () {
        print('native onAdClicked');
      },
    );

    await yAd.load();
    bool result = await adLoaded.future;

    if (!result) return Container();
    return StatefulBuilder(
        key: UniqueKey(),
        builder: (context, setState) => Container(
                padding: EdgeInsets.all(5),
                width: Get.width,
                height: 210,
                child: yAd)
            .marginOnly(top: 10, bottom: 10));
  }

  Future<Widget> asyncGoogleNativeAd() async {
    Completer<bool> adLoaded = Completer();

    NativeAd _ad = NativeAd(
      adUnitId: ad.nativeUid, //ca-app-pub-3940256099942544/2247696110
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(onAdLoaded: (_) {
        adLoaded.complete(true);
      }, onAdFailedToLoad: (_, e) {
        adLoaded.complete(false);
      }),
    );

    await _ad.load();
    bool result = await adLoaded.future;
    if (!result) return Container();

    return StatefulBuilder(
      builder: (context, setState) => Container(
        padding: EdgeInsets.all(5),
        height: 200.0,
        decoration: BoxDecoration(border: Border.all(color: Color(0xFF262626))),
        alignment: Alignment.center,
        child: AdWidget(ad: _ad),
      ),
    );
  }

  bool needToShowInterstitial() {
    return false;
    if (countOfVisitedPages % ad.countInter == 0) return true;
    return false;
  }

  void callInterstitalShowing() {
    if (isGoogleAds()) {
      googleInterstitialAd?.show();
      loadGoogleInterstitial();
    } else {
      yandexInterstitialAd?.show();
      loadYandexInterstitial();
    }
  }

  void visitNewPage() {
    bool needTo = needToShowInterstitial();
    countOfVisitedPages += 1;
    if (needTo) {
      callInterstitalShowing();
    }
  }

  void loadYandexInterstitial() {
    yandexInterstitialAd = YandexAdsInterstitialComponent(
      id: 'R-M-2268755-2',
      onAdLoaded: () {
        print('interstitial onAdLoaded');
      },
      onAdFailedToLoad: (InterstitialError err) {
        print(
            'interstitial onAdFailedToLoad code: ${err.code}, description: ${err.description}');
      },
      onAdDismissed: () {
        print("interstitial onAdDismissed");
      },
      onAdShown: () {
        yandexInterstitialAd = null;
      },
      onImpression: (InterstitialImpression? data) {
        yandexInterstitialAd = null;
      },
    );

    yandexInterstitialAd!.load();
  }

  void loadGoogleInterstitial() {
    InterstitialAd.load(
        adUnitId: ad.interUid,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            googleInterstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }
}
