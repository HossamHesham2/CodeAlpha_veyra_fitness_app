import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/activity_item.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/features/home/presentation/bloc/home_bloc.dart';
import 'package:veyra/features/home/presentation/bloc/home_state.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.activitiesRequest == AppRequests.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.activitiesRequest == AppRequests.error) {
          return Center(child: Text(state.failure?.errorMessage ?? 'Something went wrong'));
        }

        final activities = state.activities;

        if (activities.isEmpty) {
          return DScaffold(
            appBar: AppBar(
              title: const Text('History'),
              centerTitle: true,
              elevation: 0,
              scrolledUnderElevation: 0,
            ),
            body: Center(child: Text('No activities yet', style: text.titleMedium)),
          );
        }

        // Group activities by date
        final groupedActivities = <String, List<dynamic>>{};

        for (final activity in activities) {
          final date = activity.date ?? '';

          groupedActivities.putIfAbsent(date, () => []);

          groupedActivities[date]!.add(activity);
        }

        return DScaffold(
          body: Column(
            children: [
              SizedBox(height: AppSpacing.gap32),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go(RouteNames.home);
                    },
                    icon: Icon(Icons.arrow_back_ios,size: 18.sp,),
                  ),
                  SizedBox(width: AppSpacing.gapH4),

                  Text('History', style: text.titleLarge),
                ],
              ),
              SizedBox(height: AppSpacing.gap12),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: groupedActivities.length,
                  separatorBuilder: (_, __) => SizedBox(height: AppSpacing.gap20),
                  itemBuilder: (context, index) {
                    final date = groupedActivities.keys.elementAt(index);
                    final dayActivities = groupedActivities[date]!;

                    return _HistoryDaySection(date: date, activities: dayActivities, text: text);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryDaySection extends StatelessWidget {
  const _HistoryDaySection({required this.date, required this.activities, required this.text});

  final String date;
  final List<dynamic> activities;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _DateHeader(date: date, text: text),

        SizedBox(height: AppSpacing.gap12),

        ...activities.asMap().entries.map((entry) {
          final activity = entry.value;

          final activityStyle = _getActivityStyle(activity.exerciseType);

          return Padding(
            padding: EdgeInsets.only(
              bottom: entry.key == activities.length - 1 ? 0 : AppSpacing.gap12,
            ),
            child: ActivityItem(
              title: activity.exerciseType ?? 'Activity',
              duration: "${activity.duration ?? '0'} min",
              calories: "${activity.caloriesBurned ?? '0'} cal",
              time: activity.time ?? '',
              icon: activityStyle.icon,
              color: activityStyle.color,
            ),
          );
        }),
      ],
    );
  }
}

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date, required this.text});

  final String date;
  final TextTheme text;

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.tryParse(date);

    String formattedDate;

    if (parsedDate == null) {
      formattedDate = date.isEmpty ? 'Unknown Date' : date;
    } else {
      final now = DateTime.now();

      final isToday =
          parsedDate.year == now.year && parsedDate.month == now.month && parsedDate.day == now.day;

      final yesterday = now.subtract(const Duration(days: 1));

      final isYesterday =
          parsedDate.year == yesterday.year &&
          parsedDate.month == yesterday.month &&
          parsedDate.day == yesterday.day;

      if (isToday) {
        formattedDate = 'Today';
      } else if (isYesterday) {
        formattedDate = 'Yesterday';
      } else {
        formattedDate = DateFormat('EEEE, dd MMM yyyy').format(parsedDate);
      }
    }

    return Text(
      formattedDate,
      style: text.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _ActivityStyle {
  const _ActivityStyle({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}

_ActivityStyle _getActivityStyle(String? exerciseType) {
  final type = exerciseType?.toLowerCase().trim();

  switch (type) {
    case 'walking':
    case 'steps':
      return const _ActivityStyle(icon: Icons.directions_walk_rounded, color: AppColors.steps);

    case 'running':
    case 'run':
      return const _ActivityStyle(icon: Icons.directions_run_rounded, color: AppColors.workout);

    case 'cycling':
    case 'bike':
      return const _ActivityStyle(icon: Icons.directions_bike_rounded, color: AppColors.steps);

    case 'weight':
    case 'weight lifting':
    case 'weightlifting':
    case 'strength':
      return const _ActivityStyle(icon: Icons.fitness_center_rounded, color: AppColors.weight);

    case 'heart rate':
    case 'heart':
      return const _ActivityStyle(icon: Icons.favorite_rounded, color: AppColors.heartRate);

    case 'calories':
      return const _ActivityStyle(
        icon: Icons.local_fire_department_rounded,
        color: AppColors.calories,
      );

    default:
      return const _ActivityStyle(icon: Icons.fitness_center_rounded, color: AppColors.workout);
  }
}
