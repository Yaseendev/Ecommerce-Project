part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchData extends SearchEvent {
  final String searchTxt;
  final SearchCriteria? searchCriteria;

  FetchSearchData({
    required this.searchTxt,
    this.searchCriteria,
  });

  @override
  List<Object?> get props => [searchTxt, searchCriteria];
}

class FetchSearchHistory extends SearchEvent {
  List<Object?> get props => [];
}