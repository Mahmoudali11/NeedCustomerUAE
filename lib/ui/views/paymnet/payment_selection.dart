import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/paymnet/payment_status.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/utils/navigations.dart';

import '../../../generated/l10n.dart';

class PaymentSelection extends StatefulWidget {
  const PaymentSelection({super.key});

  @override
  State<PaymentSelection> createState() => _PaymentSelectionState();
}

class _PaymentSelectionState extends State<PaymentSelection> {
  PaymentOption pO = PaymentOption.cash;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).selectPaymentWay,
      ),
      body: Container(
        padding: AppTheme.paddingMarginM,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio(
                    value: PaymentOption.cash ,
                    groupValue:pO ,
                    onChanged: onSelectPayWay),
                Text(
                  S.of(context).cashOnDelivery,
                  style: textThem.headlineMedium,
                )
              ],
            ),
            Row(
              children: [
                Radio(
                    value: PaymentOption.paymentLink,
                    groupValue:pO,
                    onChanged: onSelectPayWay),
                Text(
                  S.of(context).paymentLink,
                  style: textThem.headlineMedium,
                )
              ],
            ),
            Row(
              children: [
                Radio(
                    value:  PaymentOption.byCard ,
                    groupValue: pO,
                    onChanged: onSelectPayWay),
                Text(
                  S.of(context).card,
                  style: textThem.headlineMedium,
                )
              ],
            ),
           const  VerticalSpace(spaceType: SpaceType.l),
            MainButton(name: "Done",
            action: (){
              
              NavManager(context).navPush(const PaymentStatus());
            },)
          ],
        ),
      ),
    );
  }

  void onSelectPayWay(v) {
                    if (v != null) {
                     setState(() {
                       pO = v;
                     });
                    }
                  }
}

enum PaymentOption { cash, paymentLink, byCard }
