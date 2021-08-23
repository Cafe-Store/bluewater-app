part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const location = _Paths.location;
  static const shops = _Paths.shops;
  static const shopsDashboard = shops + _Paths.shopsDashboard;
  static String shopDetails(String shopId) => '$shops/$shopId';
  static const events = _Paths.events;
  static const coupons = _Paths.coupons;
  static const favorite = _Paths.favorites;

  static const home = _Paths.home;
  static const dashboard = _Paths.home + _Paths.dashboard;
  static const search = _Paths.home + _Paths.search;
  static const orders = _Paths.home + _Paths.orders;
  static const profile = _Paths.home + _Paths.profile;
}

abstract class _Paths {
  static const location = '/location';
  static const shops = '/shops';
  static const shopsDashboard = '/shops_dashboard';
  static const shopDetails = '/:shopId';
  static const events = '/events';
  static const coupons = '/coupons';
  static const favorites = '/favorites';

  static const home = '/home';
  static const search = '/search';
  static const orders = '/orders';
  static const profile = '/profile';
  static const dashboard = '/dashboard';
}
