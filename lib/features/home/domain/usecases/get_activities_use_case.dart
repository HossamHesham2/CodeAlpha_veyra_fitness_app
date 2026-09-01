import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/home/domain/repositories/home_repository.dart';

class GetActivitiesUseCase {
  final HomeRepository homeRepository;

  GetActivitiesUseCase({required this.homeRepository});

  Future<Either<Failure, List<ActivityModel>>> call() async {
    return await homeRepository.getActivities();
  }
}
