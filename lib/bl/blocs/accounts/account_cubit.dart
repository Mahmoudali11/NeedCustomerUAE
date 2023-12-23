import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:need/bl/modles/log_req.dart';
import 'package:need/bl/modles/logi_res.dart';
import 'package:need/bl/modles/register_req.dart';
import 'package:need/bl/modles/resetpass_Res.dart';
import 'package:need/bl/modles/resetpass_req.dart';
import 'package:need/constans/requst_status.dart';
import 'package:need/data_service/remote/acount_rep.dart';

import '../../../data_service/local/pref_manager.dart';
import '../../modles/register_res.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState(reqStatus: ReqStatus.notLaunched));

  final _accountRep = AccountsRep();

  canEditEvent() {
    emit(state.copyWith(
        reqStatus: ReqStatus.success,
        latestAcE: LatestAcE.edit,
        canEdit: !state.canEdit));
  }

  login(LoginReq req) async {
    try {
      emit(state.copyWith(
          reqStatus: ReqStatus.inProgress, latestAcE: LatestAcE.login));
      var res = await _accountRep.login(req);

      if (res is LoginRes) {
        emit(state.copyWith(
            reqStatus: res.success == 1 ? ReqStatus.success : ReqStatus.fail,
            loginRes: res,
            errorMessage: res.message,
            latestAcE: LatestAcE.login));
      } else {
        emit(state.copyWith(
            reqStatus: ReqStatus.fail,
            latestAcE: LatestAcE.login,
            errorMessage: res));
      }
    } catch (e) {
      emit(state.copyWith(
          reqStatus: ReqStatus.fail,
          latestAcE: LatestAcE.login,
          errorMessage: e.toString()));
    }
  }

  register(RegisterReq req) async {
    try {
      emit(state.copyWith(
          reqStatus: ReqStatus.inProgress, latestAcE: LatestAcE.registerReq));
      var res = await _accountRep.register(req);

      if (res is RegisterRes) {
        emit(state.copyWith(
            reqStatus: res.success == 1 ? ReqStatus.success : ReqStatus.fail,
            errorMessage: res.message,
            latestAcE: LatestAcE.registerReq));
      } else {
        emit(state.copyWith(
            reqStatus: ReqStatus.fail,
            latestAcE: LatestAcE.registerReq,
            errorMessage: res));
      }
    } catch (e) {
      emit(state.copyWith(
          reqStatus: ReqStatus.fail,
          latestAcE: LatestAcE.registerReq,
          errorMessage: e.toString()));
    }
  }



  resetPassword(ResetPassword req) async {
    try {
      emit(state.copyWith(
          reqStatus: ReqStatus.inProgress, latestAcE: LatestAcE.resetPassword));
      var res = await _accountRep.resetPassword(req);

      if (res is ResetPasswordRes) {
        emit(state.copyWith(
            reqStatus: res.success == 1 ? ReqStatus.success : ReqStatus.fail,
            errorMessage: res.message,
            latestAcE: LatestAcE.resetPassword));
      } else {
        emit(state.copyWith(
            reqStatus: ReqStatus.fail,
            latestAcE: LatestAcE.resetPassword,
            errorMessage: res));
      }
    } catch (e) {
      emit(state.copyWith(
          reqStatus: ReqStatus.fail,
          latestAcE: LatestAcE.resetPassword,
          errorMessage: e.toString()));
    }
  }
  getUserDetails() {
    PrefManager.getValue(PrefManager.userDetails).then((value) {
      if (value != null) {
        AccountState.setUserDetails(UserDetails.fromJson(jsonDecode(value)));
      }
    });
  }
}
