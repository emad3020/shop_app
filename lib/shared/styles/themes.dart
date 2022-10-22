import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: HexColor('333739'),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: defaultColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor('333739'),
        elevation: 20.0),
    scaffoldBackgroundColor: HexColor('333739'),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    fontFamily: 'cairo');

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 20.0),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  ),
  fontFamily: 'cairo',
);
