import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/coupons_controller.dart';

class CouponsView extends GetView<CouponsController> {
  const CouponsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.rootDelegate.popRoute()),
        title: Text(
          "우리동네 쿠폰?",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Coupons View'),
      ),
    );
  }
}
