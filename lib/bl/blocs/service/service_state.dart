part of 'service_cubit.dart';

enum LatestServiceE {
  getServiceCat,
  searching,
  bookService,
  getUserEnquires,
}

class ServiceState {
  late ReqStatus reqStatus;
  ServiceCategoryM? serviceCategoryM;
  dynamic errorMessage;

  LatestServiceE? latestServiceE;
  bool isSearching;
  List<Datum>? search;
  SaveInqRes? saveInqRes;
  AllUserEnquiries? allUserEnquiries;
  static Data? selectedSavedEnq;

  ServiceState(
      {this.latestServiceE,
      this.serviceCategoryM,
      required this.reqStatus,
      this.isSearching = false,
      this.search,
      this.saveInqRes,
      this.allUserEnquiries,
      this.errorMessage});

  ServiceState copyFrom(
      {required ReqStatus reqStatus,
      dynamic errorMessage,
      ServiceCategoryM? serviceCategoryM,
      bool? isSearching,
      List<Datum>? search,
      SaveInqRes? saveInqRes,
      AllUserEnquiries? allUserEnquiries,
      LatestServiceE? latestServiceE}) {
    return ServiceState(
        reqStatus: reqStatus,
        errorMessage: errorMessage,
        saveInqRes: saveInqRes,
        allUserEnquiries: allUserEnquiries??this.allUserEnquiries,
        isSearching: isSearching ?? this.isSearching,
        serviceCategoryM: serviceCategoryM ?? this.serviceCategoryM,
        search: search,
        latestServiceE: latestServiceE ?? latestServiceE);
  }
}
