import 'package:flutter/material.dart';
import 'package:veyra/core/theme/app_colors.dart';

extension AppColorSchemeExtension on ColorScheme {
  Color get white => AppColors.lightSurface;

  Color get subtitleColor => onSurface.withValues(alpha: 0.7);

  Color get success => AppColors.success;

  Color get onSuccess => AppColors.lightSurface;
}
