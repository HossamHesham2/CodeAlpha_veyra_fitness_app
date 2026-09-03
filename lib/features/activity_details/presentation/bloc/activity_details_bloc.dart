import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/features/activity_details/domain/usecases/delete_activity_use_case.dart';

import 'activity_details_event.dart';
import 'activity_details_state.dart';

class ActivityDetailsBloc extends Bloc<ActivityDetailsEvent, ActivityDetailsState> {
  final DeleteActivityUseCase deleteActivityUseCase;

  ActivityDetailsBloc({required this.deleteActivityUseCase})
    : super(ActivityDetailsState.initial()) {
    on<ActivityDetailsEvent>(_onEvent);
  }

  void _onEvent(ActivityDetailsEvent event, Emitter<ActivityDetailsState> emit) async {
    switch (event) {
      case DeleteActivityEvent():
        await _onDeleteActivityEvent(event, emit);
    }
  }

  Future<void> _onDeleteActivityEvent(
    DeleteActivityEvent event,
    Emitter<ActivityDetailsState> emit,
  ) async {
    emit(state.copyWith(deleteActivityRequest: AppRequests.loading));
    final result = await deleteActivityUseCase.call(id: event.id);
    result.fold(
      (l) {
        emit(state.copyWith(deleteActivityRequest: AppRequests.error, deleteActivityFailure: l));
      },
      (r) {
        emit(state.copyWith(deleteActivityRequest: AppRequests.success));
      },
    );
  }
}
