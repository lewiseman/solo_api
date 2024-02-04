import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static Color white2 = const Color.fromARGB(255, 248, 245, 248);
  static Color white3 = Colors.grey.shade300;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 57, 142, 227),
    ),
    scaffoldBackgroundColor: const Color(0xFFF3F3F3),
    canvasColor: white2,
    dividerColor: white3,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        side: BorderSide(color: white3, width: .8),
        backgroundColor: white2,
        foregroundColor: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF202020),
    canvasColor: const Color(0xff1c1b1f),
    dividerColor: Colors.grey.shade800,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
  );
}
