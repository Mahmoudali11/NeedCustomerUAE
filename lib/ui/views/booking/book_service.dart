import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/booking/booking_summry.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/text_formatting.dart';
import 'package:need/utils/validation.dart';

import '../../../generated/l10n.dart';

class BookService extends StatefulWidget {
  const BookService({super.key});

  @override
  State<BookService> createState() => _BookServiceState();
}

class _BookServiceState extends State<BookService> {
  TextEditingController bookNotes = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController city = TextEditingController();
  String? bookDate;

  @override
  void dispose() {
    bookNotes.dispose();
    city.dispose();
    date.dispose();
    time.dispose();
    super.dispose();
  }

  @override
  void initState() {
    city.text = address.first;
    super.initState();
  }

  var address = ["Abu Dhabi", "Dubai"];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: S.of(context).bookService,
      ),
      body: Container(
        padding: AppTheme.paddingMarginM,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomFormField(
              controller: bookNotes,
              hint: S.of(context).bookNotes,
              maxLines: 5,
              validator: Validator.isValidName,
            ),
            Padding(
              padding: AppTheme.paddingMarginS,
              child: DropdownButton(
                  iconEnabledColor: AppTheme.mainColor,
                  isExpanded: true,
                  hint: Text(
                    city.text,
                    style: textTheme.bodyLarge,
                  ),
                  items: address
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: textTheme.bodyLarge,
                            ),
                          ))
                      .toList(),
                  onChanged: (v) {
                    city.text = v ?? "";
                    setState(() {});
                  }),
            ),

            CustomFormField(
                controller: date,
                isReadOnly: true,
                hint: S.of(context).selectDate,
                validator: Validator.isValidName,
                onTap: () async {
                  var d = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (d != null) {
                    setState(() {
                      date.text = TextFormatting.formatDate(d);
                    });
                  }
                },
                iconData: Icons.date_range),
            CustomFormField(
                controller: time,
                isReadOnly: true,
                hint: S.of(context).selectTime,
                validator: Validator.isValidName,
                onTap: () async {
                  var t = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: DateTime.now().hour,
                          minute: DateTime.now().minute));
                  if (t != null) {
                    setState(() {
                      time.text = t.format(context);
                    });
                  }
                },
                iconData: Icons.access_time),
            const Spacer(),

            MainButton(
                name: S.of(context).book,
                action: () {
                  NavManager(context).navPush(const BookSummery());
                })
          ],
        ),
      ),
    );
  }
}
