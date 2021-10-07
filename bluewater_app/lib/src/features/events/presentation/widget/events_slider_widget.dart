import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/ui/widget/shimmer/shimmer_loading.dart';
import '../../domain/entity/event.dart';
import '../service/events_service.dart';

class EventSlider extends GetWidget<EventsService> {
  EventSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CarouselSlider.builder(
          itemCount: controller.datas.isNotEmpty ? controller.datas.length : 1,
          itemBuilder: (context, index, realIndex) {
            return ShimmerLoading(
              isLoading: controller.datas.isEmpty,
              child: controller.datas.isNotEmpty
                  ? _SliderItem(
                      item: controller.datas[index],
                      total: controller.datas.length,
                      index: ++index)
                  : Container(
                      color: Colors.black,
                    ),
            );
          },
          options: CarouselOptions(
            height: Get.height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            scrollPhysics: controller.datas.isEmpty
                ? NeverScrollableScrollPhysics()
                : null,
          ),
        );
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
