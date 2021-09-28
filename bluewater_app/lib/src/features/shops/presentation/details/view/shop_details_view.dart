import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shop_details_controller.dart';

class ShopDetailsView extends GetView<ShopDetailsController> {
  const ShopDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => controller.startRouteName != null
              ? Get.rootDelegate.offNamed(controller.startRouteName.toString())
              : Get.rootDelegate.popRoute(),
        ),
        title: Text(
          '가게 상세 화면인데?',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Text(
            'id : ${controller.shopId} route : ${controller.startRouteName}'),
      ),
    );
  }
}
