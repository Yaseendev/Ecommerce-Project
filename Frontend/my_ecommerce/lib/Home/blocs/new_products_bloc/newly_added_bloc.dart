import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Home/data/repositories/home_repository.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'newly_added_event.dart';
part 'newly_added_state.dart';

class NewlyAddedBloc extends Bloc<NewlyAddedEvent, NewlyAddedState> {
  NewlyAddedBloc() : super(NewlyAddedInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final HomeRepository repository = locator.get<HomeRepository>();
    on<FetchNewlyAdded>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(NewlyAddedLoading());
        await repository
            .fetchNewlyAddedProducts()
            .then((value) => value.fold((l) => emit(NewlyAddedError()), (prods) {
                  emit(NewlyAddedLoaded(prods));
                }));
      } //TODO: Handle no internet
    });
  }
}
