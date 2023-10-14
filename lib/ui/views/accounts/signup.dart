import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:need/constans/keys.dart';
import 'package:need/ui/views/app_navigation.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/password-form-field.dart';
import 'package:need/utils/navigations.dart';

import '../../../bl/blocs/theme/app_theme_cubit.dart';
 import '../../../generated/l10n.dart';
import '../../../utils/validation.dart';
import '../../widgets/common.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_form-fild.dart';
import 'package:map_location_picker/map_location_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController(text: "Abu Dhabi");
  TextEditingController country = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController location = TextEditingController();
  final fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final navManager = NavManager(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Sign Up",
      ),
      body: Container(
        padding: AppTheme.paddingMarginM.copyWith(top: 0),
        width: double.maxFinite,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0),
          child: Form(
            key: fKey,
            child: Column(
              children: [
                CustomFormField(
                  controller: username,
                  hint: S.of(context).username,
                  validator: Validator.isValidName,
                  errorMessage:
                      "${S.of(context).username} ${S.of(context).isNotValid}",
                ),
                CustomFormField(
                    controller: email,
                    hint: S.of(context).email,
                    errorMessage:
                        "${S.of(context).email} ${S.of(context).isNotValid}",
                    validator: Validator.isValidEmail),
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
                CustomFormField(
                    controller: country,
                    isReadOnly: true,
                    hint: S.of(context).country,
                    validator: Validator.isValidName),
                Padding(
                  padding: AppTheme.paddingMarginS,
                  child: DropdownButton(
                      iconEnabledColor: AppTheme.mainColor,
                      isExpanded: true,
                      hint: Text(
                        city.text,
                        style: textTheme.bodyLarge,
                      ),
                      items: ["Abu Dhabi", "Dubai"]
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
                PasswordTextField(
                  controller: password,
                  errorMessage:
                      "${S.of(context).password} ${S.of(context).isNotValid}",
                  hint: S.of(context).password,
                  validator: Validator.isValidPassword,
                ),
                PasswordTextField(
                  controller: confirmPassword,
                  errorMessage:
                      "${S.of(context).confirmPassword} ${S.of(context).isNotValid}",
                  hint: S.of(context).confirmPassword,
                  validator: Validator.isValidPassword,
                ),
                CustomFormField(
                  controller: location,
                  isReadOnly: true,
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
                                navManager.popCurrent();
                              }
                            },
                          );
                        });
                  },
                ),
                MainButton(
                  name: S.of(context).register,
                  action: () {
                    if (fKey.currentState?.validate() == true) {
                      navManager.navPush(const AppNavBar());
                    }
                  },
                ),
                const VerticalSpace(spaceType: SpaceType.m),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Powered by www.need.ae",
                      style: textTheme.titleLarge
                          ?.copyWith(color: AppTheme.secondColor),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCountryChange(v) {
    if (v != null) {
      country.text = v!.name!;
      countryCode.text = v!.code!;
    }
  }
}
