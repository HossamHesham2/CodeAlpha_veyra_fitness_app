import 'package:dartz/dartz.dart';

import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/core/exceptions/remote_exceptions.dart';

import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/home/data/datasources/remote/home_remote_datasource.dart';

import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImpl({required this.homeRemoteDatasource});

  @override
  Future<Either<Failure, List<ActivityModel>>> getActivities() async {
    try {
      final activities = await homeRemoteDatasource.getActivities();

      return Right(activities);
    } on RemoteException catch (e) {
      return Left(RemoteFailure(errorMessage: e.message));
    }
  }
}
