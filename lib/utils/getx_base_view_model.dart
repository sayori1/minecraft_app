import 'dart:async';

import 'package:get/get.dart';

class GetxBaseViewModel extends GetxController {
  String? errorMessage;

  bool get hasError => errorMessage != null;
  bool _isBusy = false;
  Completer isLoaded = Completer();

  bool get isBusy => _isBusy;

  Future<void> runFuture(Future<void> Function() body) async {
    try {
      isLoaded = Completer();
      setBusy(true);
      errorMessage = null;
      await body();
    } catch (e) {
      errorMessage = "Ошибка!";
      while (Get.isSnackbarOpen) await Future.delayed(200.milliseconds);
    } finally {
      setBusy(false);
      isLoaded.complete();
    }
  }

  void setBusy(bool value) {
    _isBusy = value;
    if (_isBusy) {
      errorMessage = null;
    }
    update();
  }
}
