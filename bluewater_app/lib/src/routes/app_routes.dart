part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const root = _Paths.root;
  static const home = _Paths.root + _Paths.home;
  static const user = _Paths.root + _Paths.user;
  static const shop = _Paths.root + _Paths.shop;
  static const location = _Paths.root + _Paths.location;
}

abstract class _Paths {
  static const root = '/bluewater';
  static const home = '/home';
  static const user = '/user';
  static const shop = '/shop';
  static const location = '/location';
}
