import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shops_dashboard_controller.dart';

class ShopsDashboardView extends GetView<ShopsDashboardController> {
  const ShopsDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.rootDelegate.popRoute()),
        title: Text(
          "의류",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Shops View'),
      ),
    );
  }
}
