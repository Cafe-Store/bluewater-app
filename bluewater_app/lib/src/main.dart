import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/injector/injection.dart';
import 'core/util/const.dart';
import 'features/events/presentation/controller/events_controller.dart';
import 'features/search/presentation/controller/categories_controller.dart';
import 'features/shops_dashboard/presentation/controller/shops_dashboard_controller.dart';
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
          //대시보드의 가게 목록에서 필터 선택 유지하기 위해서
          Get.put<ShopsDashboardController>(
              ShopsDashboardController(tag: Tags.dashboard),
              tag: Tags.dashboard,
              permanent: true);

          Get.put<CategoriesController>(CategoriesController(),
              permanent: true);
          Get.put<EventsController>(EventsController(), permanent: true);
        },
      ),
    );
  }
}
