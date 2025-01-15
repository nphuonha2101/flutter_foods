import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00696a),
      surfaceTint: Color(0xff00696a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9cf1f1),
      onPrimaryContainer: Color(0xff002020),
      secondary: Color(0xff4a6363),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e7),
      onSecondaryContainer: Color(0xff041f20),
      tertiary: Color(0xff4c607c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffd3e3ff),
      onTertiaryContainer: Color(0xff051c35),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3f4948),
      outline: Color(0xff6f7979),
      outlineVariant: Color(0xffbec8c8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d4d5),
      primaryFixed: Color(0xff9cf1f1),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d4d5),
      onPrimaryFixedVariant: Color(0xff004f50),
      secondaryFixed: Color(0xffcce8e7),
      onSecondaryFixed: Color(0xff041f20),
      secondaryFixedDim: Color(0xffb0cccb),
      onSecondaryFixedVariant: Color(0xff324b4b),
      tertiaryFixed: Color(0xffd3e3ff),
      onTertiaryFixed: Color(0xff051c35),
      tertiaryFixedDim: Color(0xffb3c8e9),
      onTertiaryFixedVariant: Color(0xff344863),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b4c),
      surfaceTint: Color(0xff00696a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff238182),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e4747),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5f7979),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff30445f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff627693),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff161d1d),
      onSurfaceVariant: Color(0xff3b4544),
      outline: Color(0xff576161),
      outlineVariant: Color(0xff737d7c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff80d4d5),
      primaryFixed: Color(0xff238182),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006768),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5f7979),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff476160),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff627693),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff495d79),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002727),
      surfaceTint: Color(0xff00696a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b4c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c2626),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e4747),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0d233c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff30445f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbfa),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2626),
      outline: Color(0xff3b4544),
      outlineVariant: Color(0xff3b4544),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xffa6fbfb),
      primaryFixed: Color(0xff004b4c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003333),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e4747),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff173131),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff30445f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff192e47),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbdb),
      surfaceBright: Color(0xfff4fbfa),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f4),
      surfaceContainer: Color(0xffe9efee),
      surfaceContainerHigh: Color(0xffe3e9e9),
      surfaceContainerHighest: Color(0xffdde4e3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff80d4d5),
      surfaceTint: Color(0xff80d4d5),
      onPrimary: Color(0xff003737),
      primaryContainer: Color(0xff004f50),
      onPrimaryContainer: Color(0xff9cf1f1),
      secondary: Color(0xffb0cccb),
      onSecondary: Color(0xff1b3435),
      secondaryContainer: Color(0xff324b4b),
      onSecondaryContainer: Color(0xffcce8e7),
      tertiary: Color(0xffb3c8e9),
      onTertiary: Color(0xff1d314b),
      tertiaryContainer: Color(0xff344863),
      onTertiaryContainer: Color(0xffd3e3ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e3),
      onSurfaceVariant: Color(0xffbec8c8),
      outline: Color(0xff889392),
      outlineVariant: Color(0xff3f4948),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff00696a),
      primaryFixed: Color(0xff9cf1f1),
      onPrimaryFixed: Color(0xff002020),
      primaryFixedDim: Color(0xff80d4d5),
      onPrimaryFixedVariant: Color(0xff004f50),
      secondaryFixed: Color(0xffcce8e7),
      onSecondaryFixed: Color(0xff041f20),
      secondaryFixedDim: Color(0xffb0cccb),
      onSecondaryFixedVariant: Color(0xff324b4b),
      tertiaryFixed: Color(0xffd3e3ff),
      onTertiaryFixed: Color(0xff051c35),
      tertiaryFixedDim: Color(0xffb3c8e9),
      onTertiaryFixedVariant: Color(0xff344863),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d9d9),
      surfaceTint: Color(0xff80d4d5),
      onPrimary: Color(0xff001a1a),
      primaryContainer: Color(0xff479e9e),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb5d0d0),
      onSecondary: Color(0xff001a1a),
      secondaryContainer: Color(0xff7b9695),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb7cced),
      onTertiary: Color(0xff001730),
      tertiaryContainer: Color(0xff7e92b1),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xfff6fcfb),
      onSurfaceVariant: Color(0xffc2cdcc),
      outline: Color(0xff9ba5a4),
      outlineVariant: Color(0xff7b8585),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff005151),
      primaryFixed: Color(0xff9cf1f1),
      onPrimaryFixed: Color(0xff001415),
      primaryFixedDim: Color(0xff80d4d5),
      onPrimaryFixedVariant: Color(0xff003d3e),
      secondaryFixed: Color(0xffcce8e7),
      onSecondaryFixed: Color(0xff001415),
      secondaryFixedDim: Color(0xffb0cccb),
      onSecondaryFixedVariant: Color(0xff213a3a),
      tertiaryFixed: Color(0xffd3e3ff),
      onTertiaryFixed: Color(0xff001127),
      tertiaryFixedDim: Color(0xffb3c8e9),
      onTertiaryFixedVariant: Color(0xff233751),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe9fffe),
      surfaceTint: Color(0xff80d4d5),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff84d9d9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe9fffe),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5d0d0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffbfaff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb7cced),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdfc),
      outline: Color(0xffc2cdcc),
      outlineVariant: Color(0xffc2cdcc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e3),
      inversePrimary: Color(0xff003030),
      primaryFixed: Color(0xffa0f5f6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d9d9),
      onPrimaryFixedVariant: Color(0xff001a1a),
      secondaryFixed: Color(0xffd0ecec),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5d0d0),
      onSecondaryFixedVariant: Color(0xff001a1a),
      tertiaryFixed: Color(0xffdbe8ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb7cced),
      onTertiaryFixedVariant: Color(0xff001730),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1d),
      surfaceContainer: Color(0xff1a2121),
      surfaceContainerHigh: Color(0xff252b2b),
      surfaceContainerHighest: Color(0xff2f3636),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
