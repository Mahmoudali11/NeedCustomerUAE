import 'package:flutter/material.dart';
import 'package:need/ui/views/home/home.dart';

import '../../../utils/navigations.dart';
import 'booking_summry.dart';

class MyBooking extends StatelessWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListView(
      children: List.generate(
          5,
          (index) => BookingInfo(
                textTheme: textTheme,
                req: null,
                onTap: () {
                  NavManager(context).navPush(const BookSummery());
                },
              )),
    );
  }
}
