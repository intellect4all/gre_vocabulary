import 'package:flutter/material.dart';

class ThemeChangeNotifier extends ChangeNotifier {
  ThemeMode _currentThemeMode = ThemeMode.light;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void toggleTheme() {
    _currentThemeMode =
        _currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppThemes {
  static ThemeData getTheme({ThemeMode themeMode = ThemeMode.light}) {
    final colors = _getColors(themeMode);
    final textTheme = _getTextThemeData(themeMode, colors);

    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: colors.primary,
        accentColor: colors.secondary,
        backgroundColor: colors.background,
        brightness:
            themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
      ),
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static _AppColors _getColors(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return _DarkColors();
      default:
        return _LightColors();
    }
  }

  static _getTextThemeData(ThemeMode themeMode, _AppColors colors) {
    final color = colors.text;
    return TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}

abstract class _AppColors {
  final MaterialColor primary;
  final Color secondary;
  final Color background;
  final Color labelText;
  final Color text;

  const _AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.labelText,
    required this.text,
  });
}
//(Color(0xFF732bf0) Color(0xFF732bf0)

class _LightColors implements _AppColors {
  @override
  MaterialColor get primary => const MaterialColor(
        0xFF732bf0,
        {
          100: Color(0xFF732bf0),
          200: Color(0xFF732bf0),
          300: Color(0xFF732bf0),
          400: Color(0xFF732bf0),
          500: Color(0xFF732bf0),
          600: Color(0xFF732bf0),
          700: Color(0xFF732bf0),
          800: Color(0xFF732bf0),
        },
      );

  @override
  Color get secondary => const Color(0xFF19151f);

  @override
  Color get background => Colors.white;

  @override
  Color get labelText => const Color(0xFF524f57);

  @override
  Color get text => const Color(0xFF19151f);
}

class _DarkColors implements _AppColors {
  @override
  MaterialColor get primary => const MaterialColor(
        0xFF732bf0,
        {
          00: Color(0xFF732bf0),
          01: Color(0xFF732bf0),
        },
      );

  @override
  Color get secondary => const Color(0xFF19151f);

  @override
  Color get background => Colors.black;

  @override
  Color get labelText => const Color(0xFF524f57);

  @override
  Color get text => const Color(0xFF19151f);
}
