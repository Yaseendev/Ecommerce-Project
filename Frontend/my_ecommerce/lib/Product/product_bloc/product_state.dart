part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}
class ProductError extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}
class ProductNoInternet extends ProductState {}