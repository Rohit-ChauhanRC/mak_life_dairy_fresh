import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'app/data/services/shared_preference_service.dart';

import 'app/routes/app_pages.dart';
import 'get_di.dart' as di;
import 'package:mak_life_dairy_fresh/app/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await FlutterDownloader.initialize(
      debug:
          true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );

  runApp(
    const App(),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPreferenceService = Get.find<SharedPreferenceService>();

    var userExist = sharedPreferenceService.getString(userUId) ?? "";
    var logType = sharedPreferenceService.getString(logtype) ?? "";
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: "Mak Life Dairy Fresh",
      initialRoute: userExist.isNotEmpty
          ? logType == "C"
              ? AppPages.INITIAL2
              : logType == "A"
                  ? AppPages.INITIAL1
                  : logType == "D"
                      ? AppPages.INITIAL3
                      : AppPages.INITIAL
          : AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
