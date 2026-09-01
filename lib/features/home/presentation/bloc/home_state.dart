import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/errors/failures.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';

class HomeState {
  final AppRequests activitiesRequest;
  final List<ActivityModel> activities;
  final Failure? failure;

  HomeState({
    this.activitiesRequest = AppRequests.initial,
    this.activities = const [],
    this.failure,
  });
  HomeState copyWith({
    AppRequests? activitiesRequest,
    List<ActivityModel>? activities,
    Failure? failure,
  }) {
    return HomeState(
      activitiesRequest: activitiesRequest ?? this.activitiesRequest,
      activities: activities ?? this.activities,
      failure: failure ?? this.failure,
    );
  }
}
