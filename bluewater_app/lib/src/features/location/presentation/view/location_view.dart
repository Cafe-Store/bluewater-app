import 'package:bluewater_app/src/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/location_service.dart';

class LocationView extends GetView<LocationService> {
  final double _appbarBottomheight = 50.0;
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Get.rootDelegate.offNamed(Routes.root)),
        title: Text(
          "배달지 주소 설정",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: false,
        bottom: PreferredSize(
            child: SizedBox(
              height: _appbarBottomheight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      hintText: '도로명, 건물명 또는 지번으로 검색'),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(_appbarBottomheight)),
      ),
      body: Container(),
    );
  }
}
