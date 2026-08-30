import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/constants/app_enums.dart';
import 'package:veyra/core/extensions/exercise_type_extension.dart';

class ExerciseTypeDropdown extends StatelessWidget {
  final ExerciseType? value;
  final ValueChanged<ExerciseType?> onChanged;

  const ExerciseTypeDropdown({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final cs = theme.colorScheme;

    return DropdownButtonFormField<ExerciseType>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Activity Type',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r)),
      ),
      validator: (value) {
        if (value == null) return 'Please select your activity';

        return null;
      },
      selectedItemBuilder: (context) {
        return ExerciseType.values.map((type) {
          return Row(
            children: [
              Icon(type.icon, size: 22.sp, color: cs.primary),
              SizedBox(width: 12.w),
              Text(type.displayName, style: text.bodyMedium),
            ],
          );
        }).toList();
      },
      items: ExerciseType.values.map((type) {
        return DropdownMenuItem<ExerciseType>(
          value: type,
          child: Row(
            children: [
              Icon(type.icon, size: 22.sp, color: cs.primary),
              SizedBox(width: 12.w),
              Text(type.displayName, style: text.bodyMedium),
            ],
          ),
        );
      }).toList(),
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: onChanged,
    );
  }
}
