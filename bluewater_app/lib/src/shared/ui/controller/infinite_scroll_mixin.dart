import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/injector/injection.dart';
import '../../../core/logger/logger_utils.dart';
import '../../../core/usecase/usecase.dart';

mixin InfiniteScrollMixin<D, P extends ScrollParam, U extends UseCase<D, P>> {
  late ScrollController _scroll = ScrollController();
  final RxBool _isScrolled = false.obs;
  final _datas = <D>[].obs;
  final _usecase = getIt<U>();
  final RxDouble preScrollOffset = 0.0.obs;

  @protected
  bool isForcused = true;

  String _failureMesage = '';
  bool _reachedMax = false;
  bool _isLoading = false;

  void _listener() {
    _isScrolled(_scroll.offset > 0);

    if (isForcused) {
      preScrollOffset(_scroll.offset);
    }

    if (_isBottom && isForcused) {
      loadDatas();
    }
  }

  @nonVirtual
  void loadDatas() async {
    if (!_reachedMax && !_isLoading) {
      _isLoading = true;
      final failureOrDatas = await _usecase.execute(scrollParam);
      _isLoading = false;

      failureOrDatas.fold((failure) => _failureMesage = failure.message,
          (loadedDatas) {
        if (loadedDatas.isEmpty && _failureMesage.isEmpty) {
          _reachedMax = true;
          Logger.logNoStack.i('_reachedMax : $_reachedMax');
        } else {
          Logger.logNoStack.i(
              '''${toString()}:$hashCode ${D.toString()} page:${scrollParam.page}''');

          _datas.addAll(loadedDatas);
          scrollParam.page++;
        }
      });
    }
  }

  @nonVirtual
  set setFocus(bool focus) => isForcused = focus;

  @nonVirtual
  bool get isScrolled => _isScrolled.value;

  bool get _isBottom {
    if (!_scroll.hasClients) return false;
    final maxScroll = _scroll.position.maxScrollExtent;
    final currentScroll = _scroll.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @nonVirtual
  set scroll(ScrollController scroll) {
    _scroll = scroll;
    _scroll.addListener(_listener);
  }

  @nonVirtual
  bool get hasReachedMax => _reachedMax;
  @nonVirtual
  String get failureMesage => _failureMesage;
  @nonVirtual
  List<D> get datas => List.unmodifiable(_datas);
  @nonVirtual
  ScrollController get scroll => _scroll;

  P get scrollParam;

  @nonVirtual
  void reloadDatas() {
    _datas.clear();
    loadDatas();
  }
}

abstract class ScrollParam {
  set page(int page);

  int get page;
}
