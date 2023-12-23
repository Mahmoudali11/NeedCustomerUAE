import 'package:flutter/material.dart';
import 'package:need/ui/views/home/home.dart';
import 'package:need/ui/views/booking/book_service.dart';
import 'package:need/ui/widgets/c_app_bar.dart';
import 'package:need/ui/widgets/custom_buttons.dart';
import 'package:need/utils/navigations.dart';

import '../../../bl/blocs/theme/app_theme_cubit.dart';
import '../../../generated/l10n.dart';
import '../../widgets/app_common.dart';
import '../../widgets/common.dart';

class SubServices extends StatefulWidget {
  const SubServices({super.key});

  @override
  State<SubServices> createState() => _SubServicesState();
}

class _SubServicesState extends State<SubServices> {
  TextEditingController search = TextEditingController();
  late  Size mq;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    mq=MediaQuery.sizeOf(context);

  }
  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    final allService = [
      "Electrical Work",
      "Electrical Work",
      "Electrical Work",
      "Electrical Work",
      "Electrical Work",
      "Electrical Work",
      "Electrical Work",


    ];
    return Scaffold(
      appBar: CustomAppBar( title: S.of(context).subServices,),
      body: Container(
        padding: AppTheme.paddingMarginM,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchWidget(search: search),
            Titles(textTheme: textTheme, name:  S.of(context).chooseYourService),
            Expanded(
              child: ListView(
                  children: allService.map((e) => Container(
                    height:mq.height*.13 ,
                    margin: AppTheme.paddingMarginES,
                    padding: AppTheme.paddingMarginES,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppTheme.borderRS),
                        border: Border.all( color: AppTheme.mainColor)),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          CustomCachedNImg(h:double.maxFinite,w: mq.width*.3,),
                    const     HorizontalSpace(spaceType: SpaceType.es),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e,style:textTheme.headlineMedium?.copyWith(

                                color: AppTheme.secondColor
                            )

                              ,),
                          const   VerticalSpace(spaceType: SpaceType.es),

                             SizedBox(
                              width: mq.width*.43,
                              height: mq.height*.05,
                              child: MainButton(name: S.of(context).bookService
                                ,action: (){
                            NavManager(context).navPush(const BookService());
                              },padding:const EdgeInsets.all(0),),
                            )
                          ],
                        ),
                      ],
                    ),
                  )).toList()),
            ),

          ],
        ),
      ),
    );
  }
}
