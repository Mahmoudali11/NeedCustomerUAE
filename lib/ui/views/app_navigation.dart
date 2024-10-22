import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/constans/keys.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/ui/views/accounts/login.dart';
import 'package:need/ui/views/accounts/profile.dart';
import 'package:need/ui/views/booking/my_booking.dart';
import 'package:need/ui/views/home/home.dart';
import 'package:need/ui/views/service/services_main.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
 import '../../generated/l10n.dart';
import '../../utils/navigations.dart';


class AppNavBar extends StatefulWidget {
  const AppNavBar({super.key});

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  late List<Widget> items;
  late List<String> title;
  Timer? _timer;

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    title = [
      S.of(context).home,
      S.of(context).facilities,
      S.of(context).myBooking,
      S.of(context).profile,
    ];
    super.didChangeDependencies();
  }

  late AccountCubit accountCubit;
 Future checkSession()async{
   try{


     var session=await PrefManager.getValue(PrefManager.sessionTime);
    if(session==null){
      await PrefManager.setValue(PrefManager.sessionTime,DateTime.now().toIso8601String());
      session=await PrefManager.getValue(PrefManager.sessionTime);

    }

      _timer=Timer.periodic(const Duration(seconds: CKeys.checkEach), (timer) {
        debugPrint("check Session");

        var d=DateTime.now().difference(DateTime.parse(session!!));
        if(d.inDays>=CKeys.session){
          PrefManager.removeValue(PrefManager.sessionTime);
          PrefManager.removeValue(PrefManager.userDetails);
          debugPrint("Log out");

          NavManager(context).navPushAndRemoveUntil(const LoginScreen());

        }


      });

    }catch(e){
     debugPrint(e.toString());
   }
   }
  @override
  void initState() {
    accountCubit = BlocProvider.of<AccountCubit>(context);

    if(AccountState.isGuest){
      currentIndex=1;
    }
    items = const [
      HomeWidget(),
      ServiceCategory(),
      MyBooking(),
      Profile(),
    ];
    checkSession();
    super.initState();
  }




  onTapItem(int index) {
    if(AccountState.isGuest){
      if(index!=1){
       AccountState.isGuest=false;
        NavManager(context).navPushAndRemoveUntil(const LoginScreen());
      }
    }
    else{
      setState(() {
        currentIndex = index;
      });
    }

  }
@override
void dispose() {
   AccountState.isGuest=false;
_timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: title[currentIndex],
        actions: currentIndex == 3
            ? [
                IconButton(
                  icon: BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) {
                      return Icon(!state.canEdit ? Icons.edit : Icons.close);
                    },
                  ),
                  onPressed: () {
                    accountCubit.canEditEvent();
                  },
                ),
          IconButton(onPressed: (){

                AccountState.isGuest=false;

                PrefManager.removeValue(PrefManager.userDetails);
                NavManager(context).navPushRep(const LoginScreen());

          }, icon: Icon(Icons.exit_to_app))


              ]
            : null,
      ),
      body: Container(
          width: double.maxFinite,
          padding: AppTheme.paddingMarginL.copyWith(top: 15),
          child: items[currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: AppTheme.secondColor,
        selectedFontSize:Theme.of(context).textTheme.bodyMedium!.fontSize!,

        iconSize: Theme.of(context).textTheme.headlineSmall!.fontSize!,

        onTap: onTapItem,
        items: [
          BottomNavigationBarItem(
              label: title[currentIndex],
              icon: Icon(

                Icons.home,
                color: currentIndex == 0 ? AppTheme.mainColor : AppTheme.grey,
              )),
          BottomNavigationBarItem(
              label: title[currentIndex],
              icon: Icon(
                Icons.home_repair_service,
                color: currentIndex == 1 ? AppTheme.mainColor : AppTheme.grey,
              )),
          BottomNavigationBarItem(
              label: title[currentIndex],
              icon: Icon(
                Icons.book_online,
                color: currentIndex == 2 ? AppTheme.mainColor : AppTheme.grey,
              )),
          BottomNavigationBarItem(
              label: title[currentIndex],
              icon: Icon(
                Icons.person,
                color: currentIndex == 3 ? AppTheme.mainColor : AppTheme.grey,
              )),
        ],
      ),
    );
  }
}
