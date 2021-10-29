import 'package:get/get.dart';

import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../domain/entity/event.dart';
import '../../domain/usecase/get_events_usecase.dart';

class EventsService extends GetxService
    with InfiniteScrollMixin<Event, EventsScrollParam> {
  String? usecaeClassName;
  final currentIdex = 1.obs;

  EventsService({this.usecaeClassName});

  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  EventsScrollParam get scrollParam => EventsScrollParam();

  @override
  String? get usecaeName => usecaeClassName;
}
