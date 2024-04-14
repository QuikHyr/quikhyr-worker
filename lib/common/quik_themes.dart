import 'package:flutter/material.dart';
import 'package:quikhyr_worker/common/quik_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 20,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w800,
        height: 1.0,
      ),
      headlineSmall: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.0,
      ),
      titleLarge: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
      titleMedium: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 14,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
      bodyLarge: TextStyle(
        color: secondary,
        fontFamily: 'Trap',
        fontSize: 13,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontFamily: 'Trap',
        fontSize: 12,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 1.0,
      ),
      labelLarge: TextStyle(
        color: labelColor,
        fontFamily: 'Trap',
        fontSize: 11,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        height: 1.0,
      ),
      labelMedium: TextStyle(
        color: ratingTextColor,
        fontFamily: 'Trap',
        fontSize: 10,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 1.0,
      ),
      labelSmall: TextStyle(
        color: primary,
        fontFamily: 'Trap',
        fontSize: 10,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 1.0,
      ),
    ),
    colorScheme: const ColorScheme(
      onError: error,
      surface: surface,
      onSurface: onSurface,
      brightness: Brightness.dark,
      background: background,
      onBackground: onBackground,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      tertiary: tertiary,
      error: error,
      outline: outline,
    ),
  );
}

const TextStyle chatSubTitle = TextStyle(
  color: quikHyrBlue,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  height: 1.0,
);

const TextStyle descriptionTextStyle = TextStyle(
  color: placeHolderText,
  letterSpacing: 0.5,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  height: 1.28,
);
const TextStyle chatSubTitleRead = TextStyle(
  color: placeHolderText,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w400,
  height: 1.0,
);

const TextStyle chatTrailingActive = TextStyle(
  color: quikHyrBlue,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  height: 1.0,
);

const TextStyle chatTrailingInactive = TextStyle(
  color: placeHolderText,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  height: 1.0,
);

const TextStyle availabilityTextStyle = TextStyle(
  color: quikHyrBlue,
  fontFamily: 'Trap',
  fontSize: 12.0,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w600,
  height: 1.0,
);