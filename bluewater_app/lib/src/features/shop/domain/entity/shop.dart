import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/serialiser/rank_serialiser.dart';
import '../../data/model/serialiser/photo_serialiser.dart';
import 'photo.dart';
import 'rank.dart';

class Shop extends Equatable {
  final String id;
  final String name;

  @PhotoSerialiser()
  final Photo photo;

  @RankSerialiser()
  final Rank rank;

  @mustCallSuper
  const Shop({
    required this.id,
    required this.name,
    required this.photo,
    required this.rank,
  });

  @override
  List<Object?> get props => [id];
}
