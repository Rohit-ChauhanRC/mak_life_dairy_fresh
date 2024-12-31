import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      // onWillPop: () async {
      //   bool shouldExit = await controller.showExitConfirmationDialog(context);
      //   return shouldExit;
      // },
      canPop: false,
      onPopInvokedWithResult: (didPop, b) async {
        // logic
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);
        if (await controller.webViewController!.canGoBack()) {
          controller.webViewController!.goBack();
        } else {
          navigator.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(() =>
              // if (controller.isLoading.value) {
              //   return const Center(
              //       child: CircularProgressIndicator(
              //     color: Colors.blue,
              //   ));
              // }

              controller.latitude.value >= 1 && controller.longitude.value >= 1
                  ? Stack(
                      children: [
                        InAppWebView(
                          key: controller.webViewKey,
                          initialUrlRequest: URLRequest(
                              url: WebUri(
                                  "https://plant.maklife.in:6028/Login/After_Login/${controller.mobileNumber.toString()}/${controller.latitude.value}/${controller.longitude.value}")),
                          initialSettings: controller.settings,
                          onWebViewCreated: (cx) {
                            controller.webViewController = cx;
                          },
                          onLoadStop: (cx, url) async {
                            controller.circularProgress = false;
                            if (kDebugMode) {
                              print("Pulkit: $url");
                            }
                          },
                          onPermissionRequest: (controller, request) async {
                            return PermissionResponse(
                                resources: request.resources,
                                action: PermissionResponseAction.GRANT);
                          },
                          onProgressChanged: (cx, progress) {
                            controller.progress = progress / 100;
                            controller.circularProgress = false;
                          },
                          onConsoleMessage: (cx, consoleMessage) {
                            if (kDebugMode) {
                              print(consoleMessage.message);
                              print(consoleMessage.messageLevel);
                            }
                          },
                          shouldOverrideUrlLoading:
                              (cx, navigationAction) async {
                            if (!kIsWeb &&
                                defaultTargetPlatform == TargetPlatform.iOS) {
                              final shouldPerformDownload =
                                  navigationAction.shouldPerformDownload ??
                                      false;
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
                              print(
                                  'onDownloadStart ${request.url.toString()}');
                            }

                            await controller.downloadFile(
                                request.url.toString(),
                                request.suggestedFilename);
                          },
                          onGeolocationPermissionsHidePrompt: (controller) {},
                          onGeolocationPermissionsShowPrompt:
                              (InAppWebViewController controller,
                                  String origin) async {
                            return GeolocationPermissionShowPromptResponse(
                              allow: true,
                              origin: origin,
                              retain: true,
                            );
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
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: Colors.blue,
                    ))),
        ),
      ),
    );
  }
}
