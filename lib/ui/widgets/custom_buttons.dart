
import 'package:flutter/material.dart';

import '../../bl/blocs/theme/app_theme_cubit.dart';

class MainButton extends StatelessWidget {
  final String name;
  final Function()? action;
  final Color? textColor;
  final Color? bgColor;
  final double? w;
  final double? h;
  final EdgeInsets? padding;

  const MainButton({
    super.key,
    required this.name,
      this.action, this.textColor, this.bgColor, this.w, this.h, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height / 17;
    return Padding(
      padding:padding?? AppTheme.paddingMarginS,
      child: ElevatedButton(
        onPressed: action,
        style: ButtonStyle(
          backgroundColor:  MaterialStateProperty.all( action==null?AppTheme.grey: bgColor??AppTheme.mainColor),
          minimumSize: MaterialStateProperty.all(Size(w??double.maxFinite, h??height)),
        ),
        child: Text(name,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(

              color:textColor?? AppTheme.white
          ),),
      ),
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  final Function()? action;
  const CustomTextBtn({
    super.key,
    required this.textStyle, required this.name, this.color,   this.action,
  });
  final Color? color;
  final TextStyle? textStyle;
  final String name;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: action,
        child: Text(
          name,
            style:   textStyle?.copyWith(

              color: color
            )
        ));
  }
}

