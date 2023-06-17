import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:my_ecommerce/Account/data/repositories/account_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'account_info_event.dart';
part 'account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  AccountInfoBloc() : super(AccountInfoInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AccountRepository accoountRepository =
        locator.get<AccountRepository>();
        
    on<EditAccount>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AccountInfoLoading());
          await accoountRepository
            .editUser(event.user)
            .then((value) => value.fold(
                (left) => emit(AccountInfoError(left.message)),
                (right) => emit(AccountInfoEdited(user: right))))
            .onError((error, stackTrace) {
          print(error);
          emit(AccountInfoError(error.toString()));
        });
      } else {
        emit(AccountInfoNoInternet());
      }
    });
  }
}
