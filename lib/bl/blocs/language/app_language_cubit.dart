import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';


enum Languages { en, ar }

class AppLanguageCubit extends Cubit<Locale> {
  AppLanguageCubit() : super(const Locale("en"));

  changeAppLanguage(Languages v) {
    emit(Locale(v.name));
  }
}
