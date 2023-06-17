import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:my_ecommerce/Account/data/repositories/account_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'initroute_event.dart';
part 'initroute_state.dart';

class InitrouteBloc extends Bloc<InitrouteEvent, InitrouteState> {
  InitrouteBloc() : super(InitrouteInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final AccountRepository accoountRepository =
        locator.get<AccountRepository>();
    on<InitrouteEvent>((event, emit) async {
      final connStatus = await connectivity.checkConnectivity();
      if (event is UserCheckEvent) {
        emit(InitrouteInitial());
        if (connStatus != ConnectivityResult.none) {
          await accoountRepository.tokenCheck().then((value) {
            value.fold(
                (l) => l.message == 'No Token'
                    ? emit(InitrouteNoToken())
                    : emit(InitrouteInValidToken()),
                (r) => emit(InitrouteValidToken(user: r)));
          }).onError((error, stackTrace) {
            emit(InitrouteError());
          });
        } else
          emit(InitrouteNoInternet());
      }
    });
  }

  @override
  void onChange(Change<InitrouteState> change) {
    print(change);
    super.onChange(change);
  }
}
