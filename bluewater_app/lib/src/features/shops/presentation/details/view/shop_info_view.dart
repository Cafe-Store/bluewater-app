import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shop_details_controller.dart';

class ShopInfoView extends GetView<ShopDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () => Get.rootDelegate.popRoute(popMode: PopMode.History),
        ),
        title: Text(
          '매장정보',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Container(
        child: Center(
          child: Text(controller.shop.value.name),
        ),
      ),
    );
  }
}
