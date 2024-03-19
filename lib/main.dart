import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/language/app_language_cubit.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:need/bl/blocs/theme/app_theme_state.dart';
import 'package:need/ui/views/accounts/login.dart';
import 'package:need/ui/views/app_navigation.dart';

import 'generated/l10n.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppTheme()),
        BlocProvider(create: (context) => AppLanguageCubit()),
        BlocProvider(create: (context) => AccountCubit()),
        BlocProvider(create: (context) => ServiceCubit()),
      ],
      child: BlocBuilder<AppTheme,AppThemeState>(
        builder: (context, state) {
          return BlocBuilder<AppLanguageCubit, Locale>(
            builder: (context, state) {
              return MaterialApp(
                locale: const Locale("en"),
                title: 'Need Customer',
                debugShowCheckedModeBanner: false,
                theme: BlocProvider
                    .of<AppTheme>(context)
                    .state
                    .appTheme,
                localizationsDelegates: const [
                  S.delegate, // Add this line
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('ar'), // Spanish
                ],
                routes: {"/": (context) => const LoginScreen(),

                  "/home": (context) => const AppNavBar()},
                initialRoute: "/",
              );
            },
          );
        },
      ),
    );
  }
}
