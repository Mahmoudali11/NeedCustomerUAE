import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/log_req.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/ui/views/accounts/foget_password.dart';
import 'package:need/ui/views/accounts/signup.dart';
import 'package:need/ui/views/app_navigation.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/ui/widgets/password-form-field.dart';
import 'package:need/ui/widgets/show_custom.dart';
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

    _accountCubit = BlocProvider.of<AccountCubit>(context);
    Future.delayed(const Duration(microseconds: 500), () {
      BlocProvider.of<AppTheme>(context).updateTheme(context);
    });
    PrefManager.getValue(PrefManager.userDetails).then((value) {
      if(value!=null){
        _accountCubit.getUserDetails();
         NavManager(context).navPushNameRep("/home");

      }
    });
  }

  final fKey = GlobalKey<FormState>();
  late AccountCubit _accountCubit;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final bIns = MediaQuery.viewInsetsOf(context).bottom;
    final navigationManager = NavManager(context);

    return Scaffold(
     // resizeToAvoidBottomInset: false,
      body: Container(
        padding: AppTheme.paddingMarginL.copyWith(bottom: 5),
        width: double.maxFinite,
        child: Form(
          key: fKey,
          child: Column(
            children: [
              const VerticalSpace(
                spaceType: SpaceType.l,
              ),
              bIns <= 0
                  ? Column(
                      children: [
                        Image.asset(
                          "assets/logo.png",
                          width: mq.height * .15,
                          height: mq.height * .15,
                        ),
                        const VerticalSpace(spaceType: SpaceType.m),
                        Text(
                          S.of(context).needFacilities,
                          style: textTheme.headlineLarge
                              ?.copyWith(color: AppTheme.mainColor),
                        ),
                        const VerticalSpace(spaceType: SpaceType.es),
                        Text(
                          S.of(context).techniciansAtDoorstep,
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.secondColor),
                        ),
                      ],
                    )
                  : Container(),
              CustomFormField(
                controller: user,
                hint: S.of(context).username,
                errorMessage: S.of(context).thisFieldRequired,
                validator: Validator.isValidName,
              ),
              PasswordTextField(
                controller: password,
                errorMessage: S.of(context).thisFieldRequired,
                hint: S.of(context).password,
                validator: Validator.isValidName,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextBtn(
                  textStyle: textTheme.bodyLarge,
                  color: AppTheme.secondColor,
                  name: S.of(context).forgotPassword,
                  action: () {
                    navigationManager.navPush(const ForgetPassword());
                  },
                ),
              ),
              BlocListener<AccountCubit, AccountState>(
                  listenWhen: (o, n) => n.latestAcE == LatestAcE.login,
                  listener: (ctx, state) {
                    if (state.reqStatus == ReqStatus.success) {
                      navigationManager.navPushNameRep("/home");
                      ShowCustom(context)
                          .showSnack(S.of(context).successfulResponse);
                    } else if (state.reqStatus == ReqStatus.fail) {
                      ShowCustom(context)
                          .showSnack("${S.of(context).operationFailed} ${state.errorMessage}");
                    }
                  },
                  child:Container()
              ),
              BlocBuilder<AccountCubit, AccountState>(
                buildWhen: (o, n) => n.latestAcE == LatestAcE.login,

                builder: (context, state) {
                  return state.reqStatus!=ReqStatus.inProgress? MainButton(
                    name: S.of(context).signIn,
                    action: () {
                      if (fKey.currentState?.validate() == true) {
                        _accountCubit.login(LoginReq(
                            username: user.text, password: password.text));
                      }
                    },
                  ):const Center(child: CustomProgressInd(),);
                },
              ),
              CustomTextBtn(
                textStyle: textTheme.bodyLarge,
                color: AppTheme.secondColor,
                name: S.of(context).register,
                action: () {
                  navigationManager.navPush(const SignUp());
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
      ),
    );
  }
}
