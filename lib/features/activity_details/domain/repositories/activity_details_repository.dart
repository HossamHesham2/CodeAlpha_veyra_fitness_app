import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';

abstract class ActivityDetailsRepository {
  Future<Either<Failure, void>> deleteActivity({required String id});
}
