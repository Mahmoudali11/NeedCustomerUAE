import 'package:flutter/material.dart';

import '../../bl/blocs/theme/app_theme_cubit.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData? iconData;
  final String? Function(String?)? validator;
  final String? hint;
  final String? errorMessage;
  final bool? isReadOnly;
  final Function()? onTap;

  const PasswordTextField(
      {Key? key,
      required this.controller,
      this.iconData,
      this.validator,
      this.hint,
      this.errorMessage,
      this.isReadOnly, this.onTap})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isSecure = true;

  void changeVisibility() {
    setState(() {
      isSecure = !isSecure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppTheme.paddingMarginM.copyWith(bottom: 9),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        obscureText: isSecure,
        onTap: widget.onTap,
        validator: (v) {
          if (widget.validator == null) {
            return null;
          }
          if (widget.validator != null && widget.validator!(v) == null) {
            return null;
          }
          return widget.errorMessage;
        },
        controller: widget.controller,
        readOnly: widget.isReadOnly ?? false,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppTheme.secondColor),
          suffixIcon: IconButton(
            focusColor: AppTheme.mainColor,
            onPressed: changeVisibility,
            icon: Icon(
              isSecure ? Icons.visibility_off : Icons.visibility,
              color: AppTheme.mainColor,
              // color: AppTheme.iconColor,
            ),
          ),
          //suffixIcon: Icon(widget.iconData,color: AppTheme.mainColor,),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.blackColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.blackColor),
          ),
        ),
      ),
    );
  }
}
