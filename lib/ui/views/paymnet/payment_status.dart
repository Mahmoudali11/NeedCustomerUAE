import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/utils/navigations.dart';

import '../../../generated/l10n.dart';

class PaymentStatus extends StatelessWidget {
  const PaymentStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).paymentStatus,
      ),
      body: Container(
        padding: AppTheme.paddingMarginL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(Icons.check_circle,

            weight: 200,size: 120,
                color: AppTheme.mainColor,),
            VerticalSpace(spaceType: SpaceType.es),
            Text(
              S.of(context).bookingSuccess,
              maxLines: 1,
              style:
                  textThem.headlineMedium?.copyWith(color: AppTheme.mainColor),
            ), Text(
              "RefNo:${BlocProvider.of<ServiceCubit>(context).state.saveInqRes?.ref}",
              maxLines: 1,
              style:
                  textThem.headlineMedium?.copyWith(color: AppTheme.mainColor),
            ),
           const  VerticalSpace(spaceType: SpaceType.m),
            Text(
              "Thanks for Choosing Need. Our Technical Team will Contact you Soon",
               textAlign: TextAlign.center,style:
                  textThem.bodyLarge?.copyWith(color: AppTheme.mainColor),
            ),

            const VerticalSpace(spaceType: SpaceType.l),
            MainButton(name: S.of(context).bookMoreServices,
            action: (){
              BlocProvider.of<ServiceCubit>(context).getUserEnquires(AccountState.userDetails?.userId??"");
              NavManager(context).navPopNameUntil("/home");
            },)
          ],
        ),
      ),
    );
  }
}
