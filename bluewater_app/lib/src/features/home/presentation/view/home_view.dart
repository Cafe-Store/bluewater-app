import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shop/presentation/widget/shop_list_widget.dart';
import '../controller/home_controller.dart';
import '../../../location/presentation/widget/location_appbar_widget.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: RefreshIndicator(
          color: Colors.black,
          onRefresh: () async =>
              //TODO 네트워크 타서 데이터 갱신
              await Future.delayed(const Duration(seconds: 1), () => true),
          child: const ShopListWidget(),
        ));
  }
}

class TheSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => "Enter a web address";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
    final suggestions = query.isEmpty;
    return Container();
  }
}
