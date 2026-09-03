import 'package:equatable/equatable.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/errors/failures.dart';

class ActivityDetailsState extends Equatable {
  final AppRequests? deleteActivityRequest;

  final Failure? deleteActivityFailure;

  ActivityDetailsState({required this.deleteActivityRequest, required this.deleteActivityFailure});

  const ActivityDetailsState.initial() : deleteActivityRequest = null, deleteActivityFailure = null;

  ActivityDetailsState copyWith({
    AppRequests? deleteActivityRequest,
    Failure? deleteActivityFailure,
  }) {
    return ActivityDetailsState(
      deleteActivityRequest: deleteActivityRequest ?? this.deleteActivityRequest,
      deleteActivityFailure: deleteActivityFailure ?? this.deleteActivityFailure,
    );
  }

  @override
  List<Object?> get props => [deleteActivityRequest, deleteActivityFailure];
}
