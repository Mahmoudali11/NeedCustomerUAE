import 'package:flutter/material.dart';
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
              "Booking Success",
              style:
                  textThem.headlineMedium?.copyWith(color: AppTheme.mainColor),
            ),
            const VerticalSpace(spaceType: SpaceType.l),
            MainButton(name: S.of(context).bookMoreServices,
            action: (){
              NavManager(context).navPopNameUntil("/home");
            },)
          ],
        ),
      ),
    );
  }
}
