import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/blocs/service/service_cubit.dart';
import 'package:need/bl/blocs/theme/app_theme_cubit.dart';
import 'package:need/bl/modles/service_cat_m_res.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/ui/views/booking/book_service.dart';
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
  late ServiceCubit serviceCubit;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    mq = MediaQuery.sizeOf(context);
  }

  @override
  void initState() {
    serviceCubit = BlocProvider.of<ServiceCubit>(context);
    serviceCubit.getServiceCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchWidget(search: search,onChange: serviceCubit.filterCategory,),
        Titles(textTheme: textTheme, name: S.of(context).chooseCategory),
        Expanded(
          child: BlocBuilder<ServiceCubit, ServiceState>(
            buildWhen: (o,n)=>n.latestServiceE==LatestServiceE.getServiceCat||
            n.latestServiceE==LatestServiceE.searching,
            builder: (context, state) {
              if(state.reqStatus==ReqStatus.inProgress){
                
                
                return const CustomProgressInd();
              }

              if(state.reqStatus==ReqStatus.success){
           var listCat=state.isSearching?state.search: state.serviceCategoryM?.data;
           
            if(listCat==null ||listCat.isEmpty  ){
              
              return Center(child: Text(S.of(context).noDataFount),);
            }
              return ListView(
                  children:
                  (listCat??<Datum>[]).map((e) => GestureDetector(
                            onTap: () {
                              serviceCubit.setServiceId=e.id;
                              NavManager(context).navPush(const BookService());
                            },
                            child: Container(
                              height: mq.height * .11,
                              margin: AppTheme.paddingMarginES,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.borderRS),
                                  border:
                                      Border.all(color: AppTheme.mainColor)),
                              child: Center(
                                  child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.settings,
                                    color: AppTheme.mainColor,
                                    size: 30,
                                  ),
                                  const HorizontalSpace(
                                      spaceType: SpaceType.es),
                                  Flexible(
                                    child: Text(
                                      e.serviceName,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.bodyLarge
                                          ?.copyWith(color: AppTheme.secondColor),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ))
                      .toList());}
              
              return   Center(child: Text(S.of(context).somethingError),);
            },
          ),
        ),
      ],
    );
  }
}


