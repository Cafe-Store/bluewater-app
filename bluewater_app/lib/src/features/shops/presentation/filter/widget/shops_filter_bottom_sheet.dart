import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/shop_filter.dart';
import '../controller/shops_filter_controller.dart';

part 'filter_item_list_widget.dart';

class ShopsFilterBottomSheet {
  ShopsFilterBottomSheet._();

  static void show(
      BuildContext context, ShopFilter shopFilter, String? contollerTag) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        var bottomSheetheight = MediaQuery.of(context).size.height / 2.5;

        return Container(
          height: bottomSheetheight,
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: Text(
                  shopFilter.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close))
                ],
                bottom: const PreferredSize(
                  child: Divider(),
                  preferredSize: Size.fromHeight(10.0),
                ),
              ),
              _createContent(shopFilter, contollerTag),
            ],
          ),
        );
      },
    );
  }

  static Widget _createContent(ShopFilter shopFilter, String? tag) {
    Widget content;

    switch (shopFilter.filterType) {
      case ShopFilterType.list:
        {
          content = _FilterItemList(
            shopFilter: shopFilter,
            tag: tag,
          );
        }
        break;
      default:
        {
          content = Container();
        }
        break;
    }

    return content;
  }
}
