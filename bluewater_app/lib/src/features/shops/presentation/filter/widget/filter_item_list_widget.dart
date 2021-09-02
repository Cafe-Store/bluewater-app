part of 'shops_filter_bottom_sheet.dart';

class _FilterItemList extends GetWidget<ShopsFilterController> {
  @override
  final String? tag;
  final ShopFilter shopFilter;

  _FilterItemList({required this.shopFilter, this.tag, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: ListView.separated(
        itemCount: shopFilter.filterItems.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            controller.put(shopFilter.name, shopFilter.filterItems[index]);
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: _createListItem(
                context,
                shopFilter.filterItems[index],
                controller.getSelectedItemName(shopFilter.name),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _createListItem(
      BuildContext context, ShopFilterItem item, String selectedItemName) {
    var widgetList = <Widget>[];

    if (selectedItemName == item.name) {
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
