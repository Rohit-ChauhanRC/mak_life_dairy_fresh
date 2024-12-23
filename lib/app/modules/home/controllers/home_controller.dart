import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mak_life_dairy_fresh/app/data/services/shared_preference_service.dart';
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';

class HomeController extends GetxController {
  //
  final GlobalKey webViewKey = GlobalKey();

  final sharedPreferenceService = Get.find<SharedPreferenceService>();

  // var no = box.read(Constants.cred);

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String mobileNumber) => _mobileNumber.value = mobileNumber;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  // WebViewController webViewController = WebViewController();

  InAppWebViewController? webViewController;

  final ReceivePort _port = ReceivePort();

  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllow: "camera; microphone;storage;location",
    iframeAllowFullscreen: true,
    allowFileAccessFromFileURLs: true,
    allowContentAccess: true,
    allowFileAccess: true,
    allowsBackForwardNavigationGestures: true,
    useOnDownloadStart: true,
    allowUniversalAccessFromFileURLs: true,
    javaScriptCanOpenWindowsAutomatically: true,
    // automaticallyAdjustsScrollIndicatorInsets: true,
    // contentInsetAdjustmentBehavior:
    //     ScrollViewContentInsetAdjustmentBehavior.SCROLLABLE_AXES,
    geolocationEnabled: true,
  );

  PullToRefreshController? pullToRefreshController;

  Future<void> permisions() async {
    await Permission.storage.request();
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
    await Permission.microphone.request();
    await Permission.photos.request();
    await Permission.notification.request();
    await Permission.manageExternalStorage.request();
    await Permission.location.request();
    await Permission.locationWhenInUse.request();
    await Permission.locationAlways.request();
  }

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    mobileNumber = sharedPreferenceService.getString(userUId) ?? Get.arguments;
    await permisions();

    await Geolocator.requestPermission();

    LocationPermission permission = await Geolocator.checkPermission();

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = DownloadTaskStatus(data[1]);
    //   int progress = data[2];

    // });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // super.onClose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  void handleClick(WebUri url) async {
    await webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(url.toString())));
  }

  Future<void> downloadFile(String url, [String? filename]) async {
    final status = await Permission.storage.request();
    final statusAndroid = await Permission.manageExternalStorage.request();

    if (status.isGranted || statusAndroid.isGranted) {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: {},
        // optional: header send with url (auth token etc)
        savedDir: (await getApplicationDocumentsDirectory()).path,
        saveInPublicStorage: true,
        showNotification: true,
        openFileFromNotification: true,
        fileName: filename,
        allowCellular: true,
      );

      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("Download $filename completed!"),
      ));
    } else {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
    }
  }

  Future<bool> showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
