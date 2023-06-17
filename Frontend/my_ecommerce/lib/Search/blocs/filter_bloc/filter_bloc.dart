import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Search/data/repositories/search_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final SearchRepository searchRepository = locator.get<SearchRepository>();

    on<FetchFilterData>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(FilterLoading());
        await searchRepository.fetchSearchFilter().then((value) => value.fold(
            (l) => emit(FilterError()),
            (r) => emit(FilterReady(allBrands: r))));
      } else {
        emit(FilterNoInternet());
      }
    });
  }
}
