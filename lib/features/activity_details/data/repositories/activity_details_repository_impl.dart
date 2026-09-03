import 'package:dartz/dartz.dart';

import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/activity_details/data/datasources/remote/activity_details_remote_datasource.dart';

import '../../domain/repositories/activity_details_repository.dart';

class ActivityDetailsRepositoryImpl implements ActivityDetailsRepository {
  final ActivityDetailsRemoteDatasource activityDetailsRemoteDatasource;

  ActivityDetailsRepositoryImpl({required this.activityDetailsRemoteDatasource});

  @override
  Future<Either<Failure, void>> deleteActivity({required String id}) async {
    try {
      await activityDetailsRemoteDatasource.deleteActivity(id: id);
      return Right(null);
    } catch (e) {
      return Left(RemoteFailure(errorMessage: e.toString()));
    }
  }
}
