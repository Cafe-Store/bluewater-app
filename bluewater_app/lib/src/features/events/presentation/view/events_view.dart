import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entity/event.dart';
import '../service/events_service.dart';

class EventsView extends GetView<EventsService> {
  final dateFormat = DateFormat('MM.dd');

  EventsView({Key? key}) : super(key: key);

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Obx(
          () => ListView.builder(
              itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    constraints: BoxConstraints(maxHeight: Get.height / 6),
                    child: _EventListItem(
                        item: controller.datas[index], dateFormat: dateFormat),
                  ),
              itemCount: controller.datas.length),
        ),
      ),
    );
  }
}

class _EventListItem extends StatelessWidget {
  final Event item;
  final DateFormat dateFormat;

  const _EventListItem({
    Key? key,
    required this.item,
    required this.dateFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: createItem(context),
    );
  }

  List<Widget> createItem(BuildContext context) {
    var widgetList = <Widget>[];

    widgetList.add(
      CachedNetworkImage(fit: BoxFit.cover, imageUrl: item.url),
    );

    if (item.endDate != null) {
      widgetList.add(
        Positioned(
          bottom: 10,
          right: 15,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.5)),
            child: Text(
              '~ ${dateFormat.format(item.endDate!)} 까지',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return widgetList;
  }
}
