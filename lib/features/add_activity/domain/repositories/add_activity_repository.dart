import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';

abstract class AddActivityRepository {
  Future<Either<Failure, void>> addActivity({required ActivityModel activityModel});
}
