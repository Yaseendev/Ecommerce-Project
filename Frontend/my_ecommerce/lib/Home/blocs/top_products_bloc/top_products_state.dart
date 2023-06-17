part of 'top_products_bloc.dart';

abstract class TopProductsState extends Equatable {
  const TopProductsState();
  
  @override
  List<Object?> get props => [];
}

class TopProductsInitial extends TopProductsState {}

class TopProductsLoading extends TopProductsState {}

class TopProductsLoaded extends TopProductsState {
  final List<Product> products;

  TopProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

class TopProductsError extends TopProductsState {
  final String? msg;

  TopProductsError([this.msg]);

  @override
  List<Object?> get props => [msg];
}