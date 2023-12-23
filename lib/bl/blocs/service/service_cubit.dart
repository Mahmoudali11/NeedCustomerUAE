import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:need/bl/blocs/accounts/account_cubit.dart';
import 'package:need/bl/modles/logi_res.dart';
import 'package:need/bl/modles/save_enquiry_req.dart';
import 'package:need/bl/modles/save_inq_res.dart';
import 'package:need/bl/modles/service_cat_m_res.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/data_service/local/pref_manager.dart';
import 'package:need/data_service/remote/service_rep.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceState(reqStatus: ReqStatus.notLaunched));
  final _serviceRep = ServiceRep();

  String? get selectedServiceId => _selectedServiceId;
  String? _selectedServiceId;

  SaveEnquiryReq? get saveEnquiryReq => _saveEnquiryReq;
  SaveEnquiryReq? _saveEnquiryReq;

  set setSaveReq(SaveEnquiryReq saveEnquiryReq) {
    _saveEnquiryReq = saveEnquiryReq;
  }

  String? get serName => _servName;
  String? _servName;

  set serServName(String name) {
    _servName = name;
  }

  set setServiceId(String v) {
    _selectedServiceId = v;
  }

  getServiceCategory() async {
    try {
      emit(state.copyFrom(
          reqStatus: ReqStatus.inProgress,
          latestServiceE: LatestServiceE.getServiceCat));
      var res = await _serviceRep.getServiceCat();

      if (res is ServiceCategoryM) {
        emit(state.copyFrom(
            reqStatus: ReqStatus.success,
            serviceCategoryM: res,
            latestServiceE: LatestServiceE.getServiceCat));
      }
    } catch (e) {
      emit(state.copyFrom(
          reqStatus: ReqStatus.fail,
          latestServiceE: LatestServiceE.getServiceCat,
          errorMessage: e.toString()));
    }
  }


  saveEnquiry(SaveEnquiryReq model) async {
    try {
      emit(state.copyFrom(
          reqStatus: ReqStatus.inProgress,
          latestServiceE: LatestServiceE.bookService));
      var res = await _serviceRep.saveEnquiry(model);

      if (res is SaveInqRes) {
        emit(state.copyFrom(
            reqStatus: res.success == 1 ? ReqStatus.success : ReqStatus.fail,
            errorMessage: res.message,
            saveInqRes: res,
            latestServiceE: LatestServiceE.bookService));
      }
      else {
        emit(state.copyFrom(
            reqStatus: ReqStatus.fail,
            latestServiceE: LatestServiceE.bookService,
            errorMessage: res.toString()
        ));
      }
    } catch (e) {
      emit(state.copyFrom(
          reqStatus: ReqStatus.fail,
          latestServiceE: LatestServiceE.bookService,
          errorMessage: e.toString()));
    }
  }

  filterCategory(String? name) {
    if (state.serviceCategoryM != null && name != null && name.isNotEmpty) {
      emit(state.copyFrom(
          reqStatus: ReqStatus.success,
          isSearching: true,
          search: state.serviceCategoryM?.data
              .where((element) =>
              element.serviceName.toLowerCase().contains(name.toLowerCase()))
              .toList(),
          latestServiceE: LatestServiceE.searching));
    } else {
      emit(state.copyFrom(
          reqStatus: ReqStatus.success,
          isSearching: false,
          latestServiceE: LatestServiceE.searching));
    }
  }


}
