import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/resetpasswordemail_req.dart';
import 'package:need/ui/widgets/c_app_bar.dart';

import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/ui/widgets/show_custom.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/validation.dart';

import '../../../constans/requst_status.dart';
import '../../widgets/common.dart';
import '../../widgets/custom_buttons.dart';
import 'package:need/generated/l10n.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController email = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountCubit = BlocProvider.of<AccountCubit>(context);
    Future.delayed(const Duration(microseconds: 500), () {
      BlocProvider.of<AppTheme>(context, listen: false).updateTheme(context);
    });
  }

  late AccountCubit _accountCubit;

  @override
  void dispose() {
    email.dispose();
    newPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final navigationManager = NavManager(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: AppTheme.paddingMarginL,
        width: double.maxFinite,
        child: Column(
          children: [
            const VerticalSpace(spaceType: SpaceType.l),
            CustomFormField(
              controller: email,
              hint: S.of(context).email,
              validator: Validator.isValidName,
            ),
            CustomFormField(
              controller: newPassword,
              hint: S.of(context).password,
              validator: Validator.isValidName,
            ),
            BlocListener<AccountCubit, AccountState>(
                listenWhen: (o, n) => n.latestAcE == LatestAcE.resetPassword,
                listener: (ctx, state) {
                  if (state.reqStatus == ReqStatus.success) {
                    navigationManager.popCurrent();

                    ShowCustom(context).showSnack(S.of(context).resetEmailSent);
                  } else if (state.reqStatus == ReqStatus.fail) {
                    ShowCustom(context).showSnack(
                        "${S.of(context).operationFailed} ${state.errorMessage}");
                  }
                },
                child: Container()),
            const VerticalSpace(
              spaceType: SpaceType.el,
            ),
            BlocBuilder<AccountCubit, AccountState>(
              buildWhen: (o, n) => n.latestAcE == LatestAcE.resetPassword,
              builder: (context, state) {
                return state.reqStatus == ReqStatus.inProgress
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MainButton(
                        name: S.of(context).reset,
                        action: () {
                          _accountCubit.resetPasswordByEmail(
                              ResetPasswordEmailReq(
                                  email: email.text,
                                  newPassword: newPassword.text));
                        },
                      );
              },
            ),
            const Spacer(),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Powered by www.need.ae",
                  style: textTheme.titleLarge
                      ?.copyWith(color: AppTheme.secondColor),
                ))
          ],
        ),
      ),
    );
  }
}
