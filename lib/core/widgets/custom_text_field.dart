import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:veyra/core/utils/app_spacing.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final String? suffixText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autocorrect;
  final int? maxLines;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.textInputAction,
    this.keyboardType,
    this.controller,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.suffixText, this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && label!.isNotEmpty) ...[
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: AppSpacing.gap12),
        ],

        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          autocorrect: autocorrect,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: keyboardType,
          textAlign: textAlign,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffix: suffix
          ),
        ),
      ],
    );
  }
}
