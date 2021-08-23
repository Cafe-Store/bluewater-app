import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/injector/injection.dart';
import '../../../core/logger/logger_utils.dart';
import '../../../core/usecase/usecase.dart';

mixin InfiniteScrollMixin<D, U extends UseCase<D, ScrollParam>> {
  late ScrollController _scroll;
  final RxBool _isScrolled = false.obs;
  final _datas = <D>[].obs;
  final _usecase = getIt<U>();

  String _failureMesage = '';
  bool _reachedMax = false;

  void _listener() {
    _isScrolled(_scroll.position.pixels > 0);

    if (_isBottom) {
      loadDatas();
    }
  }

  @nonVirtual
  void loadDatas() async {
    if (!_reachedMax) {
      final failureOrDatas = await _usecase.execute(scrollParam);

      failureOrDatas.fold((failure) => _failureMesage = failure.message,
          (loadedDatas) {
        if (loadedDatas.isEmpty && _failureMesage.isEmpty) {
          _reachedMax = true;
        } else {
          _datas.addAll(loadedDatas);
          Logger.logNoStack.i('shop data size : ${_datas.length}');
        }
      });
    }
  }

  bool get isScrolled => _isScrolled.value;

  bool get _isBottom {
    if (!_scroll.hasClients) return false;
    final maxScroll = _scroll.position.maxScrollExtent;
    final currentScroll = _scroll.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  set scroll(ScrollController scroll) {
    _scroll = scroll;
    _scroll.addListener(_listener);
  }

  bool get hasReachedMax => _reachedMax;

  String get failureMesage => _failureMesage;

  List<D> get datas => List.unmodifiable(_datas);

  ScrollController get scroll => _scroll;

  ScrollParam get scrollParam;
}

abstract class ScrollParam extends Equatable {}
