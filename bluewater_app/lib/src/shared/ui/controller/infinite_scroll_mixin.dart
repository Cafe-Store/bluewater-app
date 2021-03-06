import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/injector/injection.dart';
import '../../../core/logger/logger_utils.dart';
import '../../../core/usecase/usecase.dart';

///[D]는 도메인 타입을 입력을 나타냄.
mixin InfiniteScrollMixin<D, P extends ScrollParam> {
  ScrollController? _scroll;
  final RxBool _isScrolled = false.obs;
  final _datas = <D>[].obs;
  final RxDouble preScrollOffset = 0.0.obs;

  @protected
  bool isForcused = true;

  String _failureMesage = '';
  bool _reachedMax = false;
  bool _isLoading = false;

  void _listener() {
    _isScrolled(_scroll!.offset > 0);

    if (isForcused) {
      preScrollOffset(_scroll?.offset);
    }

    if (_isBottom && isForcused) {
      loadDatas();
    }
  }

  @nonVirtual
  void loadDatas() async {
    var _usecase = getIt<UseCase<List<D>, P>>(instanceName: usecaeName);

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
              '''${usecaeName != null ? usecaeName : ''} ${toString()}:$hashCode ${D.toString()} page:${scrollParam.page}''');

          _datas.addAll(loadedDatas);
          scrollParam.page++;
        }
      });
    }
  }

  set setFocus(bool focus) => isForcused = focus;

  bool get isScrolled => _isScrolled.value;

  bool get _isBottom {
    if (!_scroll!.hasClients) return false;
    final maxScroll = _scroll!.position.maxScrollExtent;
    final currentScroll = _scroll!.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  set scroll(ScrollController? scroll) {
    _scroll = scroll;
    if (_scroll != null) {
      _scroll!.addListener(_listener);
    }
  }

  bool get hasReachedMax => _reachedMax;

  String get failureMesage => _failureMesage;

  List<D> get datas => List.unmodifiable(_datas);

  ScrollController? get scroll => _scroll;

  P get scrollParam;

  String? get usecaeName;

  void reloadDatas() {
    _datas.clear();
    loadDatas();
  }
}

abstract class ScrollParam {
  set page(int page);

  int get page;
}
