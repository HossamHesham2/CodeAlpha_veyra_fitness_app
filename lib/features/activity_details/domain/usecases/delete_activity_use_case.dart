import 'package:dartz/dartz.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/activity_details/domain/repositories/activity_details_repository.dart';

class DeleteActivityUseCase {
  final ActivityDetailsRepository activityDetailsRepository;

  DeleteActivityUseCase({required this.activityDetailsRepository});

  Future<Either<Failure, void>> call({required String id}) async {
    return await activityDetailsRepository.deleteActivity(id: id);
  }
}
