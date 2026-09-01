import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class ActivityItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String duration;
  final String calories;
  final String time;

  const ActivityItem({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.duration,
    required this.calories,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final secondaryTextStyle = textTheme.bodySmall?.copyWith(
      color: colorScheme.onSurface.withValues(alpha: 0.5),
    );

    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.symmetric(vertical: AppSpacing.gap8),
      decoration: BoxDecoration(
        color: colorScheme.primaryFixed,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          SizedBox(width: AppSpacing.gapH12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 2.h),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      duration,
                      style: secondaryTextStyle,
                    ),

                    SizedBox(width: AppSpacing.gapH4),

                    Text(
                      '·',
                      style: secondaryTextStyle,
                    ),

                    SizedBox(width: AppSpacing.gapH4),

                    Text(
                      calories,
                      style: secondaryTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: AppSpacing.gapH8),

          Text(
            time,
            style: secondaryTextStyle?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}