import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/booking/booking_summry.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/text_formatting.dart';

import '../../../generated/l10n.dart';
import '../../widgets/app_common.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

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

          SizedBox(
            width: double.maxFinite,
            height: mq.height * .2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ["Electrician", "IT/Services"]
                  .map((e) => Padding(
                        padding: AppTheme.paddingMarginS,
                        child: Stack(
                          children: [
                            CustomCachedNImg(w: mq.width*.55,h: double.maxFinite,),
                            Positioned(
                              top: 7,
                              right: 7,
                              child: Container(
                                  padding: AppTheme.paddingMarginES,
                                  decoration: BoxDecoration(
                                      color: AppTheme.white.withOpacity(.9),
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.borderRS)),
                                  child: Text(e)),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Titles(
            textTheme: textTheme,
            name: S.of(context).latestBooking,
          ),
          BookingInfo(textTheme: textTheme,onTap: (){

            NavManager(context).navPush(const BookSummery());
          },)
        ],
      ),
    );
  }
}

class BookingInfo extends StatelessWidget {
  const BookingInfo({
    super.key,
    required this.textTheme,  this.showDetails=false, this.onTap,
  });
  final bool showDetails;
  final TextTheme textTheme;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
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
                    "Electrical/Service",
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
                      value: "12172",
                    ),    NameValueText(
                      name: S.of(context).bookingData,
                      value: TextFormatting.formatDate(DateTime.now()),
                    ),
                    NameValueText(
                      name: S.of(context).bookingTime,
                      value: TextFormatting.formatTime(DateTime.now()),
                    ),
                  showDetails?  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NameValueText(
                          name: S.of(context).bookingStatus,
                          value: "On Going",
                        ),
                        NameValueText(
                          name: S.of(context).bookingLocation,
                          value: "Abu Dhabi, Electra Street",
                        ),

                        NameValueText(
                          name: S.of(context).bookingNotes,
                          value: "Fixing some plugin problems Fixing some plugin problem",
                        ),
                      ],
                    ):Container(),
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
  static const defImage= "https://img.freepik.com/free-photo/male-electrician-works-switchboard-with-electrical-connecting-cable_169016-15090.jpg";
  final String? image;
  final double w;
  final double h;
  const CustomCachedNImg({
    super.key,
      this.image, required this.w, required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(AppTheme.borderRS),
      child: CachedNetworkImage(
        height: h,
        width: w,
        fit: BoxFit.cover,
        imageUrl:
            image??"https://img.freepik.com/free-photo/male-electrician-works-switchboard-with-electrical-connecting-cable_169016-15090.jpg",
        placeholder: (context, v) =>
            const CustomProgressIndicatorM(),
      ),
    );
  }
}
