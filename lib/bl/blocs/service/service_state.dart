part of 'service_cubit.dart';

enum LatestServiceE {
  getServiceCat,
  searching,
  bookService
}

class ServiceState {
  late ReqStatus reqStatus;
  ServiceCategoryM? serviceCategoryM;
  dynamic errorMessage;
  LatestServiceE? latestServiceE;
  bool isSearching;
   List<Datum>? search;
   SaveInqRes? saveInqRes;

  ServiceState(
      {this.latestServiceE,
      this.serviceCategoryM,
      required this.reqStatus,
      this.isSearching = false,
      this.search ,
        this.saveInqRes,
      this.errorMessage});

  ServiceState copyFrom(
      {required ReqStatus reqStatus,
      dynamic errorMessage,
      ServiceCategoryM? serviceCategoryM,
      bool? isSearching,
      List<Datum>? search,
        SaveInqRes? saveInqRes,
       LatestServiceE? latestServiceE}) {
    return ServiceState(
        reqStatus: reqStatus,
         errorMessage: errorMessage,
        saveInqRes: saveInqRes,
        isSearching: isSearching ?? this.isSearching,
        serviceCategoryM: serviceCategoryM ?? this.serviceCategoryM,
        search: search ,
        latestServiceE: latestServiceE ?? latestServiceE);
  }
}
