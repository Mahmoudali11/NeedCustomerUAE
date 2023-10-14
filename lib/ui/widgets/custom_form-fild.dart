import 'package:flutter/material.dart';

import '../../bl/blocs/theme/app_theme_cubit.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? iconData;
  final Widget? widget;
  final String? Function(String?)? validator;
  final bool? isReadOnly;
  final int? maxLines;
  final TextInputType? inputType;
  final String? errorMessage;
  final String? hint;
  final VoidCallback? onTap;

  const CustomFormField(
      {Key? key,
      this.validator,
      required this.controller,
      this.iconData,
      this.isReadOnly,
      this.inputType,
      this.hint,
      this.errorMessage,
      this.onTap,
      this.widget,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: AppTheme.paddingMarginM.copyWith(

            bottom: 9
        ),
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            keyboardType: inputType,
            readOnly: isReadOnly ?? false,
            maxLines: maxLines,
            validator: (v) {
              if (validator != null && validator!(v) == null) {
                return null;
              }
              return errorMessage;
            },
            onTap: onTap,
            controller: controller,
            cursorColor: AppTheme.mainColor,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppTheme.secondColor),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.blackColor),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.blackColor),
              ),
              suffixIcon: iconData == null
                  ? null
                  : Icon(
                      iconData,
                      color: AppTheme.mainColor,
                    ),
            )));
  }
}
