import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ShopFilter extends Equatable {
  final ShopFilterType filterType;
  final String name;
  final List<ShopFilterItem> filterItems;
  final Icon? leadingIcon;
  final Icon? trailingIcon;

  ShopFilter({
    required this.filterType,
    required this.name,
    required this.filterItems,
    this.leadingIcon,
    this.trailingIcon,
  }) : assert(filterItems.isNotEmpty);

  @override
  List<Object?> get props => [name];
}

class ShopFilterItem extends Equatable {
  final String name;

  const ShopFilterItem(this.name);

  @override
  List<Object?> get props => [name];
}

enum ShopFilterType { none, list }
