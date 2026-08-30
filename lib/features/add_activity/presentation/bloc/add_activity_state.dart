import 'package:equatable/equatable.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/errors/failures.dart';

class AddActivityState extends Equatable {
  final AppRequests? addActivityRequest;

  // final AppEnums? signUpRequest;
  // final Failure? signUpFailure;
  final Failure? addActivityFailure;

  AddActivityState({required this.addActivityRequest, required this.addActivityFailure});

  const AddActivityState.initial() : addActivityRequest = null, addActivityFailure = null;

  AddActivityState copyWith({AppRequests? addActivityRequest, Failure? addActivityFailure}) {
    return AddActivityState(
      addActivityRequest: addActivityRequest ?? this.addActivityRequest,
      addActivityFailure: addActivityFailure ?? this.addActivityFailure,
    );
  }

  @override
  List<Object?> get props => [addActivityRequest, addActivityFailure];
}
