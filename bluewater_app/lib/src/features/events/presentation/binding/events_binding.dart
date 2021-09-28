import 'package:get/get.dart';

import '../service/events_service.dart';

class EventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventsService>(() => EventsService());
  }
}
