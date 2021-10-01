import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/injector/injection.dart';
import 'core/util/const.dart';
import 'features/shops/presentation/categorized_shops/controller/categorized_shops_controller.dart';
import 'features/shops/presentation/dashboard/controller/shop_list_controller.dart';
import 'features/shops/presentation/filter/controller/shops_filter_controller.dart';
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
      routeInformationParser: GetInformationParser(
          // initialRoute: Routes.HOME,
          ),
      routerDelegate: GetDelegate(
        preventDuplicateHandlingMode: PreventDuplicateHandlingMode.DoNothing,
      ),
      initialBinding: BindingsBuilder(
        () {
          //대시보드의 가게 목록에서 필터 선택 유지하기 위해서
          Get.put<ShopListController>(
              ShopListController(tag: Tags.homeDashboard),
              tag: Tags.homeDashboard,
              permanent: true);
          Get.put<ShopsFilterController>(ShopsFilterController(),
              tag: Tags.homeDashboard, permanent: true);

          Get.put<CategorizedShopsController>(CategorizedShopsController(),
              tag: Tags.homeNewlyShops, permanent: true);

          Get.put<CategorizedShopsController>(CategorizedShopsController(),
              tag: Tags.homePopularShops, permanent: true);
        },
      ),
    );
  }
}
