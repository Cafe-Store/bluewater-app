import 'package:get/get.dart';

import '../features/coupons/presentation/binding/coupons_binding.dart';
import '../features/coupons/presentation/view/coupons_view.dart';
import '../features/dashboard/presentation/binding/dashboard_binding.dart';
import '../features/dashboard/presentation/view/dashboard_view.dart';
import '../features/events/presentation/binding/events_binding.dart';
import '../features/events/presentation/view/events_view.dart';
import '../features/favorites/presentation/binding/favorites_binding.dart';
import '../features/favorites/presentation/view/favorites_view.dart';
import '../features/home/presentation/binding/home_binding.dart';
import '../features/home/presentation/view/home_view.dart';
import '../features/location/presentation/binding/location_binding.dart';
import '../features/location/presentation/view/location_view.dart';
import '../features/orders/presentation/binding/orders_binding.dart';
import '../features/orders/presentation/view/orders_view.dart';
import '../features/profile/presentation/binding/profile_binding.dart';
import '../features/profile/presentation/view/profile_view.dart';
import '../features/root/bindings/root_binding.dart';
import '../features/root/views/root_view.dart';
import '../features/search/presentation/binding/search_binding.dart';
import '../features/search/presentation/view/search_view.dart';
import '../features/shop_details/presentation/binding/shop_details_binding.dart';
import '../features/shop_details/presentation/view/shop_details_view.dart';
import '../features/shops/presentation/binding/shops_binding.dart';
import '../features/shops/presentation/view/shops_view.dart';
import '../features/shops_dashboard/presentation/binding/shops_dashboard_binding.dart';
import '../features/shops_dashboard/presentation/view/shops_dashboard_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: '/',
      page: () => const RootView(),
      bindings: [
        RootBinding(),
        LocationBinding(),
      ],
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          preventDuplicates: true,
          name: _Paths.home,
          page: () => const HomeView(),
          binding: HomeBinding(),
          children: [
            GetPage(
                name: _Paths.dashboard,
                page: () => const DashboardView(),
                bindings: [
                  DashboardBinding(),
                  EventsBinding(),
                  SearchBinding(),
                ]),
            GetPage(
              name: _Paths.search,
              page: () => const SearchView(),
              binding: SearchBinding(),
            ),
            GetPage(
              name: _Paths.orders,
              page: () => const OrdersView(),
              binding: OrdersBinding(),
            ),
            GetPage(
              name: _Paths.profile,
              page: () => const ProfileView(),
              binding: ProfileBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.location,
          page: () => const LocationView(),
        ),
        GetPage(
          name: _Paths.shops,
          page: () => const ShopsView(),
          binding: ShopsBinding(),
          children: [
            GetPage(
              name: _Paths.shopsDashboard,
              page: () => const ShopsDashboardView(),
              binding: ShopsDashboardBinding(),
            ),
            GetPage(
              name: _Paths.shopDetails,
              page: () => const ShopDetailsView(),
              binding: ShopDetailsBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.events,
          page: () => EventsView(),
          binding: EventsBinding(),
        ),
        GetPage(
          name: _Paths.coupons,
          page: () => const CouponsView(),
          binding: CouponsBinding(),
        ),
        GetPage(
          name: _Paths.favorites,
          page: () => const FavoritesView(),
          binding: FavoritesBinding(),
        ),
      ],
    ),
  ];
}
