import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Shop extends Equatable {
  final int id;
  final String name;
  final List<String> imageUrls;
  final double rank;

  @mustCallSuper
  const Shop({
    required this.id,
    required this.name,
    required this.imageUrls,
    required this.rank,
  });

  @override
  List<Object?> get props => [id];
}
