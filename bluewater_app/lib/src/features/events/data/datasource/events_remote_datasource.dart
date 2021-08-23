import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../model/event_model.dart';

part 'events_remote_datasource.g.dart';

@injectable
@RestApi()
abstract class EventsRemoteDataSource {
  @factoryMethod
  factory EventsRemoteDataSource(Dio dio) = _EventsRemoteDataSource;

  @GET('/events')
  Future<List<EventModel>> findAll();
}
