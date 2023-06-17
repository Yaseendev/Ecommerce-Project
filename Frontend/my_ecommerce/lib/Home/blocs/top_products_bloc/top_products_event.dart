part of 'top_products_bloc.dart';

abstract class TopProductsEvent extends Equatable {
  const TopProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopRated extends TopProductsEvent {}