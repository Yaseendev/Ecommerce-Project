import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Account/data/models/name.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:my_ecommerce/Account/data/repositories/account_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AccountRepository accoountRepository =
        locator.get<AccountRepository>();
    on<SingUpEvent>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AccountLoading());
        await accoountRepository
            .signupUser(
                User(name: event.name, email: event.email), event.password)
            .then((value) => value.fold(
                (left) => emit(AccountError(left.message)),
                (right) => emit(AccountLoggedIn(right))))
            .onError((error, stackTrace) {
          print(error);
          emit(AccountError(error.toString()));
        });
      } else {
        emit(AccountNoInternet());
      }
    });

    on<SingInEvent>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(AccountLoading());
        await accoountRepository
            .signinUser(event.email, event.password)
            .then((value) => value.fold(
                (left) => emit(AccountError(left.message)),
                (right) => emit(AccountLoggedIn(right))))
            .onError((error, stackTrace) {
          print(error);
          emit(AccountError(error.toString()));
        });
      } else {
        emit(AccountNoInternet());
      }
    });

    on<LoadUserProfileEvent>((event, emit) async {
      emit(AccountLoggedIn(event.user));
    });

    on<ResetPasswordEvent>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        await accoountRepository
            .resetPassword(event.email)
            .then((value) => value.fold(
                (left) => emit(AccountError(left.message)),
                (right) => emit(AccountEmailSent())))
            .onError((error, stackTrace) {
          print(error);
          emit(AccountError(error.toString()));
        });
      } else {
        emit(AccountNoInternet());
      }
    });
  }
}
