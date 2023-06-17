part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoaded extends SearchState {
  final List<Product> products;

  SearchLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchHistoryLoaded extends SearchState {
  final ValueListenable<Box<String>> history;

  SearchHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class SearchNoInternet extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchError extends SearchState {
  final String? msg;

  SearchError([this.msg]);

  @override
  List<Object?> get props => [msg];
}
