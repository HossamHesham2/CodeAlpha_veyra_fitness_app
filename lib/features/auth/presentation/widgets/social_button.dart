import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SocialIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String assetName;
  final ColorScheme colorScheme;
  final Color backgroundColor;

  const SocialIconButton({
    required this.onPressed,
    required this.assetName,
    required this.colorScheme,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onPressed,
        child: Container(
          width: 50.r,
          height: 50.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: SvgPicture.asset(assetName, width: 25.r),
        ),
      ),
    );
  }
}
