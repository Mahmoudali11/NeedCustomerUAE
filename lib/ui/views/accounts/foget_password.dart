import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';

import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/ui/widgets/show_custom.dart';
 import 'package:need/utils/navigations.dart';
import 'package:need/utils/validation.dart';

import '../../widgets/common.dart';
import '../../widgets/custom_buttons.dart';
import 'package:need/generated/l10n.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController user = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(microseconds: 500), () {
      BlocProvider.of<AppTheme>(context, listen: false).updateTheme(context);
    });
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery
        .of(context)
        .size;
    final textTheme = Theme
        .of(context)
        .textTheme;
    final navigationManager = NavManager(context);

    return Scaffold(
      body: Container(
        padding: AppTheme.paddingMarginL,
        width: double.maxFinite,
        child: Column(
          children: [
            const VerticalSpace(
              spaceType: SpaceType.el,
            ),
            const VerticalSpace(spaceType: SpaceType.l),
            CustomFormField(
              controller: user,
              hint: S
                  .of(context)
                  .username,
              validator: Validator.isValidName,
            ),
            const VerticalSpace(
              spaceType: SpaceType.el,
            ),

            MainButton(
              name: S.of(context).reset,
              action: () 
              {
                ShowCustom(context).showSnack(S.of(context).resetEmailSent);
                navigationManager.popCurrent();

              },
            ),

            const Spacer(),
            Align(alignment: Alignment.centerRight,
                child: Text("Powered by www.need.ae",

                  style: textTheme.titleLarge?.copyWith(

                      color: AppTheme.secondColor
                  ),))
          ],
        ),
      ),
    );
  }
}
