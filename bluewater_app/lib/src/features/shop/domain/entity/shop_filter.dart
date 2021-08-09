import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//TODO 모델 손봐야 함
class ShopFilter extends Equatable {
  String title;
  final Icon? leadingIcon;
  final List<String>? category;
  final Icon? trailing;

  ShopFilter(this.title, {this.category, this.leadingIcon, this.trailing});

  @override
  List<Object?> get props => [];
}
