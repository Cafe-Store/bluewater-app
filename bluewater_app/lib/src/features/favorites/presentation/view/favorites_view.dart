import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/favorites_controller.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Get.rootDelegate.popRoute(popMode: PopMode.History);
            }),
        title: Text(
          "즐겨찾기",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Favorites View'),
      ),
    );
  }
}
