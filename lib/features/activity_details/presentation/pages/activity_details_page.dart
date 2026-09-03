import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/di/injection.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/models/activity_style_model.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/custom_text_field.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/activity_details/presentation/bloc/activity_details_bloc.dart';
import 'package:veyra/features/activity_details/presentation/bloc/activity_details_event.dart';
import 'package:veyra/features/activity_details/presentation/bloc/activity_details_state.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';

class ActivityDetailsPage extends StatefulWidget {
  final ActivityModel activityModel;

  const ActivityDetailsPage({super.key, required this.activityModel});

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  String capitalize(String? value) {
    if (value == null || value.isEmpty) return "";
    return value[0].toUpperCase() + value.substring(1);
  }

  bool isLoading = false;

  Widget _statCard({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String label,
    required String value,
    required String unit,
  }) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 8.r),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            SizedBox(height: AppSpacing.gap4),
            Text(
              label,
              style: text.titleSmall?.copyWith(color: color),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.gap4),
            Text(
              value,
              style: text.titleSmall,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(unit, style: text.titleSmall),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activityStyle = ActivityStyleModel.getActivityStyle(widget.activityModel.exerciseType);
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final steps = widget.activityModel.steps;
    final notes = widget.activityModel.notes;

    return BlocProvider(
      create: (context) => getIt<ActivityDetailsBloc>(),
      child: BlocConsumer<ActivityDetailsBloc, ActivityDetailsState>(
        listener: (context, state) {
          if (state.deleteActivityRequest == AppRequests.loading) {
            setState(() {
              isLoading = true;
            });
          }
          if (state.deleteActivityRequest == AppRequests.error) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: cs.error,
                content: Text(
                  state.deleteActivityFailure?.errorMessage ?? "Something wrong",
                  style: text.bodyLarge?.copyWith(color: cs.onError),
                ),
              ),
            );
          }
          if (state.deleteActivityRequest == AppRequests.success) {
            setState(() {
              isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: cs.success,
                content: Text(
                  "Deleted success",
                  style: text.bodyLarge?.copyWith(color: cs.onSuccess),
                ),
              ),
            );
            context.pop(true);
          }
        },
        builder: (context, state) {
          return DScaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () => context.pop(), icon: Icon(Icons.arrow_back_ios)),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(color: activityStyle.color, shape: BoxShape.circle),
                  child: Icon(activityStyle.icon, size: 40.sp, color: cs.surface),
                ),
                SizedBox(height: AppSpacing.gap12),
                Text(
                  capitalize(widget.activityModel.exerciseType),
                  style: text.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppSpacing.gap12),
                Text(
                  "${widget.activityModel.date} . ${widget.activityModel.time}",
                  style: text.bodyLarge,
                ),
                SizedBox(height: AppSpacing.gap24),
                Row(
                  spacing: 10.w,
                  children: [
                    _statCard(
                      context: context,
                      icon: Icons.watch_later_outlined,
                      color: AppColors.tertiary,
                      label: "Duration",
                      value: "${widget.activityModel.duration ?? "00"}",
                      unit: "min",
                    ),
                    _statCard(
                      context: context,
                      icon: Icons.local_fire_department_outlined,
                      color: AppColors.calories,
                      label: "Calories",
                      value: "${widget.activityModel.caloriesBurned ?? "00"}",
                      unit: "cal",
                    ),
                    _statCard(
                      context: context,
                      icon: Icons.directions_walk,
                      color: AppColors.steps,
                      label: "Steps",
                      value: (steps == null || steps.isEmpty) ? "no steps" : steps,
                      unit: "steps",
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.gap24),
                CustomTextField(
                  label: "Intensity",
                  readOnly: true,
                  hintText: widget.activityModel.intensity,
                ),
                SizedBox(height: AppSpacing.gap24),
                CustomTextField(
                  label: "Notes",
                  readOnly: true,
                  hintText: (notes == null || notes.isEmpty) ? "No notes added" : notes,
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: "Delete Activity",
                    isLoading: isLoading,
                    onPressed: () {
                      context.read<ActivityDetailsBloc>().add(
                        DeleteActivityEvent(id: widget.activityModel.id),
                      );
                    },
                    backgroundColor: cs.error.withValues(alpha: 0.4),
                    foregroundColor: cs.error,
                  ),
                ),
                SizedBox(height: AppSpacing.gap24),
              ],
            ),
          );
        },
      ),
    );
  }
}
