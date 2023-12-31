import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/fonts.gen.dart';

enum ButtonMode {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final ButtonMode buttonMode;
  final bool isCompact;

  const CustomButton.primary({
    super.key,
    required this.title,
    required this.onTap,
    this.isCompact = false,
  }) : buttonMode = ButtonMode.primary;

  const CustomButton.secondary({
    super.key,
    required this.title,
    required this.onTap,
    this.isCompact = false,
  }) : buttonMode = ButtonMode.secondary;

  @override
  Widget build(BuildContext context) {
    return _mapModeToButton();
  }

  Widget _mapModeToButton() {
    switch (buttonMode) {
      case ButtonMode.primary:
        return _buildPrimaryButton();
      case ButtonMode.secondary:
        return _buildSecondaryButton();
    }
  }

  Widget _buildPrimaryButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: isCompact ? VisualDensity.compact : null,
          textStyle: TextStyle(
            fontSize: isCompact ? 13.sp : 20.sp,
            overflow: TextOverflow.ellipsis,
            fontFamily: FontFamily.zenDots,
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      );

  Widget _buildSecondaryButton() => OutlinedButton(
        style: OutlinedButton.styleFrom(
          visualDensity: isCompact ? VisualDensity.compact : null,
          textStyle: TextStyle(
            fontSize: isCompact ? 13.sp : 18.sp,
            overflow: TextOverflow.ellipsis,
            fontFamily: FontFamily.zenDots,
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      );
}
