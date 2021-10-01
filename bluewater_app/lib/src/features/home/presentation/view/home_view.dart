import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../location/presentation/widget/location_appbar_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        var currentIndex = getCurrentIndex(currentLocation);

        return Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: LocationAppbarWidget(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: TheSearch());
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: GetRouterOutlet(
            initialRoute: Routes.dashboard,
            // anchorRoute: Routes.HOME,
            key: Get.nestedKey(Routes.home),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            onTap: (value) {
              switch (value) {
                case 0:
                  delegate.offAndToNamed(Routes.home);
                  break;
                case 1:
                  delegate.offAndToNamed(Routes.homeSearch);
                  break;
                case 2:
                  delegate.toNamed(Routes.favorite);
                  break;
                case 3:
                  delegate.offAndToNamed(Routes.orders);
                  break;
                case 4:
                  delegate.offAndToNamed(Routes.profile);
                  break;
                default:
              }
            },
            items: const [
              // _Paths.HOME + [Empty]
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_rounded),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_rounded),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  int getCurrentIndex(String? currentLocation) {
    var index = 0;

    if (true == currentLocation?.startsWith(Routes.homeSearch)) {
      index = 1;
    } else if (true == currentLocation?.startsWith(Routes.favorite)) {
      index = 2;
    } else if (true == currentLocation?.startsWith(Routes.orders)) {
      index = 3;
    } else if (true == currentLocation?.startsWith(Routes.profile)) {
      index = 4;
    }

    return index;
  }
}

class TheSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Enter a web address";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 'null');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final suggestions = query.isEmpty;
    return Container();
  }
}
