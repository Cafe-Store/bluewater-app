import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/shop_filter.dart';

class ShopFilterBottomSheet {
  ShopFilterBottomSheet._();

  static void show(BuildContext context, Rx<ShopFilter> rxShopFilter) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        double bottomSheetheight = MediaQuery.of(context).size.height / 2.5;

        return Container(
          height: bottomSheetheight,
          color: Colors.white,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: Text(
                  rxShopFilter.value.name,
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
              _createContent(rxShopFilter),
            ],
          ),
        );
      },
    );
  }

  static Widget _createContent(Rx<ShopFilter> rxShopFilter) {
    Widget content;
    ShopFilter _shopFilter = rxShopFilter.value;

    switch (rxShopFilter.value.widgetType) {
      case WidgetType.list:
        {
          content = _createListContent(_shopFilter, rxShopFilter);
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

  static SliverFillRemaining _createListContent(
      ShopFilter _shopFilter, Rx<ShopFilter> rxShopFilter) {
    return SliverFillRemaining(
      child: ListView.separated(
        itemCount: _shopFilter.filterItems.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            _shopFilter.selectedItem = _shopFilter.filterItems[index];
            rxShopFilter.refresh();
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: _createListItem(
                context,
                _shopFilter.filterItems[index],
                _shopFilter.selectedItem,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> _createListItem(
      BuildContext context, ShopFilterItem item, ShopFilterItem selectedItem) {
    List<Widget> widgetList = [];

    if (selectedItem == item) {
      widgetList.add(
        const Align(
          alignment: Alignment(-0.4, -0.0),
          child: Icon(
            Icons.check,
            color: Colors.blue,
            size: 18,
          ),
        ),
      );
    }

    widgetList.add(
      Align(
        alignment: Alignment.center,
        child: Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 3),
          child: Text(
            item.name,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );

    return widgetList;
  }
}
