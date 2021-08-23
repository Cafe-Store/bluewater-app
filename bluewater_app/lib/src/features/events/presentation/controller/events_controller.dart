import 'package:get/get.dart';

import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../../domain/entity/event.dart';
import '../../domain/usecase/get_events_usecase.dart';

class EventsController extends GetxController
    with InfiniteScrollMixin<Event, GetEventsUsecase> {
  @override
  void onInit() {
    super.onInit();
    loadDatas();
  }

  @override
  ScrollParam get scrollParam => EventsScrollParam();
}
