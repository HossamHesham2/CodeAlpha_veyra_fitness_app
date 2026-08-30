import 'package:flutter_bloc/flutter_bloc.dart';

import 'status_event.dart';
import 'status_state.dart';

class StatusBloc
    extends Bloc<StatusEvent, StatusState> {

  StatusBloc()
      : super(StatusInitial()) {

    on<StatusEvent>(_onEvent);
  }

  void _onEvent(
    StatusEvent event,
    Emitter<StatusState> emit,
  ) {

  }
}
