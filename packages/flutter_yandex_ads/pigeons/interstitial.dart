import 'package:pigeon/pigeon.dart';

class InterstitialError {
  late int code;
  late String description;
}

class InterstitialImpression {
  late String data;
}

@HostApi()
abstract class YandexAdsInterstitial {
  void make(String id);

  void load(String id);

  void show(String id);

  @async
  void onAdLoaded(String id);

  @async
  InterstitialError onAdFailedToLoad(String id);

  @async
  void onAdShown(String id);

  @async
  void onAdDismissed(String id);

  @async
  void onAdClicked(String id);

  @async
  void onLeftApplication(String id);

  @async
  void onReturnedToApplication(String id);

  @async
  InterstitialImpression onImpression(String id);
}
