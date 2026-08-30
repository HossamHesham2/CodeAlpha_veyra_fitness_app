import 'package:flutter/material.dart';
import 'package:veyra/core/utils/app_spacing.dart';
import 'package:veyra/core/widgets/custom_text_field.dart';

/// Wraps a title [Text] + [CustomTextField] pair, since this pattern
/// (Duration, Calories, Steps, Date, Time, Notes) repeats across the form.
class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.titleMedium),
        SizedBox(height: AppSpacing.gap12),
        CustomTextField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          validator: validator,
          readOnly: readOnly,
          onTap: onTap,
          maxLines: maxLines,
        ),
      ],
    );
  }
}