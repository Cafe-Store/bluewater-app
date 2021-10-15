import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/ui/controller/infinite_scroll_mixin.dart';
import '../entity/event.dart';
import '../repository/events_repository.dart';

@LazySingleton(as: UseCase)
class GetEventsUsecase extends UseCase<Event, EventsScrollParam> {
  final EventsRepository eventsRepository;

  GetEventsUsecase(this.eventsRepository);

  @override
  Future<Either<Failure, List<Event>>> execute(EventsScrollParam params) {
    return eventsRepository.findAll();
  }
}

class EventsScrollParam extends ScrollParam {
  @override
  int page = 0;
}
