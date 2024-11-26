import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278217066),
      surfaceTint: Color(4278217066),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4288475633),
      onPrimaryContainer: Color(4278198304),
      secondary: Color(4283065187),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4291619047),
      onSecondaryContainer: Color(4278460192),
      tertiary: Color(4283195516),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292076543),
      onTertiaryContainer: Color(4278524981),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294245370),
      onSurface: Color(4279639325),
      onSurfaceVariant: Color(4282337608),
      outline: Color(4285495673),
      outlineVariant: Color(4290693320),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4286633173),
      primaryFixed: Color(4288475633),
      onPrimaryFixed: Color(4278198304),
      primaryFixedDim: Color(4286633173),
      onPrimaryFixedVariant: Color(4278210384),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278460192),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4281486155),
      tertiaryFixed: Color(4292076543),
      onTertiaryFixed: Color(4278524981),
      tertiaryFixedDim: Color(4289972457),
      onTertiaryFixedVariant: Color(4281616483),
      surfaceDim: Color(4292205531),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126633),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278209356),
      surfaceTint: Color(4278217066),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280516994),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281222983),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284447097),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281353311),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284642963),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294245370),
      onSurface: Color(4279639325),
      onSurfaceVariant: Color(4282074436),
      outline: Color(4283916641),
      outlineVariant: Color(4285758844),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4286633173),
      primaryFixed: Color(4280516994),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278216552),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284447097),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282868064),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4284642963),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282998137),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205531),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126633),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278200103),
      surfaceTint: Color(4278217066),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278209356),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278986278),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281222983),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279051068),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4281353311),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294245370),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280034854),
      outline: Color(4282074436),
      outlineVariant: Color(4282074436),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020977),
      inversePrimary: Color(4289133563),
      primaryFixed: Color(4278209356),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278203187),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281222983),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279710001),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281353311),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4279840327),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205531),
      surfaceBright: Color(4294245370),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293916148),
      surfaceContainer: Color(4293521390),
      surfaceContainerHigh: Color(4293126633),
      surfaceContainerHighest: Color(4292732131),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4286633173),
      surfaceTint: Color(4286633173),
      onPrimary: Color(4278204215),
      primaryContainer: Color(4278210384),
      onPrimaryContainer: Color(4288475633),
      secondary: Color(4289776843),
      onSecondary: Color(4279972917),
      secondaryContainer: Color(4281486155),
      onSecondaryContainer: Color(4291619047),
      tertiary: Color(4289972457),
      onTertiary: Color(4280103243),
      tertiaryContainer: Color(4281616483),
      onTertiaryContainer: Color(4292076543),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279112980),
      onSurface: Color(4292732131),
      onSurfaceVariant: Color(4290693320),
      outline: Color(4287140754),
      outlineVariant: Color(4282337608),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278217066),
      primaryFixed: Color(4288475633),
      onPrimaryFixed: Color(4278198304),
      primaryFixedDim: Color(4286633173),
      onPrimaryFixedVariant: Color(4278210384),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278460192),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4281486155),
      tertiaryFixed: Color(4292076543),
      onTertiaryFixed: Color(4278524981),
      tertiaryFixedDim: Color(4289972457),
      onTertiaryFixedVariant: Color(4281616483),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4286896601),
      surfaceTint: Color(4286633173),
      onPrimary: Color(4278196762),
      primaryContainer: Color(4282883742),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290105552),
      onSecondary: Color(4278196762),
      secondaryContainer: Color(4286289557),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4290235629),
      onTertiary: Color(4278196016),
      tertiaryContainer: Color(4286485169),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112980),
      onSurface: Color(4294376699),
      onSurfaceVariant: Color(4290956748),
      outline: Color(4288390564),
      outlineVariant: Color(4286285189),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278210897),
      primaryFixed: Color(4288475633),
      onPrimaryFixed: Color(4278195221),
      primaryFixedDim: Color(4286633173),
      onPrimaryFixedVariant: Color(4278205758),
      secondaryFixed: Color(4291619047),
      onSecondaryFixed: Color(4278195221),
      secondaryFixedDim: Color(4289776843),
      onSecondaryFixedVariant: Color(4280367674),
      tertiaryFixed: Color(4292076543),
      onTertiaryFixed: Color(4278194471),
      tertiaryFixedDim: Color(4289972457),
      onTertiaryFixedVariant: Color(4280498001),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4293525502),
      surfaceTint: Color(4286633173),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4286896601),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293525502),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290105552),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294703871),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4290235629),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112980),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294180348),
      outline: Color(4290956748),
      outlineVariant: Color(4290956748),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292732131),
      inversePrimary: Color(4278202416),
      primaryFixed: Color(4288738806),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4286896601),
      onPrimaryFixedVariant: Color(4278196762),
      secondaryFixed: Color(4291882220),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290105552),
      onSecondaryFixedVariant: Color(4278196762),
      tertiaryFixed: Color(4292602111),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4290235629),
      onTertiaryFixedVariant: Color(4278196016),
      surfaceDim: Color(4279112980),
      surfaceBright: Color(4281612858),
      surfaceContainerLowest: Color(4278783759),
      surfaceContainerLow: Color(4279639325),
      surfaceContainer: Color(4279902497),
      surfaceContainerHigh: Color(4280625963),
      surfaceContainerHighest: Color(4281284150),
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
        scaffoldBackgroundColor: colorScheme.background,
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
