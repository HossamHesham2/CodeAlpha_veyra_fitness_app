import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/features/home/domain/usecases/get_activities_use_case.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetActivitiesUseCase getActivitiesUseCase;

  HomeBloc({required this.getActivitiesUseCase}) : super(HomeState()) {
    on<GetActivitiesEvent>(_getActivities);
  }

  void _getActivities(GetActivitiesEvent event, Emitter<HomeState> emit) async {
    debugPrint('GET ACTIVITIES STARTED');emit(state.copyWith(activitiesRequest: AppRequests.loading));
    final result = await getActivitiesUseCase.call();
    result.fold(
      (failure) {
        debugPrint(
          'GET ACTIVITIES ERROR: ${failure.errorMessage}',
        );
        emit(state.copyWith(activitiesRequest: AppRequests.error, failure: failure));
      },
      (activities) {
        debugPrint(
          'ACTIVITIES COUNT: ${activities.length}',
        );
        for (final activity in activities) {
          debugPrint(
            'ACTIVITY: ${activity.exerciseType} | '
                'date: ${activity.date} | '
                'steps: ${activity.steps}',
          );
        }
        emit(state.copyWith(activitiesRequest: AppRequests.success, activities: activities));
      },
    );
  }
}
