part of 'account_cubit.dart';

enum LatestAcE { edit, registerReq, login,resetPassword }

class AccountState {
  ReqStatus reqStatus;
  bool canEdit = false;
  LatestAcE? latestAcE;
  LoginRes? loginRes;
  String? errorMessage;

  static UserDetails? get userDetails => _userDetails;
  static UserDetails? _userDetails;

  static setUserDetails(UserDetails userDetails) {
    _userDetails = userDetails;
  }

  AccountState(
      {required this.reqStatus,
      this.canEdit = false,
      this.latestAcE,
      this.errorMessage,
      this.loginRes});

  AccountState copyWith({
    required ReqStatus reqStatus,
    bool? canEdit,
    String? errorMessage,
    LoginRes? loginRes,
    required LatestAcE latestAcE,
  }) {
    return AccountState(
        reqStatus: reqStatus,
        errorMessage: errorMessage,
        canEdit: canEdit ?? this.canEdit,
        loginRes: loginRes ?? this.loginRes,
        latestAcE: latestAcE);
  }
}
