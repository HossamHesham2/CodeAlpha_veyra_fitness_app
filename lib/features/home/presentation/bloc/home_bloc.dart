import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc
    extends Bloc<HomeEvent, HomeState> {

  HomeBloc()
      : super(HomeInitial()) {

    on<HomeEvent>(_onEvent);
  }

  void _onEvent(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) {

  }
}
