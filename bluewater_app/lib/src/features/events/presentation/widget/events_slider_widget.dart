import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../routes/app_pages.dart';
import '../../../../shared/ui/color/shimmer_color.dart';
import '../../domain/entity/event.dart';
import '../service/events_service.dart';

class EventSlider extends GetWidget<EventsService> {
  EventSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: _createContents(context),
      ),
    );
  }

  List<Widget> _createContents(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(_createSlider());

    if (controller.datas.isNotEmpty) {
      widgets.add(_createCountWidget(context));
      widgets.add(_createShowAllWidget(context));
    }
    return widgets;
  }

  Widget _createSlider() {
    return CarouselSlider.builder(
      itemCount: controller.datas.isNotEmpty ? controller.datas.length : 1,
      itemBuilder: (context, index, realIndex) {
        return controller.datas.isNotEmpty
            ? _SliderItem(
                item: controller.datas[index],
              )
            : Shimmer.fromColors(
                child: Container(
                  color: Colors.black,
                ),
                baseColor: ShimmerColor.baseColor,
                highlightColor: ShimmerColor.highlightColor);
      },
      options: CarouselOptions(
        autoPlay: true,
        height: Get.height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          controller.currentIdex(++index);
        },
        scrollPhysics:
            controller.datas.isEmpty ? NeverScrollableScrollPhysics() : null,
      ),
    );
  }

  Widget _createCountWidget(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.black.withOpacity(0.5)),
        child: Text(
          '${controller.currentIdex} / ${controller.datas.length}',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

Positioned _createShowAllWidget(BuildContext context) {
  return Positioned(
    bottom: 10,
    right: 10,
    child: InkWell(
      onTap: () => Get.rootDelegate.toNamed(Routes.events),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.black.withOpacity(0.5)),
        child: Text(
          '이벤트 전체 보기',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
        ),
      ),
    ),
  );
}

class _SliderItem extends StatelessWidget {
  final Event item;
  const _SliderItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: item.url,
      fit: BoxFit.cover,
    );
  }
}
