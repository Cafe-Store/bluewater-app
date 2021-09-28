import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin TabControllMixin {
  @protected
  final RxInt currentIndex = 0.obs;
  TabController? _tabController;

  set tabController(TabController? contoller) {
    if (contoller != null) {
      _tabController = contoller;
      _tabController!.addListener(_handleTabControllerTick);
    }
  }

  void _handleTabControllerTick() {
    if (_tabController!.index != currentIndex.value) {
      currentIndex(_tabController!.index);
      changedTab();
    }
  }

  @protected
  void changedTab();

  int get tabIndex => currentIndex.value;
}
