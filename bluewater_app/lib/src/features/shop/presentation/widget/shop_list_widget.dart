import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shop_contoller.dart';
import 'shop_fliter_widget.dart';

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
        SliverAppBar(
          pinned: true,
          title: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 30, maxWidth: MediaQuery.of(context).size.width),
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                endIndent: 20,
              ),
              itemCount: controller.shopFilters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var shopFilter = controller.shopFilters[index];
                return ShopFilterWidget(
                    shopFilter, Theme.of(context).textTheme.bodyText1);
              },
            ),
          ),
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
