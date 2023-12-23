import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/paymnet/payment_status.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/utils/navigations.dart';

import '../../../constans/requst_status.dart';
import '../../../generated/l10n.dart';
import '../../widgets/show_custom.dart';

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
                    value: PaymentOption.cash,
                    groupValue: pO,
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
                    groupValue: pO,
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
                    value: PaymentOption.byCard,
                    groupValue: pO,
                    onChanged: onSelectPayWay),
                Text(
                  S.of(context).card,
                  style: textThem.headlineMedium,
                )
              ],
            ),
            BlocListener<ServiceCubit, ServiceState>(
                listenWhen: (o, n) =>
                    n.latestServiceE == LatestServiceE.bookService,
                listener: (ctx, state) {
                  if (state.reqStatus == ReqStatus.success) {
                    NavManager(context).navPush(const PaymentStatus());
                    ShowCustom(context)
                        .showSnack(S.of(context).successfulResponse);
                  } else if (state.reqStatus == ReqStatus.fail) {
                    ShowCustom(context).showSnack(
                        S.of(context).operationFailed +
                            (state.errorMessage ?? ""));
                  }
                },
                child: Container()),
            const VerticalSpace(spaceType: SpaceType.l),
            BlocBuilder<ServiceCubit, ServiceState>(
              builder: (context, state) {
                return state.reqStatus!=ReqStatus.inProgress? MainButton(
                  name: S.of(context).done,
                  action: () {
           var servCuibit=         BlocProvider.of<ServiceCubit>(context);
                    if(servCuibit.saveEnquiryReq!=null){
                    servCuibit.saveEnquiry(servCuibit.saveEnquiryReq!);

                  }
                  },
                ):const CustomProgressInd();
              },
            )
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
