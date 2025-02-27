import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    //custom colors
    //it is accessed by the Activity screen by using the " Theme.of(context).colorScheme.background"
    colorScheme: ColorScheme.light(
      background: Color(0xfff1f1f1),
      primary: Color(0xffe4e3e3),
      secondary:Color(0xfffafafa),
      tertiary:Colors.black87,
    ),


    //specific elements theme
    brightness: Brightness.light,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffdcffd1),
        foregroundColor: Colors.black,
      ),
    ),
  );










  static final ThemeData darkTheme = ThemeData(
    //custom colors
    //it is accessed by the Activity screen by using the " Theme.of(context).colorScheme.background"
    colorScheme: ColorScheme.dark(
      background: Color(0xff1b1b1b),
      primary: Color(0xff3a3a3a),
      secondary:Color(0xff5a5a5a),
      tertiary: Colors.white,
    ),


    //specific elements theme
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xff263238),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff3a5033),
        foregroundColor: Colors.white,
      ),
    ),
  );
}