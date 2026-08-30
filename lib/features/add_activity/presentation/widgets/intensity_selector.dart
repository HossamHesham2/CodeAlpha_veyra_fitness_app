import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntensitySelector extends StatelessWidget {
  final String selectedIntensity;
  final ValueChanged<String> onChanged;

  const IntensitySelector({super.key, required this.selectedIntensity, required this.onChanged});

  static const intensities = ['Low', 'Medium', 'High'];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: intensities.map((intensity) {
          final isSelected = selectedIntensity == intensity;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(intensity),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Center(
                  child: Text(
                    intensity,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}