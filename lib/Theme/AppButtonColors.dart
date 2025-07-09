import 'package:flutter/material.dart';

// Define your custom button colors class
@immutable // Recommended for theme extension data classes
class AppButtonColors extends ThemeExtension<AppButtonColors> {
  final Color? primaryButtonBackground;
  final Color? primaryButtonForeground;
  final Color? primarySplashColor;
  final Color? secondaryButtonBackground;
  final Color? secondaryButtonForeground;
  final Color? secondarySplashColor;
  final Color?
  specialOperatorBackground; // Example: for buttons like "C", "=", "snd"
  final Color? specialSplashColor;

  const AppButtonColors({
    required this.primaryButtonBackground,
    required this.primaryButtonForeground,
    required this.primarySplashColor,
    required this.secondaryButtonBackground,
    required this.secondaryButtonForeground,
    required this.secondarySplashColor,
    required this.specialOperatorBackground,
    required this.specialSplashColor,
  });

  // Implement copyWith to allow ThemeData to merge extensions
  @override
  AppButtonColors copyWith({
    Color? primaryButtonBackground,
    Color? primaryButtonForeground,
    Color? primarySplashColor,
    Color? secondaryButtonBackground,
    Color? secondaryButtonForeground,
    Color? secondarySplashColor,
    Color? specialOperatorBackground,
    Color? specialSplashColor,
  }) {
    return AppButtonColors(
      primaryButtonBackground:
          primaryButtonBackground ?? this.primaryButtonBackground,
      primaryButtonForeground:
          primaryButtonForeground ?? this.primaryButtonForeground,
      primarySplashColor: primarySplashColor ?? this.primarySplashColor,
      secondaryButtonBackground:
          secondaryButtonBackground ?? this.secondaryButtonBackground,
      secondaryButtonForeground:
          secondaryButtonForeground ?? this.secondaryButtonForeground,
      secondarySplashColor: secondarySplashColor ?? this.secondarySplashColor,
      specialOperatorBackground:
          specialOperatorBackground ?? this.specialOperatorBackground,
      specialSplashColor: specialSplashColor ?? this.specialSplashColor,
    );
  }

  // Implement lerp to allow ThemeData to smoothly transition between themes
  @override
  AppButtonColors lerp(ThemeExtension<AppButtonColors>? other, double t) {
    if (other is! AppButtonColors) {
      return this; // Or provide a default if 'other' is null and you want to handle that
    }
    return AppButtonColors(
      primaryButtonBackground: Color.lerp(
        primaryButtonBackground,
        other.primaryButtonBackground,
        t,
      ),
      primaryButtonForeground: Color.lerp(
        primaryButtonForeground,
        other.primaryButtonForeground,
        t,
      ),
      primarySplashColor: Color.lerp(
        primarySplashColor,
        other.primarySplashColor,
        t,
      ),
      secondaryButtonBackground: Color.lerp(
        secondaryButtonBackground,
        other.secondaryButtonBackground,
        t,
      ),
      secondaryButtonForeground: Color.lerp(
        secondaryButtonForeground,
        other.secondaryButtonForeground,
        t,
      ),
      secondarySplashColor: Color.lerp(
        secondarySplashColor,
        other.secondarySplashColor,
        t,
      ),
      specialOperatorBackground: Color.lerp(
        specialOperatorBackground,
        other.specialOperatorBackground,
        t,
      ),
      specialSplashColor: Color.lerp(
        specialSplashColor,
        other.specialSplashColor,
        t,
      ),
    );
  }

  // Optional: Define 'of' method for easier access, though Theme.of(context).extension is standard
  // static AppButtonColors? of(BuildContext context) {
  //   return Theme.of(context).extension<AppButtonColors>();
  // }

  // Optional: For debugging
  // @override
  // String toString() => 'AppButtonColors('
  //     'primaryButtonBackground: $primaryButtonBackground, '
  //     'primaryButtonForeground: $primaryButtonForeground, '
  // // ... and so on for other properties
  //     ')';
}
