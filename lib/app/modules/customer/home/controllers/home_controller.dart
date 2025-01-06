import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/data/services/location_service.dart';
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

  LocationService locationService = LocationService();

  // var no = box.read(Constants.cred);

  final RxString _mobileNumber = ''.obs;
  String get mobileNumber => _mobileNumber.value;
  set mobileNumber(String str) => _mobileNumber.value = str;

  final RxString _userId = ''.obs;
  String get userId => _userId.value;
  set userId(String str) => _userId.value = str;

  final RxBool _circularProgress = true.obs;
  bool get circularProgress => _circularProgress.value;
  set circularProgress(bool v) => _circularProgress.value = v;

  final RxDouble _progress = 0.0.obs;
  double get progress => _progress.value;
  set progress(double i) => _progress.value = i;

  // final RxDouble _lat = 0.0.obs;
  // double get lat => _lat.value;
  // set lat(double i) => _lat.value = i;

  // final RxDouble _long = 0.0.obs;
  // double get long => _long.value;
  // set long(double i) => _long.value = i;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;

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
    // allowingReadAccessTo: WebUri(source),
    applePayAPIEnabled: true,
    javaScriptEnabled: true,
    useShouldOverrideUrlLoading: true,

    domStorageEnabled: true,
    loadWithOverviewMode: true,
    verticalScrollBarEnabled: true,
    geolocationEnabled: true,
  );

  PullToRefreshController? pullToRefreshController;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    userId = sharedPreferenceService.getString(userUId) ?? Get.arguments;
    mobileNumber = sharedPreferenceService.getString(userMob)!;
    // await permisions();

    await Geolocator.requestPermission();

    LocationPermission permission = await Geolocator.checkPermission();

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await getCurrentLocation();
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

    if (sharedPreferenceService.getString(userMob) == "9876543210") {
      longitude.value = 77.0442445;
      latitude.value = 28.4133398;
    }
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

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    isLoading.value = true;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.');
      isLoading.value = false;
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.');
        isLoading.value = false;
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Error',
        'Location permissions are permanently denied. Cannot request permissions.',
      );
      isLoading.value = false;
      return;
    }

    // Get the current location
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      print(
          "longitude.value: ${longitude.value} latitude.value: ${latitude.value}");
      // Get.snackbar('Success',
      //     'Location fetched successfully. longitude.value ${longitude.value} latitude.value: ${latitude.value}');
    } catch (e) {
      Get.snackbar('Error', 'Error getting location: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
