import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:need/constans/requst_status.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState(reqStatus: ReqStatus.notLaunched));


  canEditEvent(){

    emit( state.copyWith(reqStatus: ReqStatus.success, latestAcE: LatestAcE.edit,
        canEdit: !state.canEdit
    ));
  }
}
