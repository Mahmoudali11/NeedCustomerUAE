part of 'service_cubit.dart';

enum LatestServiceE {
  getServiceCat,
  searching,
  bookService,
  getUserEnquires,
  getOffers,
  updatePayStatus,

}

class ServiceState {
  late ReqStatus reqStatus;
  ServiceCategoryM? serviceCategoryM;
  dynamic errorMessage;

  LatestServiceE? latestServiceE;
  bool isSearching;
  List<Datum>? search;
  OffersRes? offersRes;
  SaveInqRes? saveInqRes;
  AllUserEnquiries? allUserEnquiries;
  static Data? selectedSavedEnq;

  ServiceState(
      {this.latestServiceE,
      this.serviceCategoryM,
      required this.reqStatus,
      this.isSearching = false,
        this.offersRes,
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
        OffersRes? offersRes,
      AllUserEnquiries? allUserEnquiries,
      LatestServiceE? latestServiceE}) {
    return ServiceState(
        reqStatus: reqStatus,
        errorMessage: errorMessage,
        saveInqRes: saveInqRes,
        offersRes: offersRes??this.offersRes,
        allUserEnquiries: allUserEnquiries??this.allUserEnquiries,
        isSearching: isSearching ?? this.isSearching,
        serviceCategoryM: serviceCategoryM ?? this.serviceCategoryM,
        search: search,
        latestServiceE: latestServiceE ?? latestServiceE);
  }
}
