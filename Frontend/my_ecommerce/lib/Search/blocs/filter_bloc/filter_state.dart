part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}

class FilterReady extends FilterState {
  final List<String> allBrands;

  FilterReady({
    required this.allBrands,
  });

  @override
  List<Object> get props => [allBrands];
}

class FilterLoading extends FilterState {}

class FilterError extends FilterState {}

class FilterNoInternet extends FilterState {}