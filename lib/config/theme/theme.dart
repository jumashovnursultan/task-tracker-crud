import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_type.dart';

class AppTheme {
  static const defaultType = ThemeType.light;
  static final defaultTheme = AppTheme.fromType(defaultType);

  late ThemeType type;
  bool isDark;

  late Color primaryColor;
  late Color onPrimaryColor;
  late Color secondaryColor;
  late Color bgColor;
  late Color focusColor;
  late Color surface;
  late Color errorColor;

  AppTheme({this.isDark = false});

  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(isDark: false)
          ..type = t
          ..primaryColor = const Color(0xFFFFEE00)
          ..onPrimaryColor = const Color(0xFFFFFFFF)
          ..focusColor = const Color(0x3000BB29)
          ..secondaryColor = const Color(0xFFF5F5F5)
          ..bgColor = const Color(0xffFFFFFF)
          ..surface = const Color(0xFFF0F0F0)
          ..errorColor = const Color(0xffDF2323);

      case ThemeType.dark:
        return AppTheme(isDark: true)
          ..type = t
          ..primaryColor = const Color(0xFFFFEE00)
          ..onPrimaryColor = const Color(0xFFFFFFFF)
          ..focusColor = const Color(0x3053B175)
          ..secondaryColor = const Color(0xFF373737)
          ..bgColor = const Color(0xFF191919)
          ..surface = const Color(0xFF1B1B1B)
          ..surface = const Color(0xFF2B2B2B)
          ..errorColor = const Color(0xffDF2323);
    }
  }

  ThemeData get themeData {
    var t = ThemeData();
    return t.copyWith(
      scaffoldBackgroundColor: bgColor,
      textTheme: t.textTheme.apply(
        fontFamily: GoogleFonts.nunito(letterSpacing: -.3).fontFamily,
      ),
      primaryTextTheme: t.primaryTextTheme.apply(
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),

      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,

        surface: surface,
        surfaceTint: bgColor,

        onPrimary: onPrimaryColor,
        onSecondary: secondaryColor,
        error: errorColor,
        onError: Colors.purple,
        onSurface: surface,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryColor,
          shadowColor: Colors.transparent,
          overlayColor: Colors.white,
          animationDuration: Duration(milliseconds: 100),
          minimumSize: const Size.fromHeight(54),
          maximumSize: const Size(double.infinity, 54),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,

            color: onPrimaryColor,
            letterSpacing: -.3,
            height: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFF92918A),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.only(
          left: 24,
          right: 8,
          top: 15,
          bottom: 14,
        ),

        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF92918A),
        ),
        filled: true,
        fillColor: secondaryColor,
        errorStyle: TextStyle(fontSize: 12, color: errorColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: const Color(0xFF92918A), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: errorColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: errorColor, width: 1),
        ),
      ),
      primaryColor: primaryColor,
    );
  }

  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c);
    double lightness = (hslc.lightness + amt).clamp(0, 1.0).toDouble();
    return hslc.withLightness(lightness).toColor();
  }
}
