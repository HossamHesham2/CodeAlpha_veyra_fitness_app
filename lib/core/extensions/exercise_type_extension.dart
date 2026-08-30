import 'package:flutter/material.dart';
import 'package:veyra/core/constants/app_enums.dart';

extension ExerciseTypeExtension on ExerciseType {
  String get displayName {
    switch (this) {
      case ExerciseType.running:
        return 'Running';
      case ExerciseType.walking:
        return 'Walking';
      case ExerciseType.cycling:
        return 'Cycling';
      case ExerciseType.swimming:
        return 'Swimming';
      case ExerciseType.jumpRope:
        return 'Jump Rope';
      case ExerciseType.hiking:
        return 'Hiking';
      case ExerciseType.strengthTraining:
        return 'Strength Training';
      case ExerciseType.weightlifting:
        return 'Weightlifting';
      case ExerciseType.bodybuilding:
        return 'Bodybuilding';
      case ExerciseType.crossFit:
        return 'CrossFit';
      case ExerciseType.yoga:
        return 'Yoga';
      case ExerciseType.pilates:
        return 'Pilates';
      case ExerciseType.stretching:
        return 'Stretching';
      case ExerciseType.mobility:
        return 'Mobility';
      case ExerciseType.football:
        return 'Football';
      case ExerciseType.basketball:
        return 'Basketball';
      case ExerciseType.tennis:
        return 'Tennis';
      case ExerciseType.boxing:
        return 'Boxing';
      case ExerciseType.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case ExerciseType.running:
        return Icons.directions_run;

      case ExerciseType.walking:
        return Icons.directions_walk;

      case ExerciseType.cycling:
        return Icons.directions_bike;

      case ExerciseType.swimming:
        return Icons.pool;

      case ExerciseType.jumpRope:
        return Icons.sports;

      case ExerciseType.hiking:
        return Icons.hiking;

      case ExerciseType.strengthTraining:
        return Icons.fitness_center;

      case ExerciseType.weightlifting:
        return Icons.fitness_center;

      case ExerciseType.bodybuilding:
        return Icons.accessibility_new;

      case ExerciseType.crossFit:
        return Icons.fitness_center;

      case ExerciseType.yoga:
        return Icons.self_improvement;

      case ExerciseType.pilates:
        return Icons.accessibility_new;

      case ExerciseType.stretching:
        return Icons.self_improvement;

      case ExerciseType.mobility:
        return Icons.accessibility_new;

      case ExerciseType.football:
        return Icons.sports_soccer;

      case ExerciseType.basketball:
        return Icons.sports_basketball;

      case ExerciseType.tennis:
        return Icons.sports_tennis;

      case ExerciseType.boxing:
        return Icons.sports_mma;

      case ExerciseType.other:
        return Icons.more_horiz;
    }
  }
}
