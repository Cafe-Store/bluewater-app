import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/injector/injection.dart';
import 'features/location/presentation/service/location_service.dart';
import 'routes/app_pages.dart';
import 'shared/ui/theme/app_themedata.dart';

void main() {
  configureInjection(Env.dev);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartkTheme,
      getPages: AppPages.routes,
      initialBinding: BindingsBuilder(
        () {
          Get.put(LocationService());
        },
      ),
    );
  }
}
