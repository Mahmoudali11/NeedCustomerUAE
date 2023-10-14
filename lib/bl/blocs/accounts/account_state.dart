part of 'account_cubit.dart';

enum LatestAcE { edit }

class AccountState {
  ReqStatus reqStatus;
  bool canEdit = false;
  LatestAcE? latestAcE;

  AccountState(
      {required this.reqStatus, this.canEdit = false, LatestAcE? latestAcE});

  AccountState copyWith(
      {required ReqStatus reqStatus,
      bool? canEdit,
      required LatestAcE latestAcE}) {
    return AccountState(
        reqStatus: reqStatus,
        canEdit: canEdit ?? this.canEdit,
        latestAcE: latestAcE);
  }
}
