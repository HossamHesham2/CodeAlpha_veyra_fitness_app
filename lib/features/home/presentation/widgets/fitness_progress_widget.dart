import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class FitnessProgressWidget extends StatelessWidget {
  const FitnessProgressWidget({
    super.key,
    this.stepsProgress = 0.74,
    this.workoutProgress = 0.74,
    this.steps = 7460,
    this.stepsGoal = 10000,
    this.calories = 920,
    this.workoutMinutes = 45,
  });

  final double stepsProgress;
  final double workoutProgress;
  final int steps;
  final int stepsGoal;
  final int calories;
  final int workoutMinutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: _ProgressCircle(
            stepsProgress: stepsProgress,
            workoutProgress: workoutProgress,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          flex: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FitnessCard(
                icon: Icons.directions_walk_rounded,
                title: 'Steps',
                value: '$steps',
                subtitle: '/$stepsGoal',
                iconColor: AppColors.steps,
                valueColor: AppColors.steps,
              ),

              SizedBox(height: AppSpacing.gap12),

              _FitnessCard(
                icon: Icons.local_fire_department_rounded,
                title: 'Calories',
                value: '$calories',
                subtitle: 'kcal',
                iconColor: AppColors.calories,
                valueColor: AppColors.calories,
              ),

              SizedBox(height: AppSpacing.gap12),

              _FitnessCard(
                icon: Icons.fitness_center_rounded,
                title: 'Workout',
                value: '$workoutMinutes',
                subtitle: 'min',
                iconColor: AppColors.workout,
                valueColor: AppColors.workout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class _ProgressCircle extends StatelessWidget {
  const _ProgressCircle({
    required this.stepsProgress,
    required this.workoutProgress,
  });

  final double stepsProgress;
  final double workoutProgress;

  @override
  Widget build(BuildContext context) {
    final overallProgress =
    ((stepsProgress + workoutProgress) / 2).clamp(0.0, 1.0);

    final percentage = (overallProgress * 100).round();

    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size.square(280),
            painter: _ProgressPainter(
              stepsProgress: stepsProgress,
              workoutProgress: workoutProgress,
              isDark: isDark,
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Daily Goal',
                style: text.labelLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: AppSpacing.gap4),

              Text(
                '$percentage%',
                style: text.headlineLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: AppSpacing.gap4),

              Text(
                'Great job!',
                style: text.labelMedium?.copyWith(
                  color: cs.onSurface.withValues(alpha: .7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  const _ProgressPainter({
    required this.stepsProgress,
    required this.workoutProgress,
    required this.isDark,
  });

  final double stepsProgress;
  final double workoutProgress;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;
    final rect = Rect.fromCircle(center: center, radius: radius);

    const strokeWidth = 12.0;

    // Background track
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = isDark ? AppColors.darkNavy : AppColors.lightNavy;

    canvas.drawCircle(center, radius, trackPaint);

    // Prevent invalid values
    final steps = stepsProgress.clamp(0.0, 1.0);
    final workout = workoutProgress.clamp(0.0, 1.0);

    // Gap angle between the two segments (used twice: once after each segment)
    const gap = 0.02; // fraction of full circle per gap
    final gapAngle = math.pi * 2 * gap;

    // Each metric gets HALF the circle as its max allocation (minus the two gaps)
    final segmentMax = (math.pi * 2 - gapAngle * 2) / 2;

    // =========================
    // Steps — fills its own half based on progress
    // =========================
    final stepsPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.steps;

    final stepsStart = -math.pi / 2;
    final stepsSweep = segmentMax * steps;

    canvas.drawArc(rect, stepsStart, stepsSweep, false, stepsPaint);

    // =========================
    // Workout — starts after steps' full allocation + gap, fills its own half
    // =========================
    final workoutPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.workout;

    final workoutStart = stepsStart + segmentMax + gapAngle;
    final workoutSweep = segmentMax * workout;

    canvas.drawArc(rect, workoutStart, workoutSweep, false, workoutPaint);
  }

  @override
  bool shouldRepaint(
      covariant _ProgressPainter oldDelegate,
      ) {
    return oldDelegate.stepsProgress != stepsProgress ||
        oldDelegate.workoutProgress != workoutProgress ||
        oldDelegate.isDark != isDark;
  }
}
class _FitnessCard extends StatelessWidget {
  const _FitnessCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.iconColor,
    required this.valueColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color iconColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.primaryFixed,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: .03)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),

          SizedBox(width: AppSpacing.gapH12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: text.labelLarge?.copyWith(
                    color: iconColor.withValues(alpha: .8),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: AppSpacing.gap4),

                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: text.labelMedium?.copyWith(
                          color: valueColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: ' $subtitle',
                        style: text.labelSmall?.copyWith(color: cs.subtitleColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Icon(Icons.chevron_right_rounded, color: cs.onSurface.withValues(alpha: .45), size: 20),
        ],
      ),
    );
  }
}
