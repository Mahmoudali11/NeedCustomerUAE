import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';

class ShowCustom {
  final BuildContext context;

  ShowCustom(this.context);

  showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: AppTheme.paddingMarginM,
        behavior: SnackBarBehavior.floating,
        content: Text(message)));
  }
}
