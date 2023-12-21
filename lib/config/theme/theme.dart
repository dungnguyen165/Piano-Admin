import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      useMaterial3: true,
      appBarTheme: appBarTheme(),
      bottomAppBarTheme: bottomAppBarTheme(),
      scaffoldBackgroundColor: Colors.white);
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18));
}

BottomAppBarTheme bottomAppBarTheme() {
  return const BottomAppBarTheme();
}
