import 'package:flutter/material.dart';

import '../../domain/entity/shop_filter.dart';

class ShopFilterWidget extends StatelessWidget {
  final ShopFilter shopFilter;
  final TextStyle? textStyle;
  const ShopFilterWidget(this.shopFilter, this.textStyle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _createChildren(context),
      ),
    );
  }

  List<Widget> _createChildren(BuildContext context) {
    List<Widget> widgetList = [];
    if (shopFilter.leadingIcon != null) {
      widgetList.add(
        shopFilter.leadingIcon!,
      );
    }
    widgetList.add(
      Text(
        shopFilter.title,
        style: textStyle,
      ),
    );

    if (shopFilter.trailing != null) {
      widgetList.add(
        shopFilter.trailing!,
      );
    }

    return widgetList;
  }
}
