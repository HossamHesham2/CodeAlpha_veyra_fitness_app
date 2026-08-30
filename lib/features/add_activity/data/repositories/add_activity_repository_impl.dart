import 'package:dartz/dartz.dart';

import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/add_activity/data/datasources/remote/add_activity_remote_datasource.dart';

import 'package:veyra/features/add_activity/data/models/activity_model.dart';

import '../../domain/repositories/add_activity_repository.dart';

class AddActivityRepositoryImpl implements AddActivityRepository {
  final AddActivityRemoteDatasource activityRemoteDatasource;

  AddActivityRepositoryImpl({required this.activityRemoteDatasource});

  @override
  Future<Either<Failure, void>> addActivity({required ActivityModel activityModel}) async {
    try {
      await activityRemoteDatasource.addActivity(activityModel: activityModel);
      return Right(null);
    } catch (e) {
      return Left(RemoteFailure(errorMessage: e.toString()));
    }
  }
}
