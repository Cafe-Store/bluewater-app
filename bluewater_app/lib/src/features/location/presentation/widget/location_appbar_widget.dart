import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../../../routes/app_pages.dart';
import '../service/location_service.dart';

class LocationAppbarWidget extends GetWidget<LocationService> {
  const LocationAppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Transform.rotate(
          angle: math.pi / 4,
          child: const Icon(
            Icons.navigation,
            color: Colors.amber,
          ),
        ),
        dense: true,
        contentPadding: const EdgeInsets.all(0),
        horizontalTitleGap: -10,
        title: Row(
          children: [
            Obx(() => Text(
                  controller.adress.value,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.amber,
            )
          ],
        ),
      ),
      onTap: () => Get.rootDelegate.toNamed(Routes.location),
    );
  }
}
