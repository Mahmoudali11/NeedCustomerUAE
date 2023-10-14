import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/utils/navigations.dart';

import '../../../generated/l10n.dart';
import '../../../utils/validation.dart';
import '../../widgets/password-form-field.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController currentPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).updatePassword,
      ),
      body: Container(
        padding: AppTheme.paddingMarginM,
        child: Column(
          children: [
            PasswordTextField(
              controller: currentPassword,
              errorMessage:
                  "${S.of(context).currentPassword} ${S.of(context).isNotValid}",
              hint: S.of(context).currentPassword,
              validator: Validator.isValidPassword,
            ),
            PasswordTextField(
              controller: password,
              errorMessage:
                  "${S.of(context).password} ${S.of(context).isNotValid}",
              hint: S.of(context).password,
              validator: Validator.isValidPassword,
            ),
            PasswordTextField(
              controller: confirmPassword,
              errorMessage:
                  "${S.of(context).confirmPassword} ${S.of(context).isNotValid}",
              hint: S.of(context).confirmPassword,
              validator: Validator.isValidPassword,
            ),
            const VerticalSpace(spaceType: SpaceType.l),
            MainButton(name: S.of(context).update, action: () {
              NavManager(context).popCurrent();
            })
          ],
        ),
      ),
    );
  }
}
