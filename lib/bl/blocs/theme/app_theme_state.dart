import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';

class AppThemeState{
  
  
    ThemeData? appTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppTheme.white,
   textTheme: const TextTheme(
  headlineLarge:
  TextStyle(fontSize: 26, color: Colors.black),
  headlineMedium:
  TextStyle(fontSize: 22, color: Colors.black),
  bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
  bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  titleLarge: TextStyle(fontSize: 10, color: Colors.black),
  titleMedium:
  TextStyle(fontSize: 8, color: Colors.black),
  ));
    AppThemeState({this.appTheme});
  
  
}