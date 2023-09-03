import 'package:flutter/material.dart';

import '../helpers/enum_helpers.dart';
import '../styles/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final ButtonMode buttonMode;
  final bool isCompact;
  final double fontSize;

  const CustomButton.primary({
    super.key,
    required this.title,
    required this.onTap,
    this.isCompact = false,
    this.fontSize = 20,
  }) : buttonMode = ButtonMode.primary;

  const CustomButton.secondary({
    super.key,
    required this.title,
    required this.onTap,
    this.isCompact = false,
    this.fontSize = 18,
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
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis,
            fontFamily: kFontFamilyZenDots,
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      );

  Widget _buildSecondaryButton() => OutlinedButton(
        style: OutlinedButton.styleFrom(
          visualDensity: isCompact ? VisualDensity.compact : null,
          textStyle: TextStyle(
            fontSize: fontSize,
            overflow: TextOverflow.ellipsis,
            fontFamily: kFontFamilyZenDots,
          ),
        ),
        onPressed: onTap,
        child: Text(title),
      );
}
