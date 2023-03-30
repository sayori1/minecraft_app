import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/pigeons/native.dart';

class YandexAdsNativeWidget extends StatefulWidget {
  YandexAdsNativeWidget({
    Key? key,
    required this.id,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    this.width = 0,
    this.height = 0,
  }) : super(key: key);

  final String id;
  final int width;
  final int height;
  Function? onAdLoaded;
  Function? onAdFailedToLoad;
  Function? onImpression;
  Function? onAdClicked;
  Function? onLeftApplication;
  Function? onReturnedToApplication;

  Future<void> load() async {
    var native = YandexAdsNative();

    native.make(id);

    if (onAdLoaded != null) {
      native.onAdLoaded(id).then((value) {
        onAdLoaded!();
      });
    }

    if (onAdFailedToLoad != null) {
      native.onAdFailedToLoad(id).then((value) {
        onAdFailedToLoad!(value);
      });
    }

    if (onImpression != null) {
      native.onImpression(id).then((value) {
        onImpression!(value);
      });
    }

    if (onAdClicked != null) {
      native.onAdClicked(id).then((value) {
        onAdClicked!();
      });
    }

    if (onLeftApplication != null) {
      native.onLeftApplication(id).then((value) {
        onLeftApplication!();
      });
    }

    if (onReturnedToApplication != null) {
      native.onReturnedToApplication(id).then((value) {
        onReturnedToApplication!();
      });
    }

    await native.load(id, width, height);
  }

  @override
  State<YandexAdsNativeWidget> createState() => _YandexAdsNativeWidgetState();
}

class _YandexAdsNativeWidgetState extends State<YandexAdsNativeWidget> {
  bool loaded = false;

  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-native';

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'id': widget.id,
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          key: UniqueKey(),
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          key: UniqueKey(),
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
