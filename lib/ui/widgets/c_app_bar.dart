import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final List<Widget>? actions;
  final bool? centerTitle;
  const CustomAppBar({super.key, this.title,   this.actions,this.centerTitle});

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      
      title: Text(title??"",

      style: Theme.of(context).textTheme.headlineMedium,),
      actions: actions,
      centerTitle: centerTitle,
      
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
