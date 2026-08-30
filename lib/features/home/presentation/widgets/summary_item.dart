import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class SummaryItem extends StatelessWidget {
  final Color textColor;
  final String title;
  final String subtitle;
  final String textNumber;

  const SummaryItem({
    super.key,
    required this.textColor,
    required this.title,
    required this.textNumber,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colorScheme.primaryFixed,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleSmall?.copyWith(color: textColor),
          ),
          SizedBox(height: AppSpacing.gap4),
          Text(
            textNumber,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyLarge?.copyWith(color: textColor, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: AppSpacing.gap4),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.labelSmall?.copyWith(color: colorScheme.subtitleColor),
          ),
        ],
      ),
    );
  }
}
