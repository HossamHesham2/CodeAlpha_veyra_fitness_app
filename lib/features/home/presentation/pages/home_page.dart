import 'package:flutter/material.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/features/home/presentation/widgets/fitness_progress_widget.dart';
import 'package:veyra/features/home/presentation/widgets/home_header.dart';
import 'package:veyra/features/home/presentation/widgets/recent_activity_item.dart';
import 'package:veyra/features/home/presentation/widgets/summary_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return DScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.gap24),
            HomeHeader(),
            SizedBox(height: AppSpacing.gap12),
            FitnessProgressWidget(
              progress: 0.74,
              steps: 8460,
              stepsGoal: 10000,
              calories: 920,
              workoutMinutes: 45,
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
                    textNumber: "8460",
                    subtitle: "steps",
                  ),
                ),
                SizedBox(width: AppSpacing.gapH12),
                Expanded(
                  child: SummaryItem(
                    textColor: AppColors.calories,
                    title: "Calories",
                    textNumber: "920",
                    subtitle: "cal",
                  ),
                ),
                SizedBox(width: AppSpacing.gapH12),
                Expanded(
                  child: SummaryItem(
                    textColor: AppColors.workout,
                    title: "Workout Time",
                    textNumber: "45",
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
        
            RecentActivityItem(
              color: AppColors.steps,
              icon: Icons.directions_walk_rounded,
              title: "Running",
              duration: "30 min",
        
              time: "7:30 AM",
              calories: "280 cal",
            ),
            RecentActivityItem(
              color: AppColors.steps,
              icon: Icons.directions_walk_rounded,
              title: "Running",
              duration: "30 min",
        
              time: "7:30 AM",
              calories: "280 cal",
            ),
            RecentActivityItem(
              color: AppColors.steps,
              icon: Icons.directions_walk_rounded,
              title: "Running",
              duration: "30 min",

              time: "7:30 AM",
              calories: "280 cal",
            ),
            RecentActivityItem(
              color: AppColors.steps,
              icon: Icons.directions_walk_rounded,
              title: "Running",
              duration: "30 min",

              time: "7:30 AM",
              calories: "280 cal",
            ),
            SizedBox(height: AppSpacing.gap48),

          ],
        ),
      ),
    );
  }
}
