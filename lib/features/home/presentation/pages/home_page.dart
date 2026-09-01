import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/di/injection.dart';
import 'package:veyra/core/extensions/exercise_type_extension.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/features/home/presentation/bloc/home_bloc.dart';
import 'package:veyra/features/home/presentation/bloc/home_event.dart';
import 'package:veyra/features/home/presentation/bloc/home_state.dart';
import 'package:veyra/features/home/presentation/widgets/fitness_progress_widget.dart';
import 'package:veyra/features/home/presentation/widgets/home_header.dart';
import 'package:veyra/features/home/presentation/widgets/recent_activity_item.dart';
import 'package:veyra/features/home/presentation/widgets/summary_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final activities = state.activities;
        final today = DateFormat('dd MMM, yyyy').format(DateTime.now());

        final todayActivities = activities.where((activity) => activity.date == today).toList();
        final todaySteps = todayActivities.fold<int>(
          0,
          (sum, activity) => sum + (int.tryParse(activity.steps ?? '0') ?? 0),
        );
        final todayCalories = todayActivities.fold<int>(
          0,
          (sum, activity) => sum + (int.tryParse(activity.caloriesBurned ?? '0') ?? 0),
        );
        final todayWorkoutMinutes = todayActivities.fold<int>(
          0,
          (sum, activity) => sum + (int.tryParse(activity.duration ?? '0') ?? 0),
        );
        final stepsGoal = 10000;
        final workoutGoal  = 60;

        final stepsProgress = (todaySteps / stepsGoal).clamp(0.0, 1.0);
        final workoutProgress =
        (todayWorkoutMinutes / workoutGoal).clamp(0.0, 1.0);
        return DScaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.gap24),
                HomeHeader(),
                SizedBox(height: AppSpacing.gap12),
                FitnessProgressWidget(
                  stepsProgress: stepsProgress,
                  workoutProgress: workoutProgress,
                  steps: todaySteps,
                  stepsGoal: stepsGoal,
                  calories: todayCalories,
                  workoutMinutes: todayWorkoutMinutes,
                ),
                SizedBox(height: AppSpacing.gap12),
                Text("Today's Summary", style: text.titleMedium),
                SizedBox(height: AppSpacing.gap12),
                Row(
                  children: [
                    Expanded(
                      child: SummaryItem(
                        textColor: AppColors.steps,
                        title: "Steps",
                        textNumber: todaySteps.toString(),
                        subtitle: "steps",
                      ),
                    ),
                    SizedBox(width: AppSpacing.gapH12),
                    Expanded(
                      child: SummaryItem(
                        textColor: AppColors.calories,
                        title: "Calories",
                        textNumber: todayCalories.toString(),
                        subtitle: "cal",
                      ),
                    ),
                    SizedBox(width: AppSpacing.gapH12),
                    Expanded(
                      child: SummaryItem(
                        textColor: AppColors.workout,
                        title: "Workout Time",
                        textNumber: todayWorkoutMinutes.toString(),
                        subtitle: "min",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.gap12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Recent Activities", style: text.titleMedium),
                    TextButton(
                      onPressed: () {},
                      child: Text("View All", style: text.labelMedium?.copyWith(color: cs.primary)),
                    ),
                  ],
                ),
                if (state.activitiesRequest == AppRequests.loading) ...[
                  SizedBox(height: AppSpacing.gap48),
                  Center(child: CircularProgressIndicator()),
                ] else if (activities.isEmpty) ...[
                  SizedBox(height: AppSpacing.gap48),

                  Center(child: Text("No activities added yet")),
                ] else if (state.activitiesRequest == AppRequests.error) ...[
                  Center(child: Text(state.failure?.errorMessage ?? 'Something went wrong')),
                ] else
                  ...activities.take(5).map((activity) {
                    IconData iconData() {
                      switch (activity.exerciseType) {
                        case 'running':
                          return Icons.directions_run;

                        case 'walking':
                          return Icons.directions_walk;

                        case 'cycling':
                          return Icons.directions_bike;

                        case 'swimming':
                          return Icons.pool;

                        case 'jumpRope':
                          return Icons.sports;

                        case 'hiking':
                          return Icons.hiking;

                        case 'strengthTraining':
                          return Icons.fitness_center;

                        case 'weightlifting':
                          return Icons.fitness_center;

                        case 'bodybuilding':
                          return Icons.accessibility_new;

                        case 'crossFit':
                          return Icons.fitness_center;

                        case 'yoga':
                          return Icons.self_improvement;

                        case 'pilates':
                          return Icons.accessibility_new;

                        case 'stretching':
                          return Icons.self_improvement;

                        case 'mobility':
                          return Icons.accessibility_new;

                        case 'football':
                          return Icons.sports_soccer;

                        case 'basketball':
                          return Icons.sports_basketball;

                        case 'tennis':
                          return Icons.sports_tennis;

                        case 'boxing':
                          return Icons.sports_mma;

                        case 'other':
                          return Icons.more_horiz;
                        default:
                          return Icons.more_horiz;
                      }
                    }

                    return RecentActivityItem(
                      color: AppColors.steps,
                      icon: iconData(),
                      title: capitalize(activity.exerciseType ?? ""),
                      duration: '${activity.duration ?? '0'} min',

                      time: activity.time ?? '',
                      calories: '${activity.caloriesBurned ?? '0'} cal',
                    );
                  }).toList(),

                SizedBox(height: AppSpacing.gap48),
              ],
            ),
          ),
        );
      },
    );
  }
}
