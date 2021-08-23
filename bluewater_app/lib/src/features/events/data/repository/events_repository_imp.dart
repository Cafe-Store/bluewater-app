import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entity/event.dart';
import '../../domain/repository/events_repository.dart';
import '../datasource/events_remote_datasource.dart';

@LazySingleton(as: EventsRepository)
class EventsRepositoryImp implements EventsRepository {
  final EventsRemoteDataSource remoteDataSource;

  final NetworkInfo networkInfo;

  EventsRepositoryImp(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Event>>> findAll() async {
    var isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return Right(await remoteDataSource.findAll());
      } on Exception {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
