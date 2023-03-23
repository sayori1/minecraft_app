import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

/*
Так как dart однопоточен, то для того, чтобы работать в разных потоках, приходится прибегать к изолятам,
которые могут запускаться только в отдельных контекстах, поэтому связь между ними организуется через ReceivePort */

class DownloaderService extends GetxController {
  final ReceivePort _port = ReceivePort();

  RxString currentTask = RxString("");
  Rx<DownloadTaskStatus> status = Rx(DownloadTaskStatus.running);
  RxInt step = RxInt(0);

  @override
  void onInit() async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      currentTask.value = data[0];
      status.value = DownloadTaskStatus(data[1]);
      step.value = data[2];
      update();
    });

    await FlutterDownloader.registerCallback(DownloaderService.downloadCallback,
        step: 5);

    super.onInit();
  }

  Future<String?> startDownloading(String url, String name) async {
    return FlutterDownloader.enqueue(
      url: url,
      saveInPublicStorage: true,
      fileName: name,
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: (await getTemporaryDirectory()).absolute.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
  }

  Future<void> stopDownloading() async {
    await FlutterDownloader.cancel(taskId: currentTask.value);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status.value, progress]);
  }

  static Future<bool> isDownloaded(String url) async {
    List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();
    DownloadTask? task = tasks!.firstWhereOrNull((e) => e.url == url);
    return task != null;
  }

  static Future<void> open(String url) async {
    List<DownloadTask>? tasks = await FlutterDownloader.loadTasks();
    DownloadTask? task = tasks!.firstWhere((e) => e.url == url);
    if (task != null) {
      FlutterDownloader.open(taskId: task.taskId);
    }
  }
}
