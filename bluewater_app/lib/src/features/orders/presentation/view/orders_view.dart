import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Orders View'),
    );
  }
}
