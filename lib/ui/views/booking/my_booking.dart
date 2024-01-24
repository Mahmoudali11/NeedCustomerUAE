import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/modles/all_enquires.dart';
import 'package:need/ui/views/home/home.dart';

import '../../../constans/requst_status.dart';
import '../../../generated/l10n.dart';
import '../../../utils/navigations.dart';
import '../../widgets/common.dart';
import 'booking_summry.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  late AccountCubit accountCubit;
  late ServiceCubit serviceCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    accountCubit = BlocProvider.of<AccountCubit>(context);
     serviceCubit.getUserEnquires(AccountState.userDetails!.userId!);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return RefreshIndicator(
      onRefresh: ()async{
        serviceCubit.getUserEnquires(AccountState.userDetails!.userId!);

      },
      child: BlocBuilder<ServiceCubit, ServiceState>(
        buildWhen: (o, n) =>
            n.latestServiceE == LatestServiceE.getUserEnquires
            ,
        builder: (context, state) {
          if (state.reqStatus == ReqStatus.inProgress) {
            return const CustomProgressInd();
          }

          if (state.reqStatus == ReqStatus.success) {
            var enquiries = state.allUserEnquiries?.data;

            if (enquiries == null || enquiries.isEmpty) {
              return Center(
                child: Text(S.of(context).noDataFount),
              );
            }
            return ListView(
                children: (enquiries ?? <Data>[]).reversed
                    .map((e) => GestureDetector(
                          onTap: () {
                            ServiceState.selectedSavedEnq=e;
                             NavManager(context).navPush(const BookSummery(showProceed: false,));
                          },
                          child: SavedBookInfo(req: e, textTheme: textTheme,),
                        ))
                    .toList());
          }

          return Center(
            child: GestureDetector(onTap:(){
              serviceCubit.getUserEnquires(AccountState.userDetails!.userId!);


            },child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${S.of(context).somethingError}:${state.errorMessage}"),
               const Padding(
                 padding: EdgeInsets.all(8.0),
                 child: Icon(Icons.refresh),
               )
               ],
            )),
          );
        },
      ),
    );
  }
}
