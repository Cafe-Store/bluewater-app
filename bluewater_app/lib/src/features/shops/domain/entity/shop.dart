import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/model/serialiser/photos_serialiser.dart';
import '../../data/model/serialiser/rank_serialiser.dart';
import 'photo.dart';
import 'rank.dart';

class Shop extends Equatable {
  final String id;
  final String name;

  @PhotoListSerialiser()
  @JsonKey(name: 'photo')
  final List<Photo> photos;

  @RankSerialiser()
  final Rank rank;

  @mustCallSuper
  const Shop({
    required this.id,
    required this.name,
    required this.photos,
    required this.rank,
  });

  factory Shop.empty() =>
      Shop(id: '', name: '', photos: <Photo>[], rank: Rank(0.0, 0));

  @override
  List<Object?> get props => [id];
}
