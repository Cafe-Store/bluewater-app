import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/events_controller.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Get.rootDelegate.popRoute()),
        title: Text(
          "진행중인 이벤트",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text('Events View'),
      ),
    );
  }
}
