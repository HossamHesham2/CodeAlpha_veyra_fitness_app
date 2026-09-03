import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/di/injection.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/d_scaffold.dart';
import 'package:veyra/core/widgets/primary_button.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/add_activity/presentation/bloc/add_activity_bloc.dart';
import 'package:veyra/features/add_activity/presentation/bloc/add_activity_event.dart';
import 'package:veyra/features/add_activity/presentation/bloc/add_activity_state.dart';
import 'package:veyra/features/add_activity/presentation/widgets/exercise_type_dropdown.dart';
import 'package:veyra/features/add_activity/presentation/widgets/intensity_selector.dart';
import 'package:veyra/features/add_activity/presentation/widgets/labeled_text_field.dart';


class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  ExerciseType? selectedActivity;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedIntensity = 'Medium';
  bool isLoading = false;

  final durationController = TextEditingController();
  final caloriesController = TextEditingController();
  final stepsController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final notesController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
        dateController.text = DateFormat('dd MMM, yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectTime() async {
    final time = await showTimePicker(context: context, initialTime: selectedTime);

    if (time != null) {
      setState(() {
        selectedTime = time;
        timeController.text = time.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd MMM, yyyy').format(selectedDate);
  }

  @override
  void dispose() {
    durationController.dispose();
    caloriesController.dispose();
    stepsController.dispose();
    dateController.dispose();
    timeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => getIt<AddActivityBloc>(),
      child: BlocConsumer<AddActivityBloc, AddActivityState>(
        listener: (context, state) {
          if (state.addActivityRequest == AppRequests.loading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.addActivityRequest == AppRequests.error) {
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.error,
                content: Text(
                  state.addActivityFailure?.errorMessage ?? "Something went wrong!",
                  style: text.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onError),
                ),
              ),
            );
          } else if (state.addActivityRequest == AppRequests.success) {
            setState(() {
              isLoading = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.success,
                content: Text(
                  "Activity Added Successfully",
                  style: text.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSuccess),
                ),
              ),
            );

            context.pop(true);
          }
        },
        builder: (context, state) => DScaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Text("Add Activity", style: text.titleLarge),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Exercise Type", style: text.titleMedium),
                  SizedBox(height: AppSpacing.gap12),
                  ExerciseTypeDropdown(
                    value: selectedActivity,
                    onChanged: (value) => setState(() => selectedActivity = value),
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Duration",
                    controller: durationController,
                    hintText: "Enter duration",
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.timer_outlined, color: AppColors.tertiary),
                    suffixIcon: SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          'min',
                          style: text.bodyMedium?.copyWith(color: AppColors.tertiary),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Please enter workout duration';
                      final duration = int.tryParse(value);
                      if (duration == null || duration <= 0) return 'Enter a valid duration';
                      return null;
                    },
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Calories Burned",
                    controller: caloriesController,
                    hintText: "Enter calories ",
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.local_fire_department, color: AppColors.calories),
                    suffixIcon: SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          'cal',
                          style: text.bodyMedium?.copyWith(color: AppColors.calories),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Please enter your calories burned';
                      final calories = int.tryParse(value);
                      if (calories == null || calories <= 0) return 'Enter a valid calories';
                      return null;
                    },
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Steps (Optional)",
                    controller: stepsController,
                    hintText: "Enter steps ",
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.directions_walk, color: AppColors.steps),
                    suffixIcon: SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          'steps',
                          style: text.bodyMedium?.copyWith(color: AppColors.steps),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Date",
                    controller: dateController,
                    hintText: "Enter Date ",
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: _selectDate,
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Please enter your date';
                      return null;
                    },
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Time",
                    controller: timeController,
                    hintText: "Enter Time ",
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: _selectTime,
                    prefixIcon: const Icon(Icons.watch_later_outlined),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Please enter your time';
                      return null;
                    },
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  Text("Intensity", style: text.titleMedium),
                  SizedBox(height: AppSpacing.gap12),
                  IntensitySelector(
                    selectedIntensity: selectedIntensity,
                    onChanged: (value) => setState(() => selectedIntensity = value),
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  LabeledTextField(
                    label: "Notes (Optional)",
                    controller: notesController,
                    hintText: "Enter your notes ",
                    maxLines: 2,
                    prefixIcon: const Icon(Icons.note_add_outlined),
                  ),
                  SizedBox(height: AppSpacing.gap24),

                  PrimaryButton(
                    text: "Save Activity",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final activityModel = ActivityModel(
                          exerciseType: selectedActivity?.name,
                          duration: durationController.text.trim(),
                          caloriesBurned: caloriesController.text.trim(),
                          steps: stepsController.text.trim(),
                          date: DateFormat('dd MMM, yyyy').format(selectedDate).toString(),
                          time: MaterialLocalizations.of(context)
                              .formatTimeOfDay(selectedTime, alwaysUse24HourFormat: false),
                          intensity: selectedIntensity,
                          notes: notesController.text.trim(),
                        );
                        context.read<AddActivityBloc>().add(
                          AddActivityEvent(activityModel: activityModel),
                        );
                      }
                    },
                    isLoading: isLoading,
                  ),
                  SizedBox(height: AppSpacing.gap24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
