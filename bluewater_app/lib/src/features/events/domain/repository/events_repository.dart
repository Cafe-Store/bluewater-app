import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entity/event.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> findAll();
}
