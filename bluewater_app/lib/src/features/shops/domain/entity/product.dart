import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/model/serialiser/group_serialiser.dart';
import '../../data/model/serialiser/photo_serialiser.dart';
import '../../data/model/serialiser/price_serialiser.dart';
import 'group.dart';
import 'photo.dart';
import 'price.dart';

class Product extends Equatable {
  final String id;
  final String name;

  @PhotoSerialiser()
  final Photo photo;

  @PriceSerialiser()
  final Price price;

  @GroupsSerialiser()
  @JsonKey(name: 'categories')
  final List<Group> groups;

  @mustCallSuper
  const Product({
    required this.id,
    required this.name,
    required this.photo,
    required this.price,
    required this.groups,
  });

  @override
  List<Object?> get props => [id];
}
