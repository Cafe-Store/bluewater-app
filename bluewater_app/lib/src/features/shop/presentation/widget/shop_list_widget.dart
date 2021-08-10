import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shop_fliter_list_widget.dart';
import '../controller/shop_controller.dart';

class ShopListWidget extends GetWidget<ShopController> {
  const ShopListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '골라먹는 맛집',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ),
        const SliverAppBar(
          pinned: true,
          title: ShopFilterListWidget(),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: Text('List Item $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}
