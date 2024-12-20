import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show a dialog or perform any custom logic here
        bool shouldExit = await controller.showExitConfirmationDialog(context);
        return shouldExit; // true allows the app to close, false prevents it
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                key: controller.webViewKey,
                initialUrlRequest: URLRequest(
                    url: WebUri(
                        "https://plant.maklife.in:6028/Login/After_Login/${controller.mobileNumber.toString()}")),
                initialSettings: controller.settings,
                // pullToRefreshController: controller.pullToRefreshController,
                onWebViewCreated: (cx) {
                  controller.webViewController = cx;
                },
                onLoadStop: (cx, url) async {
                  controller.circularProgress = false;
                  // await controller.saveCookies(url!);
                  if (kDebugMode) {
                    print("Pulkit: $url");
                  }
                  // if ("http://app.maklife.in:8016/index.php/Login/after_login" ==
                  //     url.toString()) {
                  //   await launchUrl(
                  //     Uri.parse(
                  //         "http://app.maklife.in:8016/index.php/Home/after_login"),
                  //     mode: LaunchMode.inAppWebView,
                  //   );
                  // }
                },

                onPermissionRequest: (controller, request) async {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },
                // onReceivedError: (cx, request, error) {
                //   controller.pullToRefreshController!.endRefreshing();
                // },
                onProgressChanged: (cx, progress) {
                  controller.progress = progress / 100;
                  controller.circularProgress = false;
                },
                // onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (cx, consoleMessage) {
                  if (kDebugMode) {
                    print(consoleMessage);
                  }
                },
                shouldOverrideUrlLoading: (cx, navigationAction) async {
                  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
                    final shouldPerformDownload =
                        navigationAction.shouldPerformDownload ?? false;
                    final url = navigationAction.request.url;
                    if (shouldPerformDownload && url != null) {
                      await controller.downloadFile(url.toString());
                      return NavigationActionPolicy.DOWNLOAD;
                    }
                  }
                  return NavigationActionPolicy.ALLOW;
                },
                onDownloadStartRequest: (cx, request) async {
                  if (kDebugMode) {
                    print('onDownloadStart ${request.url.toString()}');
                  }

                  await controller.downloadFile(
                      request.url.toString(), request.suggestedFilename);
                },
              ),
              Positioned(
                  top: Get.height * 0.5,
                  child: Obx(() => controller.circularProgress == true
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.blue,
                        ))
                      : Container())),
            ],
          ),
        ),
      ),
    );
  }
}
