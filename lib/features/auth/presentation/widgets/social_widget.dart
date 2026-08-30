import 'package:flutter/material.dart';
import 'package:veyra/core/constants/app_assets.dart';
import 'package:veyra/core/theme/app_colors.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/features/auth/presentation/widgets/social_button.dart';
import 'package:veyra/core/extensions/color_schema_extension.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        SizedBox(height: AppSpacing.gap16),
        Row(
          children: [
            Expanded(
              child: Divider(
                color: cs.onSurface.withValues(alpha: 0.3),
                endIndent: 10,
                indent: 10,
                thickness: 2,
              ),
            ),
            Text(
              "or continue with",
              style: text.titleMedium?.copyWith(color: cs.onSurface.withValues(alpha: 0.6)),
            ),
            Expanded(
              child: Divider(
                color: cs.onSurface.withValues(alpha: 0.3),
                indent: 10,
                endIndent: 10,
                thickness: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.gap24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialIconButton(
              backgroundColor: cs.white,
              onPressed: () {},
              assetName: AppSvgs.google,
              colorScheme: cs,
            ),
            SocialIconButton(
              backgroundColor: cs.white,
              onPressed: () {},
              assetName: AppSvgs.apple,
              colorScheme: cs,
            ),
            SocialIconButton(
              backgroundColor: AppColors.tertiaryDark,
              onPressed: () {},
              assetName: AppSvgs.facebook,
              colorScheme: cs,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.gap24),
      ],
    );
  }
}
