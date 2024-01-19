import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleTheme {
  TextStyleTheme(this.context) {
    _textTheme = Theme.of(context).textTheme;
  }

  late TextTheme _textTheme;

  final BuildContext context;
  Brightness get brightness => Theme.of(context).brightness;

  TextStyle? get titleLarge => _textTheme.titleLarge?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 36,
      );
  TextStyle? get titleMedium => _textTheme.titleMedium?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 30,
      );
  TextStyle? get titleSmall => _textTheme.titleSmall?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 18,
      );
  TextStyle? get bodyLarge => _textTheme.bodyLarge?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 22,
      );
  TextStyle? get bodyMedium => _textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 14,
      );
  TextStyle? get bodySmall => _textTheme.bodySmall?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 6,
      );
  TextStyle? get labelLarge => _textTheme.labelLarge?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 16,
      );
  TextStyle? get labelMedium => _textTheme.labelMedium?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 12,
      );
  TextStyle? get labelSmall => _textTheme.labelSmall?.copyWith(
        color: Colors.grey.shade900,
        fontSize: 8,
      );

  static TextStyle get baseTitleStyle => GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
          height: 1.2,
          letterSpacing: 0,
          fontWeight: FontWeight.w700,
        ),
      );
  static TextStyle get baseBodyStyle => GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
          height: 1.2,
          letterSpacing: 0,
          fontWeight: FontWeight.w500,
        ),
      );
  static TextStyle get baseLabelStyle => GoogleFonts.plusJakartaSans(
        textStyle: const TextStyle(
          height: 1.2,
          letterSpacing: 0,
          fontWeight: FontWeight.w400,
        ),
      );
}
