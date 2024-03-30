import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/save_enquiry_req.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/ui/views/booking/booking_summry.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/ui/widgets/custom_form-fild.dart';
import 'package:need/ui/widgets/show_custom.dart';
import 'package:need/utils/navigations.dart';
import 'package:need/utils/text_formatting.dart';
import 'package:need/utils/validation.dart';

import '../../../constans/keys.dart';
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
  TextEditingController phoneNo = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  String? bookDate;
  late ServiceCubit serviceCubit;
  DateTime selectedDate=DateTime.now();
  TimeOfDay timeOfDay=TimeOfDay.now();


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
    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    phoneNo.text=AccountState.userDetails?.contactNumber??"";
    super.initState();
  }

  var address = ["Abu Dhabi", "Dubai"];
  final fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
       appBar: CustomAppBar(
        title: S.of(context).bookService,
      ),
      body: Container(
        padding: AppTheme.paddingMarginM,
        child: Form(
          key: fKey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormField(
                  controller: bookNotes,
                  hint: S.of(context).bookNotes,
                  maxLines: 5,
                  errorMessage: S.of(context).thisFieldRequired,
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
                    errorMessage: S.of(context).thisFieldRequired,
                    isReadOnly: true,
                    hint: S.of(context).selectDate,
                    validator: Validator.isValidName,
                    onTap: () async {
                      var d = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      if (d != null) {
                        setState(() {
                          date.text = TextFormatting.formatDate(d);
                          selectedDate=d;
                          
                        });
                      }
                    },
                    iconData: Icons.date_range),
                CustomFormField(
                    controller: time,
                    isReadOnly: true,
                    errorMessage: S.of(context).thisFieldRequired,
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
                          timeOfDay=t;
                        });
                      }
                    },
                    iconData: Icons.access_time),
                CustomFormField(
                  controller: location,
                  tapOnIconOnly: true,
                  isReadOnly: false,
                  validator: Validator.isValidAddress,
                  errorMessage:"${S.of(context).bookingLocation} ${S.of(context).isNotValid}",
                  iconData: Icons.add_location_alt,
                  hint: S.of(context).selectYouLocation,
                  maxLines: 5,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return MapLocationPicker(
                            apiKey: CKeys.mapKey,

                            onSuggestionSelected: (v) {
                              if (v?.result.name != null) {
                                location.text = v!.result.name!;
                                NavManager(context).popCurrent();
                              }
                            },
                          );
                        });
                  },
                ),
                Row(
                  children: [
                    CountryCodePicker(
                      countryFilter: ["+971"],
                      favorite: const ["+971"],
                      initialSelection: "+971",
                      onInit: onCountryChange,
                      onChanged: onCountryChange,
                    ),
                    Expanded(
                      child: CustomFormField(
                          errorMessage:
                              "${S.of(context).contactNo} ${S.of(context).isNotValid}",
                          controller: phoneNo,
                          hint: S.of(context).contactNo,
                          validator: Validator.isValidPhone),
                    ),
                  ],
                ),
                const VerticalSpace(spaceType: SpaceType.m),
                MainButton(
                    name: S.of(context).book,
                    action: () {
                      try{
                      if (fKey.currentState?.validate() == true) {
                         var bookingDate=TextFormatting.createDateTime(time.text, date.text);
                         var formattingDateTime=TextFormatting.dateToDateTime(bookingDate);
                        serviceCubit.setSaveReq = SaveEnquiryReq(

                            name: AccountState.userDetails?.userName ?? "",
                            mobile: "${countryCode.text}${phoneNo.text}",
                            service: serviceCubit.selectedServiceId ?? "",
                            city: city.text,
                            address: location.text,
                            userId: AccountState.userDetails!.userId!,
                            details: bookNotes.text,
                            email: AccountState.userDetails!.email!,
                          bookingDate: formattingDateTime
                        );
                        NavManager(context).navPush(const BookSummery());
                      } else {
                        ShowCustom(context)
                            .showSnack(S.of(context).pleasAddRequiredField);
                      }}catch(e){
                        ShowCustom(context)
                            .showSnack(e.toString());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCountryChange(CountryCode? v) {
    if (v != null) {
      country.text = v!.name!;
      countryCode.text = v!.dialCode!;
    }
  }
}
