import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();

    final formattedDate = DateFormat('dd MMM, yyyy').format(date);

    final user = FirebaseAuth.instance.currentUser;

    final name = user?.displayName ?? 'User';

    final text = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Morning, 👋", style: text.bodyLarge?.copyWith(color: cs.subtitleColor)),
            SizedBox(height: AppSpacing.gap4),
            Text(name, style: text.titleLarge),
            SizedBox(height: AppSpacing.gap4),
            Text(
              "Today, $formattedDate",
              style: text.labelLarge?.copyWith(color: cs.subtitleColor),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none_rounded, size: 30.r),
        ),
      ],
    );
  }
}
