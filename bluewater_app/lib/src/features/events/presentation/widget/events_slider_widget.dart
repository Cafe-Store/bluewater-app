import 'package:bluewater_app/src/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../domain/entity/event.dart';
import '../controller/events_controller.dart';

class EventSlider extends GetWidget<EventsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.datas.isEmpty) {
          return Center(
            child: SpinKitThreeBounce(
              color: Colors.grey,
              size: 15,
            ),
          );
        } else {
          return CarouselSlider.builder(
            itemCount: controller.datas.length,
            itemBuilder: (context, index, realIndex) {
              return _SliderItem(
                  item: controller.datas[index],
                  total: controller.datas.length,
                  index: ++index);
            },
            options: CarouselOptions(
              height: Get.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
          );
        }
      },
    );
  }
}

class _SliderItem extends StatelessWidget {
  final int total;
  final int index;
  final Event item;
  const _SliderItem(
      {required this.item, required this.total, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: item.url,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.5)),
            child: Text(
              '$index / $total',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.5)),
            child: InkWell(
              onTap: () => Get.rootDelegate.toNamed(Routes.events),
              child: Text(
                '이벤트 전체 보기',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
