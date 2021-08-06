import 'package:bluewater_app/src/shared/ui/theme/app_themedata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'features/location/presentation/service/location_service.dart';

void main() {
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
