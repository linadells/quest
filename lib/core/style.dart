import 'package:flutter/material.dart';

const kDark = Color.fromARGB(255, 56, 56, 59);
const kMedium = Color.fromARGB(255, 82, 73, 199);
const kAccent = Color.fromARGB(255, 253, 230, 22);

BoxDecoration kStyleForQuestionContainer = BoxDecoration(
  shape: BoxShape.rectangle,
  border: Border.all(
    color: kMedium,
    width: 2,
    style: BorderStyle.solid,
  ),
  borderRadius: BorderRadius.circular(30.0), // Додаємо скруглений край
);
BoxDecoration kStyleForPoints = BoxDecoration(
  color: kAccent, // Жовтий фон
  borderRadius: BorderRadius.circular(30.0), // Скруглені краї
);

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kDark,
    hintColor: kMedium,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: kDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      hintStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
        color: kDark, // Колір підказки
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), // Закруглені кути
        borderSide: const BorderSide(
          color: kMedium, // Колір межі при стандартному стані
          width: 2.0, // Ширина межі
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), // Закруглені кути
        borderSide: const BorderSide(
          color: kMedium, // Колір межі при активному стані
          width: 2.0, // Ширина межі
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), // Закруглені кути
        borderSide: BorderSide(
          color: kMedium.withOpacity(0.8), // Колір межі при фокусуванні
          width: 2.0, // Ширина межі
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return kMedium.withOpacity(0.6); // Колір фону при натисканні
            } else if (states.contains(WidgetState.hovered)) {
              return kMedium.withOpacity(0.8); // Колір фону при наведенні
            }
            return kMedium; // Основний колір фону кнопки
          },
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          Colors.white, // Колір тексту кнопки
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Закруглені кути
          ),
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w900,
          color: kDark,
          fontFamily: 'Montserrat'),
      displayMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
          color: kDark,
          fontFamily: 'Montserrat'),
      bodyLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat'),
      bodyMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat'),
      bodySmall: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.w500, color: kDark, fontFamily: 'Montserrat'),
      labelLarge: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Montserrat'),
    ),
  );
}
