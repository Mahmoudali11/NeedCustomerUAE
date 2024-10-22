import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/all_enquires.dart';
import 'package:need/bl/modles/save_enquiry_req.dart';
import 'package:need/constans/networks.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/ui/views/booking/booking_summry.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/text_formatting.dart';

import '../../../bl/blocs/accounts/account_cubit.dart';
import '../../../generated/l10n.dart';
import '../../widgets/app_common.dart';
import '../booking/book_service.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController search = TextEditingController();
  late ServiceCubit serviceCubit;

  @override
  void initState() {


    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    BlocProvider.of<AccountCubit>(context).getUserDetails();

    Future.delayed(const Duration(seconds: 1), () {
      serviceCubit.getUserEnquires(AccountState.userDetails!.userId!);
      serviceCubit.getOffers();
    });
    super.initState();
  }



  @override
  void dispose() {
    search.dispose();
     super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mq = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppTheme.white,
                backgroundImage: AssetImage("assets/logo.png"),
                radius: 30,
              ),
              const HorizontalSpace(spaceType: SpaceType.es),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Need Customer",
                    style: textTheme.headlineMedium
                        ?.copyWith(color: AppTheme.mainColor),
                  ),
                  Text(
                    S.of(context).showProfile,
                    style: textTheme.bodyMedium,
                  ),
                ],
              )
            ],
          ),
          const VerticalSpace(spaceType: SpaceType.m),
          SearchWidget(
            search: search,
          ),
          //Adds
          Titles(
            textTheme: textTheme,
            name: S.of(context).latestOffers,
          ),

          BlocBuilder<ServiceCubit, ServiceState>(
            buildWhen: (o,n)=>n.latestServiceE==LatestServiceE.getOffers,
            builder: (context, state) {

              if(state.reqStatus==ReqStatus.inProgress||state.reqStatus==ReqStatus.notLaunched){
                return const CustomProgressInd();
              }
              else if( state.reqStatus==ReqStatus.fail){

                return Center(child: Text("${S.of(context).somethingError}:${state.errorMessage}"));
              }
              else if(state.offersRes==null||state.offersRes?.data?.length==0){
                return  const Center(child: Text("No Offer right now!"));
              }
              return SizedBox(
                width: double.maxFinite,
                height: mq.height * .2,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.offersRes!.data
                      .map((e) => Padding(
                            padding: AppTheme.paddingMarginS,
                            child: GestureDetector(
                              onTap: (){
                                serviceCubit.serServName=e.name;
                                serviceCubit.setServiceId=e.offerId;
                                NavManager(context)
                                    .navPush(const BookService());
                              },
                              child: Stack(
                                children: [
                                  CustomCachedNImg(
                                    w: mq.width * .55,
                                    h: double.maxFinite,
                                    image: NetworkApis.base+"offers/"+e.image,
                                  ),
                                  Positioned(
                                    top: 7,
                                    right: 7,
                                    child: Container(
                                        padding: AppTheme.paddingMarginES,
                                        decoration: BoxDecoration(
                                            color: AppTheme.white.withOpacity(.9),
                                            borderRadius: BorderRadius.circular(
                                                AppTheme.borderRS)),
                                        child: Text(e.name??"")),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
          ),
          Titles(
            textTheme: textTheme,
            name: S.of(context).latestBooking,
          ),
          BlocBuilder<ServiceCubit, ServiceState>(
            buildWhen: (o, n) =>
                n.latestServiceE == LatestServiceE.getUserEnquires,
            builder: (context, state) {
              if (state.reqStatus == ReqStatus.inProgress||state.reqStatus==ReqStatus.notLaunched) {
                return const CustomProgressInd();
              } else if (state.reqStatus == ReqStatus.fail) {
                return Center(
                    child: Text(
                  "${S.of(context).somethingError} ${state.errorMessage}",
                ));
              } else if (state.allUserEnquiries == null ||
                  state.allUserEnquiries?.data == null ||
                  state.allUserEnquiries?.data?.length == 0) {
                return Center(
                    child: Text(
                  S.of(context).noPreviousBookingTryNewBooking,
                ));
              }
              return SavedBookInfo(
                showDetails: false,
                req: state.allUserEnquiries?.data?.last,
                textTheme: textTheme,
                onTap: () {
                  ServiceState.selectedSavedEnq=state.allUserEnquiries?.data?.last;

                  NavManager(context).navPush(const BookSummery(
                    showProceed: false,
                  ));
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  final SaveEnquiryReq? req;

  const BookingInfo({
    super.key,
    required this.textTheme,
    this.showDetails = false,
    this.onTap,
    required this.req,
  });

  final bool showDetails;
  final TextTheme textTheme;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var _servCu = BlocProvider.of<ServiceCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRS),
          child: Column(
            children: [
              Container(
                padding: AppTheme.paddingMarginES,
                decoration: const BoxDecoration(color: AppTheme.secondColor),
                child: Center(
                  child: Text(
                    _servCu.serName ?? "",
                    style:
                        textTheme.bodyMedium?.copyWith(color: AppTheme.white),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, topRight: Radius.zero)),
                child: Column(
                  children: [
                    NameValueText(
                      name: S.of(context).bookingId,
                      value: req?.name ?? "",
                    ),
                    NameValueText(
                      name: S.of(context).bookingData,
                      value: TextFormatting.formatDate(DateTime.tryParse(req?.bookingDate??DateTime.now().toIso8601String())),
                    ),
                    NameValueText(
                      name: S.of(context).bookingTime,
                      value: TextFormatting.formatTime(DateTime.tryParse(req?.bookingDate??DateTime.now().toIso8601String())),
                    ),
                    showDetails
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NameValueText(
                                name: S.of(context).bookingStatus,
                                value: "On Going",
                              ),
                              NameValueText(
                                name: S.of(context).bookingLocation,
                                value: req?.address ?? "",
                              ),
                              NameValueText(
                                name: S.of(context).bookingNotes,
                                value: req?.details ?? "",
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SavedBookInfo extends StatelessWidget {
  final Data? req;

  const SavedBookInfo({
    super.key,
    required this.textTheme,
    this.showDetails = false,
    this.onTap,
    required this.req,
  });

  final bool showDetails;
  final TextTheme textTheme;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var _servCu = BlocProvider.of<ServiceCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRS),
          child: Column(
            children: [
              Container(
                padding: AppTheme.paddingMarginES,
                decoration: const BoxDecoration(color: AppTheme.secondColor),
                child: Center(
                  child: Text(
                    S.of(context).details,
                    style:
                        textTheme.bodyMedium?.copyWith(color: AppTheme.white),
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(0),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.zero, topRight: Radius.zero)),
                child: Column(
                  children: [
                    NameValueText(
                      name: S.of(context).bookingId,
                      value: req?.id ?? "",
                    ),
                    NameValueText(
                      name: S.of(context).refno,
                      value: req?.refno ?? " ",
                    ),
                    NameValueText(
                      name: S.of(context).bookingData,
                      value: TextFormatting.formatDate(req?.bookingDate),
                    ),
                    NameValueText(
                      name: S.of(context).bookingTime,
                      value: TextFormatting.formatTime(req?.bookingDate),
                    ),
                    showDetails
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              NameValueText(
                                name: S.of(context).bookingStatus,
                                value: req?.requestStatus ?? "Unknown",
                              ),
                              NameValueText(
                                name: S.of(context).bookingLocation,
                                value: req?.address ?? "Unknown",
                              ),
                              NameValueText(
                                name: S.of(context).bookingNotes,
                                value: req?.notes ?? "Unknown",
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCachedNImg extends StatelessWidget {
  static const defImage =
      "https://img.freepik.com/free-photo/male-electrician-works-switchboard-with-electrical-connecting-cable_169016-15090.jpg";
  final String? image;
  final double w;
  final double h;

  const CustomCachedNImg({
    super.key,
    this.image,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.borderRS),
      child: CachedNetworkImage(
        height: h,
        width: w,
        fit: BoxFit.cover,
        imageUrl: image ??
            "https://img.freepik.com/free-photo/male-electrician-works-switchboard-with-electrical-connecting-cable_169016-15090.jpg",
        placeholder: (context, v) => const CustomProgressIndicatorM(),
        errorWidget: (context,a,b){
          return Container(color: AppTheme.mainColor.withOpacity(.2),child: Center(child: Text("Image broken"))

         ,);
        },
      ),
    );
  }
}
