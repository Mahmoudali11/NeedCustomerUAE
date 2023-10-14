import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/accounts/foget_password.dart';
import 'package:need/ui/views/accounts/signup.dart';
import 'package:need/ui/views/app_navigation.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/ui/widgets/password-form-field.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/validation.dart';

import '../../../generated/l10n.dart';
import '../../widgets/common.dart';
import '../../widgets/custom_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(microseconds: 500), () {
      BlocProvider.of<AppTheme>(context).updateTheme(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bIns=MediaQuery.viewInsetsOf(context).bottom;
    final navigationManager=NavManager(context);

    return Scaffold(
      body: Container(
        padding: AppTheme.paddingMarginL,
        width: double.maxFinite,
        child: Column(
          children: [
            const VerticalSpace(
              spaceType: SpaceType.el,
            ),
            bIns<=0?   Column(
            children: [
              Image.asset(
                  "assets/logo.png",
                  width: mq.width / 2.3,
                  height: mq.width / 2.3,
                ),
                const VerticalSpace(spaceType: SpaceType.m),
                Text(
                  S.of(context).needFacilities,
                  style:
                      textTheme.headlineLarge?.copyWith(color: AppTheme.mainColor),
                ),
                const VerticalSpace(spaceType: SpaceType.es),
                Text(
                  S.of(context).techniciansAtDoorstep,
                  style:
                      textTheme.bodyMedium?.copyWith(color: AppTheme.secondColor),
                ),
            ],
          ):Container(),
            CustomFormField(
              controller: user,
              hint: S.of(context).username,
              validator: Validator.isValidName,
            ),
            PasswordTextField(
              controller: password,
              hint: S.of(context).password,
              validator: Validator.isValidName,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextBtn(
                textStyle: textTheme.bodyLarge,
                color: AppTheme.secondColor,
                name: S.of(context).forgotPassword,
                action: (){
                  navigationManager.navPush(const ForgetPassword());
                },
              ),
            ),
            MainButton(
              name: S.of(context).signIn,
              action: () {
                navigationManager.navPushName("/home");
              },
            ),
            CustomTextBtn(
              textStyle: textTheme.bodyLarge,
              color: AppTheme.secondColor,
              name: S.of(context).register,
              action: (){
                navigationManager.navPush(const SignUp());

              },
            ),
            const Spacer(),
            Align(alignment: Alignment.centerRight,child:   Text("Powered by www.need.ae",

            style: textTheme.titleLarge?.copyWith(

              color: AppTheme.secondColor
            ),))
          ],
        ),
      ),
    );
  }
}
