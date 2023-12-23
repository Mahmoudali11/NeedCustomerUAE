import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:need/bl/blocs/theme/app_theme_state.dart';

class AppTheme extends Cubit<AppThemeState> {
  AppTheme() : super(AppThemeState(appTheme:_appTheme ));

  static const mainColor = Color(0xff618D3E);
  static const secondColor = Color(0xff78C042);
  static const blueColor=Colors.blueAccent;
  static const deepPurple=Colors.deepPurple;
   static const blackColor = Colors.black;
  static const grey = Colors.grey;
  static const white = Colors.white;
  static const _eLargeFS = 26;
  static const _largeFS = 22;
  static const _eMediumFS = 18;
  static const _mediumFS = 14;
  static const _smallFS = 10;
  static const _eSmallFS = 8;
  static const paddingMarginL=  EdgeInsets.all(30);
  static const paddingMarginM=  EdgeInsets.all(15);
  static const paddingMarginS=  EdgeInsets.all(11);
  static const paddingMarginES=  EdgeInsets.all(5);

 static const double borderRL=30;
 static const double borderRM=20;
 static const double borderRS=15;

  static final ThemeData _appTheme = ThemeData(
      useMaterial3: true,
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

  updateTheme(BuildContext context) {
    double scale = (MediaQuery.sizeOf(context).width / 360) * .91;
    if(scale<=0){
      scale=.9;
    }
    ThemeData appTheme = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.mainColor,background: AppTheme.white),   textTheme: TextTheme(
          headlineLarge:
              TextStyle(fontSize: _eLargeFS * scale, fontWeight: FontWeight.w700,color: blackColor),
          headlineMedium:
              TextStyle(fontSize: _largeFS * scale,fontWeight: FontWeight.w700, color: blackColor),
          bodyLarge: TextStyle(fontSize: _eMediumFS * scale,fontWeight: FontWeight.w400, color: blackColor),
          bodyMedium: TextStyle(fontSize: _mediumFS * scale,fontWeight: FontWeight.w400, color: blackColor),
          bodySmall: TextStyle(fontSize: _mediumFS * scale,fontWeight: FontWeight.w400, color: blackColor),
          titleLarge: TextStyle(fontSize: _smallFS * scale,fontWeight: FontWeight.w400, color: blackColor),
          titleMedium:              TextStyle(fontSize: _eSmallFS * scale,fontWeight: FontWeight.w300, color: blackColor),

      titleSmall:
              TextStyle(fontSize: _eSmallFS * scale,fontWeight: FontWeight.w300, color: blackColor),
        ));
     emit(AppThemeState(appTheme: appTheme));
  }
}
