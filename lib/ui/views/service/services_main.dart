import 'package:flutter/material.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/ui/views/service/service_sub.dart';
import 'package:need/ui/widgets/app_common.dart';
import 'package:need/ui/widgets/common.dart';
import 'package:need/utils/navigations.dart';

import '../../../generated/l10n.dart';

class ServiceCategory extends StatefulWidget {
  const ServiceCategory({super.key});

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  TextEditingController search = TextEditingController();
  late Size mq;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    mq = MediaQuery.sizeOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final allService = [
      "Home Facilities",
      "Technical Services",
      "IT/Smart Services",
      "Repairing Services",
      "Other Services"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchWidget(search: search),
        Titles(textTheme: textTheme, name:S.of(context).chooseCategory),
        Expanded(
          child: ListView(
              children: allService
                  .map((e) => GestureDetector(
                onTap: (){
                  NavManager(context).navPush(SubServices());
                },
                    child: Container(
                          height: mq.height * .11,
                          margin: AppTheme.paddingMarginES,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(AppTheme.borderRS),
                              border: Border.all(color: AppTheme.mainColor)),
                          child: Center(
                              child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.settings,
                                color: AppTheme.mainColor,
                                size: 30,
                              ),
                              const HorizontalSpace(spaceType: SpaceType.es),
                              Text(
                                e,
                                style: textTheme.headlineMedium
                                    ?.copyWith(color: AppTheme.secondColor),
                              ),
                            ],
                          )),
                        ),
                  ))
                  .toList()),
        ),
      ],
    );
  }
}
