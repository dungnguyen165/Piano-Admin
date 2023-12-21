import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: lightAppBarTheme(),
    bottomAppBarTheme: lightBottomAppBarTheme(),
    scaffoldBackgroundColor: Colors.white,
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    appBarTheme: darkAppBarTheme(),
    bottomAppBarTheme: darkBottomAppBarTheme(),
    scaffoldBackgroundColor: Colors.white,
  );
}

AppBarTheme lightAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  );
}

AppBarTheme darkAppBarTheme() {
  return const AppBarTheme(
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
  );
}

BottomAppBarTheme lightBottomAppBarTheme() {
  return const BottomAppBarTheme();
}

BottomAppBarTheme darkBottomAppBarTheme() {
  return const BottomAppBarTheme();
}
