import 'package:flutter/material.dart';

class AppTheme {
  //spaces
  static const double cardPadding = 20;
  static const double elementSpacing = cardPadding * 0.5;
  static const double bottomNavBarHeight = 64;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static BorderRadius cardRadius = BorderRadius.circular(14);
  static const double iconSize = cardPadding;

  static const Color blackLight = Color(0xFF292031);

  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  //colors
  static const Color black = Color(0xFF141416);
  static const Color orange = Color(0xFFFFBD69);
  static const Color orangeDark = Color(0xFFFF7565);

  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF6363);
  static const Color purple = Color(0xFF543864);
  static const Color purpleDark = Color(0xFF221C29);

  static const Color darkBlue = Color(0xFF202040);
  static const Color grey = Color(0xFF636363);
  static const Color darkBlueLight = Color(0xFF382843);

  //text theme
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 38.4,
      letterSpacing: -1.0,
      color: orange,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 27.2,
      letterSpacing: -0.25,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 21.2,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 20.4,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18.0,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 17.0,
      letterSpacing: 0.25,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 15.3,
      letterSpacing: 0.15,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11.3,
      letterSpacing: 0.1,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 13.6,
      letterSpacing: 0.5,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11.9,
      letterSpacing: 0.25,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 10.8,
      letterSpacing: 0.4,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18.0,
      letterSpacing: 0.60,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 8.0,
      letterSpacing: 0.1,
      color: white,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: black,
    primaryColor: red,
    hintColor: white,
    indicatorColor: red,
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(purple),
      splashRadius: 24,
    ),
    iconTheme: const IconThemeData(color: grey),
    splashColor: red.withOpacity(.4),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: black,
      filled: true,
      labelStyle: textTheme.bodyLarge,
      hintStyle: textTheme.bodyLarge?.copyWith(
        color: AppTheme.white.withOpacity(.8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(99),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(99),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(99),
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: white,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: red),
  );
}
