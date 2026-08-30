import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/add_activity/domain/repositories/add_activity_repository.dart';

class AddActivityUseCase {
  final AddActivityRepository addActivityRepository;

  AddActivityUseCase({required this.addActivityRepository});

  Future<Either<Failure, void>> call({required ActivityModel activityModel}) async {
    return await addActivityRepository.addActivity(activityModel: activityModel);
  }
}
