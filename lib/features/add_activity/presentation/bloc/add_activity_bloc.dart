import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/features/add_activity/domain/usecases/add_activity_use_case.dart';

import 'add_activity_event.dart';
import 'add_activity_state.dart';

class AddActivityBloc extends Bloc<ActivityEvent, AddActivityState> {
  final AddActivityUseCase addActivityUseCase;

  AddActivityBloc({required this.addActivityUseCase}) : super(AddActivityState.initial()) {
    on<ActivityEvent>(_onEvent);
  }

  void _onEvent(ActivityEvent event, Emitter<AddActivityState> emit) async {
    switch (event) {
      case AddActivityEvent():
        await _addActivityEvent(event, emit);
    }
  }

  Future<void> _addActivityEvent(AddActivityEvent event, Emitter<AddActivityState> emit) async {
    emit(state.copyWith(addActivityRequest: AppRequests.loading));
    final res = await addActivityUseCase.call(activityModel: event.activityModel);
    res.fold(
      (failure) {
        emit(state.copyWith(addActivityRequest: AppRequests.error, addActivityFailure: failure));
      },
      (_) {
        emit(state.copyWith(addActivityRequest: AppRequests.success));
      },
    );
  }
}
