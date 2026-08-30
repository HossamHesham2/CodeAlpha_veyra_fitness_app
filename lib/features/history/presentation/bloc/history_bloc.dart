import 'package:flutter_bloc/flutter_bloc.dart';

import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc
    extends Bloc<HistoryEvent, HistoryState> {

  HistoryBloc()
      : super(HistoryInitial()) {

    on<HistoryEvent>(_onEvent);
  }

  void _onEvent(
    HistoryEvent event,
    Emitter<HistoryState> emit,
  ) {

  }
}
