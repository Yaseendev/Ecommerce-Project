import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Search/data/models/search_criteria.dart';
import 'package:my_ecommerce/Search/data/repositories/search_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final SearchRepository searchRepository = locator.get<SearchRepository>();

    on<FetchSearchData>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(SearchLoading());
        await searchRepository.searchProducts(event.searchTxt,searchCriteria: event.searchCriteria).then((value) =>
            value.fold((l) => emit(SearchError(l.message)),
                (values) => emit(SearchLoaded(values))));
      } else {
        emit(SearchNoInternet());
      }
    });

    on<FetchSearchHistory>((event, emit) async {
      await searchRepository.fetchSearchHistory().then((value) => value.fold(
          (l) => emit(SearchError(l.message)),
          (values) => emit(SearchHistoryLoaded(values))));
    });
  }
}
