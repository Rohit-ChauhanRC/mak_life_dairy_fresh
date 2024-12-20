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

class App extends StatelessWidget {
  const App({super.key});

  // sharedPreferenceService.setString(userUId, uid);

  @override
  Widget build(BuildContext context) {
    final sharedPreferenceService = Get.find<SharedPreferenceService>();

    // sharedPreferenceService.init();

    var userExist = sharedPreferenceService.getString(userUId) ?? "";
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mak Life Dairy Fresh",
      initialRoute: userExist.isNotEmpty ? AppPages.INITIAL2 : AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
