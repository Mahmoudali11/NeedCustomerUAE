import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/update_pay_req.dart';
import 'package:need/constans/keys.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/ui/views/home/home.dart';
import 'package:need/ui/views/paymnet/payment_selection.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/ui/widgets/show_custom.dart';
import 'package:need/utils/navigations.dart';

import '../../../generated/l10n.dart';

class BookSummery extends StatelessWidget {
  final bool showProceed;

  const BookSummery({super.key, this.showProceed = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).bookSummery,
      ),
      body: Container(
        padding: AppTheme.paddingMarginL,
        child: SingleChildScrollView(
          child: Column(
            children: [
              !showProceed
                  ? SavedBookInfo(
                      req: ServiceState.selectedSavedEnq,
                      textTheme: textTheme,
                      showDetails: true,
                    )
                  : BookingInfo(
                      req:
                          BlocProvider.of<ServiceCubit>(context).saveEnquiryReq,
                      textTheme: textTheme,
                      showDetails: true,
                    ),
              const VerticalSpace(spaceType: SpaceType.m),
              Text(
                S.of(context).thanksForBookingService,
                textAlign: TextAlign.center,
              ),
              BlocListener<ServiceCubit, ServiceState>(
                listener: (o, s) {
                  if (s.reqStatus == ReqStatus.success) {
                    ShowCustom(context)
                        .showSnack(S.of(context).successfulResponse);
                  } else if (s.reqStatus == ReqStatus.fail) {
                    ShowCustom(context).showSnack(
                        S.of(context).operationFailed + " ${s.errorMessage}");
                  }
                },
                listenWhen: (o, n) =>
                    n.latestServiceE == LatestServiceE.updatePayStatus,
                child: Container(),
              ),
              Text(S.of(context).ifYouNeedMoreDetails),
              Text(S.of(context).infoneedae),
              Text(S.of(context).callOrWhatsapp),
              const Text("+971504759695"),
              const VerticalSpace(
                spaceType: SpaceType.es,
              ),
              showProceed
                  ? MainButton(
                      name: S.of(context).proceed,
                      action: () {
                        NavManager(context).navPush(const PaymentSelection());
                      })
                  : BlocBuilder<ServiceCubit,ServiceState>(
                    buildWhen: (o,n)=>n.latestServiceE==LatestServiceE.updatePayStatus,
                    builder: (context,s) {
                      if(s.reqStatus==ReqStatus.inProgress){
                        return const Center(child: CustomProgressInd());
                      }
                      return MainButton(
                          name: "Set To Paid",
                          action: ServiceState.selectedSavedEnq?.requestStatus.toLowerCase() != "paid"
                              ? () {
                                  var value=AccountState.userDetails?.userId;
                                    if (value != null &&
                                        ServiceState.selectedSavedEnq?.id != null) {
                                      BlocProvider.of<ServiceCubit>(context)
                                          .updateStatus(UpdateStatusReq(
                                              requestId: ServiceState
                                                  .selectedSavedEnq!.id))
                                          .then((_) {
                                        BlocProvider.of<ServiceCubit>(context)
                                            .getUserEnquires(value);
                                        NavManager(context)
                                            .navPopNameUntil("/home");
                                      });
                                    }

                                }
                              : null);
                    }
                  )
            ],
          ),
        ),
      ),
    );
  }
}
