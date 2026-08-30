import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.height = 52,
    this.width,
    this.borderRadius = 12,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.child,
  });

  final String text;
  final VoidCallback? onPressed;

  final bool isLoading;
  final bool enabled;

  final double height;
  final double? width;
  final double borderRadius;

  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: enabled && !isLoading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor: theme.colorScheme.primary.withValues(alpha: 0.5),
          disabledForegroundColor: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: isLoading
            ? SizedBox(
                width: 22.r,
                height: 22.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: foregroundColor ?? theme.colorScheme.onPrimary,
                ),
              )
            : child ??
                  Text(
                    text,
                    style:
                        textStyle ??
                        theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onPrimary,
                        ),
                  ),
      ),
    );
  }
}
