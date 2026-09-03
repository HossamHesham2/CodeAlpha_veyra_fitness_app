import 'package:flutter/material.dart';
import 'package:veyra/core/theme/app_colors.dart';

class ActivityStyleModel {
  const ActivityStyleModel({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  static ActivityStyleModel getActivityStyle(String? exerciseType) {
    final type = exerciseType?.toLowerCase().trim();

    switch (type) {
      case 'walking':
      case 'steps':
        return const ActivityStyleModel(
          icon: Icons.directions_walk_rounded,
          color: AppColors.steps,
        );

      case 'running':
      case 'run':
        return const ActivityStyleModel(
          icon: Icons.directions_run_rounded,
          color: AppColors.workout,
        );

      case 'cycling':
      case 'bike':
        return const ActivityStyleModel(
          icon: Icons.directions_bike_rounded,
          color: AppColors.steps,
        );

      case 'weight':
      case 'weight lifting':
      case 'weightlifting':
      case 'strength':
        return const ActivityStyleModel(
          icon: Icons.fitness_center_rounded,
          color: AppColors.weight,
        );

      case 'heart rate':
      case 'heart':
        return const ActivityStyleModel(icon: Icons.favorite_rounded, color: AppColors.heartRate);

      case 'calories':
        return const ActivityStyleModel(
          icon: Icons.local_fire_department_rounded,
          color: AppColors.calories,
        );

      default:
        return const ActivityStyleModel(
          icon: Icons.fitness_center_rounded,
          color: AppColors.workout,
        );
    }
  }
}
