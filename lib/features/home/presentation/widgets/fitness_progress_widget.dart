import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class FitnessProgressWidget extends StatelessWidget {
  const FitnessProgressWidget({
    super.key,
    this.progress = 0.74,
    this.steps = 7460,
    this.stepsGoal = 10000,
    this.calories = 920,
    this.workoutMinutes = 45,
  });

  final double progress;
  final int steps;
  final int stepsGoal;
  final int calories;
  final int workoutMinutes;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _ProgressCircle(progress: progress)),

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
  const _ProgressCircle({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final percentage = (progress * 100).round();
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
            painter: _ProgressPainter(progress: progress, isDark: isDark),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Daily Goal',
                style: text.labelLarge?.copyWith(color: cs.onSurface, fontWeight: FontWeight.w500),
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
  const _ProgressPainter({required this.progress, required this.isDark});

  final double progress;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = math.min(size.width, size.height) / 2 - 10;

    // Background track
    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..color = isDark ? AppColors.darkNavy : AppColors.lightNavy;

    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Main green progress
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..color = AppColors.steps;
    ;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2 * progress, false, progressPaint);

    // Purple accent
    final purplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.butt
      ..color = AppColors.workout;

    // Small purple segment
    canvas.drawArc(rect, math.pi * 0.62, math.pi * 0.18, false, purplePaint);

    canvas.drawArc(rect, math.pi * 0.92, math.pi * 0.10, false, purplePaint);
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
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
