import 'package:get/get.dart';

import '../features/location/presentation/view/location_view.dart';
import '../features/root/bindings/root_binding.dart';
import '../features/root/views/root_view.dart';
import '../features/home/presentation/view/home_view.dart';
import '../features/home/presentation/binding/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.root,
      page: () => const RootView(),
      bindings: [
        RootBinding(),
      ],
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          preventDuplicates: true,
          name: _Paths.home,
          page: () => const HomeView(),
          bindings: [
            HomeBinding(),
          ],
          title: null,
        ),
        GetPage(
          name: _Paths.location,
          page: () => const LocationView(),
        )
      ],
    ),
  ];
}
