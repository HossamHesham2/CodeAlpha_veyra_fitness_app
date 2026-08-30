import 'package:equatable/equatable.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';

sealed class ActivityEvent extends Equatable {}

class AddActivityEvent extends ActivityEvent {
  final ActivityModel activityModel;

  AddActivityEvent({required this.activityModel});

  @override
  List<Object?> get props => [activityModel];
}
