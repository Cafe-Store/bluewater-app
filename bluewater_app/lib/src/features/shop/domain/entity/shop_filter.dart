import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ShopFilter extends Equatable {
  final WidgetType widgetType;
  final String name;
  final Icon? leadingIcon;
  final List<ShopFilterItem> filterItems;
  final Icon? trailing;

  ShopFilterItem _selectedItem;

  ShopFilter({
    required this.widgetType,
    required this.name,
    required this.filterItems,
    this.leadingIcon,
    this.trailing,
  })  : _selectedItem = filterItems[0],
        assert(filterItems.length > 1);

  set selectedItem(ShopFilterItem item) {
    _selectedItem = filterItems.firstWhere((element) => element == item);
  }

  ShopFilterItem get selectedItem {
    return _selectedItem;
  }

  String get selectedItemName {
    return _selectedItem.name.isEmpty ? name : _selectedItem.name;
  }

  bool hasFilterItem() => filterItems[0] != ShopFilterItem.defaultItem;

  void onDefaultTap() {
    _selectedItem = _selectedItem == ShopFilterItem.defaultItem
        ? filterItems[1]
        : filterItems[0];
  }

  @override
  List<Object?> get props => [name, filterItems, _selectedItem];
}

class ShopFilterItem extends Equatable {
  static const defaultItem = ShopFilterItem('');

  final String name;

  const ShopFilterItem(this.name);

  @override
  List<Object?> get props => [name];
}

enum WidgetType { none, list }
