import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/constans/keys.dart';
import 'package:need/ui/views/accounts/update_password.dart';
import 'package:need/ui/views/app_navigation.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/password-form-field.dart';
import 'package:need/ui/widgets/show_custom.dart';
import 'package:need/utils/file_manager.dart';
import 'package:need/utils/navigations.dart';

import '../../../bl/blocs/theme/app_theme_cubit.dart';
import '../../../generated/l10n.dart';
import '../../../utils/validation.dart';
import '../../widgets/common.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_form-fild.dart';
import 'package:map_location_picker/map_location_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController(text: "Abu Dhabi");
  TextEditingController country = TextEditingController();
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController location = TextEditingController();
  late AccountCubit accountCubit;
  final fKey = GlobalKey<FormState>();
  bool change = false;

  @override
  void initState() {
    super.initState();
    accountCubit = BlocProvider.of<AccountCubit>(context);
  }

  @override
  void dispose() {
    change = false;
    super.dispose();
  }
   File? file;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    final navManager = NavManager(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 0),
      child: Form(
        key: fKey,
        child: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            return GestureDetector(
              onDoubleTap: !accountCubit.state.canEdit
                  ? () {
                      ShowCustom(context).showSnack("Press on edit button");
                    }
                  : null,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async{
                         FileManager.pickImage().then((value) {
                           setState(() {
                             file=value;
                           });
                         });
                    },
                    child: CircleAvatar(
                      backgroundImage: file==null? const AssetImage(
                        "assets/logo.png",
                      ):FileImage(
                       file!,
                      ) as ImageProvider,
                      backgroundColor: Colors.transparent,
                      radius: mq.width * .15,
                    ),
                  ),
                  CustomFormField(
                    controller: username,
                    isReadOnly: !accountCubit.state.canEdit,
                    hint: S.of(context).username,
                    validator: Validator.isValidName,
                    errorMessage:
                        "${S.of(context).username} ${S.of(context).isNotValid}",
                  ),
                  CustomFormField(
                      controller: email,
                      isReadOnly: !accountCubit.state.canEdit,
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
                        onChanged: !accountCubit.state.canEdit
                            ? null
                            : onCountryChange,
                      ),
                      Expanded(
                        child: CustomFormField(
                            isReadOnly: !accountCubit.state.canEdit,
                            inputType: TextInputType.phone,
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
                    onTap: (){
                      NavManager(context).navPush(const UpdatePassword());
                    },
                    controller: password,
                    isReadOnly: true,
                    errorMessage:
                        "${S.of(context).password} ${S.of(context).isNotValid}",
                    hint: S.of(context).password,

                    validator: Validator.isValidPassword,

                  ),

                  CustomFormField(
                    controller: location,
                    isReadOnly: true,
                    iconData: Icons.add_location_alt,
                    hint: S.of(context).selectYouLocation,
                    maxLines: 5,
                    onTap: !accountCubit.state.canEdit
                        ? null
                        : () {
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
                    name: S.of(context).update,
                    action: !accountCubit.state.canEdit
                        ? null
                        : () {
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
            );
          },
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