import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/location_service.dart';

class LocationView extends GetView<LocationService> {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Obx(() => Text(controller.adress.value)),
          Center(
              child: TextButton(
            onPressed: () => controller.adress('changed'),
            child: const Text('click'),
          )),
        ],
      ),
    );
  }
}
