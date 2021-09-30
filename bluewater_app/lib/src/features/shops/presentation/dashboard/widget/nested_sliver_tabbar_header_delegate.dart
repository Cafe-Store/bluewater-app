import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../shared/model/tab_item.dart';
import '../../../../../shared/ui/controller/tab_controll_mixin.dart';
import '../../../../categories/presentation/widget/category_item.dart';

class NestedSliverTabBarheaderDelegate<T extends TabItem>
    extends SliverPersistentHeaderDelegate {
  final double _minBodersideWidth = 2.0;
  final double _minFontSize = 12;
  final double expandedHeight;
  final List<T> items;
  late final double minHeight;
  final Color indicatorColor;
  final Color bgColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color imageBorderColor;
  final Color unselectedImageBorderColor;
  final TabControllMixin tabControllMixin;
  PreferredSize? bottom;
  late final double _bottomHeight;

  NestedSliverTabBarheaderDelegate({
    required this.expandedHeight,
    required this.items,
    required this.tabControllMixin,
    this.bottom,
    this.indicatorColor = Colors.lightBlue,
    this.bgColor = Colors.white,
    this.labelColor = Colors.lightBlue,
    this.imageBorderColor = Colors.lightBlue,
    this.unselectedLabelColor = Colors.black,
    this.unselectedImageBorderColor = Colors.transparent,
  }) : assert(expandedHeight >= 80 && expandedHeight <= 800) {
    minHeight = expandedHeight * 0.7;
    _bottomHeight = bottom == null ? 0.0 : bottom!.preferredSize.height;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: math.max(-shrinkOffset, -minHeight),
          left: 0,
          right: 0,
          child: Container(
            color: bgColor,
            height: expandedHeight + 10 + _bottomHeight,
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                children: createContent(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> createContent(BuildContext context) {
    var widgets = <Widget>[];

    widgets.add(createTabBar(context));

    if (bottom != null) {
      widgets.add(bottom!);
    }

    return widgets;
  }

  TabBar createTabBar(BuildContext context) {
    final bodersideWidth = math.max(_minBodersideWidth, minHeight * 0.05);

    return TabBar(
      isScrollable: true,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: bodersideWidth,
          color: indicatorColor,
        ),
      ),
      tabs: items.asMap().entries.map((entry) {
        return Tab(
          child: CategoryItem<T>(
            item: entry.value,
            imageSize: Size(minHeight * 0.8, minHeight * 0.8),
            borderColor: entry.key == tabControllMixin.tabIndex
                ? imageBorderColor
                : unselectedImageBorderColor,
            titleStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: math.max(_minFontSize, minHeight * 0.2),
                color: entry.key == tabControllMixin.tabIndex
                    ? labelColor
                    : unselectedLabelColor),
          ),
          height: expandedHeight,
        );
      }).toList(),
    );
  }

  @override
  double get maxExtent => expandedHeight + _bottomHeight;

  @override
  double get minExtent => minHeight * 0.45 + _bottomHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
