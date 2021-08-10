part of 'shop_fliter_list_widget.dart';

class _ShopFilterWidget extends StatelessWidget {
  final Rx<ShopFilter> rxShopFilter;
  final TextStyle? textStyle;
  final Function tapCallback;

  late final ShopFilter _shopFilter;

  final Color selectedColor;
  final Color selectedBorderColor;
  final Color bgColor;
  final Color borderColor;

  _ShopFilterWidget(
      {Key? key,
      required this.rxShopFilter,
      required this.textStyle,
      required this.tapCallback,
      this.selectedBorderColor = Colors.blue,
      this.selectedColor = Colors.blue,
      this.bgColor = Colors.white,
      this.borderColor = Colors.black})
      : super(key: key) {
    _shopFilter = rxShopFilter.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: _isSelected() ? selectedBorderColor : borderColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          color: _isSelected() ? selectedColor : bgColor),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _createChildren(context),
        ),
        onTap: () => tapCallback(),
      ),
    );
  }

  List<Widget> _createChildren(BuildContext context) {
    List<Widget> widgetList = [];
    if (_shopFilter.leadingIcon != null) {
      widgetList.add(
        _shopFilter.leadingIcon!,
      );
    }
    widgetList.add(
      Text(
        _shopFilter.selectedItemName,
        style: textStyle,
      ),
    );

    if (_shopFilter.trailing != null) {
      widgetList.add(
        _shopFilter.trailing!,
      );
    }

    return widgetList;
  }

  bool _isSelected() {
    return _shopFilter.selectedItem != _shopFilter.filterItems[0];
  }
}
