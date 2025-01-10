import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:mak_life_dairy_fresh/app/routes/app_pages.dart';

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
        // controller.count = controller.count + 1;
        // debugPrint("controller.count: ${controller.count}");
        // if (controller.count == 3) {
        //   controller.showExitConfirmationDialog(Get.context!);
        //   // controller.count = 0;
        // }
        controller.onWillPop();
        // logic
        // if (didPop) {
        //   return;
        // }
        // final NavigatorState navigator = Navigator.of(context);
        // if (await controller.webViewController!.canGoBack()) {
        //   controller.webViewController!.goBack();
        // } else {
        //   navigator.pop();
        // }
      },
      child: Scaffold(
        // body: Center(
        //   child: ElevatedButton(
        //     onPressed: () async {
        //       if (await canLaunchUrl(Uri.parse(
        //           "upi://pay?pa=maklife.esbz@icici&pn=MAKLIFEPRODUCERCOMPANY&am=1.00&cu=INR"))) {
        //         await launchUrl(
        //             Uri.parse(
        //                 "upi://pay?pa=maklife.esbz@icici&pn=MAKLIFEPRODUCERCOMPANY&am=1.00&cu=INR"),
        //             mode: LaunchMode.externalApplication);
        //       } else {
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           const SnackBar(
        //               content: Text("No UPI app found to handle the request")),
        //         );
        //       }
        //     },
        //     child: const Text("Pay via UPI"),
        //   ),
        // ),
        body: SafeArea(
          child: Obx(() => controller.latitude.value >= 1 &&
                  controller.longitude.value >= 1
              ? Stack(
                  children: [
                    InAppWebView(
                      key: controller.webViewKey,
                      initialUrlRequest: URLRequest(
                          url: WebUri(
                              "https://plant.maklife.in:6028/Login/After_Login/${controller.userId.toString()}/${controller.latitude.value}/${controller.longitude.value}")),

                      //               initialUrlRequest:
                      //                   URLRequest(url: WebUri.uri(Uri.dataFromString("""
                      //   <!DOCTYPE html>
                      //   <html>
                      //   <head>
                      //     <title>Test</title>
                      //     <h1>check</h1>
                      //     <script>
                      //       function callDart() {
                      //         if (window.flutter_inappwebview) {
                      //           window.flutter_inappwebview.callHandler('deletionAccount', 'Test Message')
                      //             .then(response => alert('Response from Dart: ' + response))
                      //             .catch(error => alert('Error: ' + error));
                      //         } else {
                      //           alert('flutter_inappwebview is not available');
                      //         }
                      //       }
                      //     </script>
                      //   </head>
                      //   <body>
                      //     <h1>Test Page</h1>
                      //     <button onclick="callDart()">Call Dart</button>
                      //   </body>
                      //   </html>
                      // """, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')))),
                      initialSettings: controller.settings,
                      onWebViewCreated: (cx) {
                        controller.webViewController = cx;

                        cx.addJavaScriptHandler(
                          handlerName: "deletionAccount",
                          callback: (args) async {
                            controller.sharedPreferenceService.clear();
                            // Handle the call from JavaScript
                            // debugPrint(
                            //     "JavaScript called Dart with arguments: $args");

                            // // Return a response to JavaScript
                            // return "Dart received: ${args[0]}";
                            // if (await cx.canGoBack()) {
                            //   cx.goBack();
                            //   return true; // Prevent app exit
                            // }

                            Get.offAllNamed(Routes.VERIFY_PHONE_NUMBER);
                          },
                        );
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
                      shouldOverrideUrlLoading: (cx, navigationAction) async {
                        // com.genmak.mak_life_dairy_fresh/upi

                        const platform = MethodChannel(
                            "com.genmak.mak_life_dairy_fresh/upi");

                        if (!kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.iOS) {
                          final shouldPerformDownload =
                              navigationAction.shouldPerformDownload ?? false;
                          final url = navigationAction.request.url;
                          if (shouldPerformDownload && url != null) {
                            await controller.downloadFile(url.toString());
                            return NavigationActionPolicy.DOWNLOAD;
                          }
                        }
                        // var url = navigationAction.request.url;

                        // if (url!.scheme == "upi" && url.path.contains("pay")) {
                        //   try {
                        //     if (await canLaunchUrl(url)) {
                        //       await launchUrl(
                        //         url,
                        //       );
                        //     } else {
                        //       ScaffoldMessenger.of(Get.context!).showSnackBar(
                        //         const SnackBar(
                        //             content: Text(
                        //                 "No UPI app found to handle this request.")),
                        //       );
                        //     }
                        //   } catch (e) {
                        //     ScaffoldMessenger.of(Get.context!).showSnackBar(
                        //       SnackBar(
                        //           content: Text("Error launching UPI app: $e")),
                        //     );
                        //   }
                        //   return NavigationActionPolicy.CANCEL;
                        // }

                        // return NavigationActionPolicy.ALLOW;

                        var url = navigationAction.request.url.toString();

                        // Allow HTTP/HTTPS URLs
                        if (url.startsWith("http") || url.startsWith("https")) {
                          return NavigationActionPolicy.ALLOW;
                        }

                        // Handle UPI URLs using MethodChannel
                        if (url.startsWith("upi://pay")) {
                          try {
                            final bool handled = await platform
                                .invokeMethod("handleUPIUrl", {"url": url});
                            if (handled) {
                              return NavigationActionPolicy.CANCEL;
                            }
                          } on PlatformException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Error handling UPI URL: ${e.message}")),
                            );
                          }
                        }

                        // Block all other non-HTTP/HTTPS URLs
                        return NavigationActionPolicy.CANCEL;
                      },
                      onDownloadStartRequest: (cx, request) async {
                        if (kDebugMode) {
                          print('onDownloadStart ${request.url.toString()}');
                        }

                        await controller.downloadFile(
                            request.url.toString(), request.suggestedFilename);
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
                      onTitleChanged: (controller, title) {
                        if (title == "Web page not available") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Unable to load the requested page.")),
                          );
                        }
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
